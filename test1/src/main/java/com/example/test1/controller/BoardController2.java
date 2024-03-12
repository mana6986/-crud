//package com.example.test1.controller;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;
//import com.example.test1.dao.BoardService;
//import com.example.test1.model.Board;
//import com.example.test1.model.User;
//import javax.servlet.http.HttpSession;
//import java.io.File;
//import java.math.BigDecimal;
//import java.time.format.DateTimeFormatter;
//import java.util.List;
//
//@Controller
//public class BoardController {
//
//    private static final Logger log = LoggerFactory.getLogger(BoardController.class);
//
//    @Autowired
//    private BoardService boardService;
//
//    private static final String UPLOAD_DIR = "C:/Users/joon/Downloads/spring1 (2)/test1/src/main/webapp/board_file/";
//
//    // 게시글 작성 처리
//    @PostMapping("/write")
//    public String write(@RequestParam("title") String title,
//                        @RequestParam("content") String content,
//                        @RequestParam("file") MultipartFile file,
//                        HttpSession session) {
//        User user = (User) session.getAttribute("user");
//        if (user != null) {
//            String userEmail = user.getEmail();
//            // Board 객체 생성
//            Board board = new Board(userEmail, title, content);
//            // 파일이 있을 경우 처리
//            if (!file.isEmpty()) {
//                try {
//                    String fileName = file.getOriginalFilename();
//                    File uploadFile = new File(UPLOAD_DIR + fileName);
//                    file.transferTo(uploadFile); // 파일 저장
//                    log.info("파일 업로드 완료: {}", fileName);
//                    // 파일 정보를 Board 객체에 추가
//                    board.setFilename(UPLOAD_DIR + fileName);
//                    // 파일 정보를 DB에 저장
//                    boardService.insertFile(board);
//                } catch (Exception e) {
//                    // 파일 저장 또는 DB 업데이트시 에러 처리
//                    log.error("파일 저장 또는 DB 업데이트 중 에러 발생: {}", e.getMessage());
//                }
//            }
//            // 게시글 작성
//            boardService.write(board);
//            log.info("게시글 작성 완료: {}", title);
//            return "redirect:/tables";
//        } else {
//            return "redirect:/login";
//        }
//    }
//
//    // 게시판 페이지
// // 게시판 페이지
//    @GetMapping("/tables")
//    public String showBoardList(Model model) {
//        List<Board> boardList = boardService.getAllBoards(); // 모든 게시물을 가져오는 메서드 호출
//        // boardList의 각 요소를 순회하며 값을 로그에 출력
//        for (Board board : boardList) {
////            log.info("Board Email: {}", board.getEmail());
////            log.info("Board Post Number: {}", board.getPostNumber());
////            log.info("Board Title: {}", board.getTitle());
//            if (board.getBoardDate() != null) {
//                log.info("Board Date: {}", board.getBoardDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
//            } else {
//                log.info("Board Date is null");
//            }
//            // 필요한 다른 속성들에 대해서도 출력을 추가할 수 있습니다.
//        }
////        model.addAttribute("boardList", boardt);
//        return "tables"; // 뷰의 이름 반환
//    }
//    @GetMapping("/detail")
//    public String showBoardDetail(@RequestParam("postNumber") BigDecimal postNumber, Model model) {
//        Board board = boardService.getBoardByPostNumber(postNumber); // postNumber에 해당하는 게시물을 가져오는 메서드 호출
//        if (board != null) {
//            model.addAttribute("board", board);
//            return "detail"; // 뷰의 이름 반환
//        } else {
//            return "error";
//        }
//    }
//
//    @GetMapping("/modify")
//    public String getEditBoard(@RequestParam("postNumber") BigDecimal postNumber, Model model) {
//        Board board = boardService.getBoardByPostNumber(postNumber);
//        model.addAttribute("board", board);
//        return "modify";  // 수정 내용을 입력할 수 있는 페이지로 이동
//    }
//    @GetMapping("/delete/{postNumber}")
//    public String deleteBoard(@PathVariable("postNumber") BigDecimal postNumber) {
//        boardService.deleteBoard(postNumber);
//        return "redirect:/tables";
//    }
//    
//    @GetMapping("/detail/{postNumber}")
//    public String showBoardDetail(@PathVariable("postNumber") BigDecimal postNumber, Model model, HttpSession session) {
//        // 세션에서 사용자의 이메일을 가져옵니다.
//        String loggedInUserEmail = (String) session.getAttribute("email");
//
//        // 게시글을 가져옵니다. 이 부분은 적절한 코드로 변경해야 합니다.
//        Board board = boardService.getBoardByPostNumber(postNumber); 
//
//        // 게시글과 사용자의 이메일을 모델에 추가합니다.
//        model.addAttribute("board", board);
//        model.addAttribute("loggedInUserEmail", loggedInUserEmail);
//
//        return "detail"; // 게시글 상세 페이지로 이동합니다.
//    }
//    @PostMapping("/modify")
//    public String editBoard(@RequestParam("postNumber") BigDecimal postNumber, @ModelAttribute Board board) {
//        board.setPostNumber(postNumber);
//        boardService.updateBoard(board);
//        return "redirect:/tables";
//    }
//
//  
//    }
//
//
//
