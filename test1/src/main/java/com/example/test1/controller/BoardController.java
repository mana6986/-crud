package com.example.test1.controller;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.User;
import com.example.test1.dao.BoardService;
import com.example.test1.dao.CommentService;
import com.example.test1.dao.UserService;

import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.PathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;


@Controller
public class BoardController {

    private static final Logger log = LoggerFactory.getLogger(BoardController.class);
    @Autowired
    private CommentService commentService;
    @Autowired
    private BoardService boardService;
    @Autowired
    private UserService userService;
    private static final String UPLOAD_DIR = "C:/Users/joon/Downloads/spring1 (2)/test1/src/main/webapp/board_file/";
    
    @GetMapping("/download/{fileName}")
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
        String filePath = UPLOAD_DIR + fileName; // 보안적으로 검증된 경로 산정 로직 필요
        Path path = Paths.get(filePath).normalize();
        System.out.println("다운로드할 파일 경로: " + filePath); // 콘솔에 출력
        Resource resource = new FileSystemResource(path);

        if (resource.exists() && resource.isReadable()) {
            log.info("파일 다운로드 요청: {}", fileName); // 로그 추가
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                    .body(resource);
        } else {
            log.error("파일을 찾을 수 없음: {}", fileName); // 로그 추가
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }


   
   

    @PostMapping("/write")
    public ResponseEntity<?> write(@RequestParam("title") String title,
                                   @RequestParam("content") String content,
                                   @RequestParam(value = "file", required = false) MultipartFile file,
                                   HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            String userEmail = user.getEmail();
            // 게시글 객체 생성
            Board board = new Board();
            board.setEmail(userEmail);
            board.setTitle(title);
            board.setContent(content);
            board.setBoardDate(new Date(System.currentTimeMillis()));
            
            // 게시글 저장
            boardService.write(board);
            
            // 저장된 게시글의 postNumber를 다시 조회하여 가져옴
            BigDecimal postNumber = boardService.getPostNumber(board);
            session.setAttribute("currentPostNumber", postNumber);
            System.out.println("새로 생성된 게시글의 postNumber: " + postNumber);
            
            // 파일이 업로드된 경우 처리
            if (file != null && !file.isEmpty()) {
                try {
                    String fileName = file.getOriginalFilename();
                    File uploadFile = new File(UPLOAD_DIR + fileName);
                    file.transferTo(uploadFile); // 파일 저장
                    log.info("파일 업로드 완료: {}", fileName);
                    // 세션에서 postNumber를 가져와서 파일 정보를 DB에 저장
                    BigDecimal currentPostNumber = (BigDecimal) session.getAttribute("currentPostNumber");
                    boardService.insertFile(currentPostNumber, fileName);
                } catch (Exception e) {
                    // 파일 저장 또는 DB 업데이트시 에러 처리
                    log.error("파일 저장 또는 DB 업데이트 중 에러 발생: {}", e.getMessage());
                }
            } else {
                // 파일을 업로드하지 않은 경우 T_FILE 테이블에 POSTNUMBER 값만 저장하고 FILENAME은 NULL로 설정
                BigDecimal currentPostNumber = (BigDecimal) session.getAttribute("currentPostNumber");
                boardService.insertFile(currentPostNumber, null);
            }

            log.info("게시글 작성 완료: {}", title);
            return new ResponseEntity<>("게시글이 성공적으로 작성되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }
    }



    @GetMapping("/tables")
    public String showBoardList(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 10; // 한 페이지에 표시할 게시글 수
        int start = (page - 1) * pageSize + 1;
        int end = page * pageSize;

        Map<String, Integer> parameterMap = new HashMap<>();
        parameterMap.put("start", start);
        parameterMap.put("end", end);

        List<Board> boards = boardService.getBoardsWithUserInformation(parameterMap);
        int totalBoards = boardService.getTotalBoards();
        int totalPages = (int) Math.ceil((double) totalBoards / pageSize);

        model.addAttribute("boardList", boards);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "tables";
    }



    
    
    @GetMapping("/detail")
    public String showBoardDetail(@RequestParam("postNumber") BigDecimal postNumber, Model model) {
        Board board = boardService.getBoardByPostNumber(postNumber);
        if (board != null) {
            List<Comment> comments = commentService.retrieveCommentsByPostNumber(postNumber);
            int commentCount = commentService.getCommentCountByPostNumber(postNumber);
            String fileName = boardService.getFileNameByPostNumber(postNumber);

            model.addAttribute("board", board);
            model.addAttribute("comments", comments);
            model.addAttribute("commentCount", commentCount);
            model.addAttribute("fileName", fileName);
            model.addAttribute("content", comments);

            model.addAttribute("commentCountJS", commentCount);

            return "detail";
        } else {
            return "error";
        }
    }


   


    @GetMapping("/modify")
    public String getEditBoard(@RequestParam("postNumber") BigDecimal postNumber, Model model) {
        Board board = boardService.getBoardByPostNumber(postNumber);
        model.addAttribute("board", board);
        return "modify";  // 수정 내용을 입력할 수 있는 페이지로 이동
    }
    
  
    @GetMapping("/detail/{postNumber}")
    public String showBoardDetail(@PathVariable("postNumber") BigDecimal postNumber, Model model, HttpSession session) {
        // 세션에서 사용자의 이메일을 가져옵니다.
        String loggedInUserEmail = (String) session.getAttribute("email");

        // 게시글을 가져옵니다. 이 부분은 적절한 코드로 변경해야 합니다.
        Board board = boardService.getBoardByPostNumber(postNumber); 

        // 게시글과 사용자의 이메일을 모델에 추가합니다.
        model.addAttribute("board", board);
        model.addAttribute("loggedInUserEmail", loggedInUserEmail);

        return "detail"; // 게시글 상세 페이지로 이동합니다.
    }
    
  

    
    @PostMapping("/modify")
    public String editBoard(@RequestParam("postNumber") BigDecimal postNumber, @ModelAttribute Board board) {
        board.setPostNumber(postNumber);
        boardService.updateBoard(board);
        return "redirect:/tables";
    }
    @GetMapping("/count/{postNumber}")
    public ResponseEntity<Integer> getCommentCountByPostNumber(@PathVariable int postNumber) {
        try {
            BigDecimal bdPostNumber = BigDecimal.valueOf(postNumber);
            int commentCount = commentService.getCommentCountByPostNumber(bdPostNumber);
            return ResponseEntity.ok(commentCount);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(-1); // 에러 처리
        }
    }
    @DeleteMapping("/boards/{postNumber}")
    public ResponseEntity<?> deleteBoard(@PathVariable BigDecimal postNumber) {
        try {
            boardService.deleteBoard(postNumber); // Service 계층에서 게시글 삭제만 처리
            return ResponseEntity.ok().build(); // 성공 응답
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 삭제에 실패했습니다. 에러: " + e.getMessage());
        }
    }

  

    
    @GetMapping("/api/checkLoginStatus")
    public ResponseEntity<String> checkLoginStatus(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return ResponseEntity.ok("Logged in");
        } else {
            return ResponseEntity.ok("Not Logged in");
        }
    }
}
