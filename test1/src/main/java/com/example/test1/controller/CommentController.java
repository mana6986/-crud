package com.example.test1.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.*;

import com.example.test1.dao.CommentService;
import com.example.test1.dao.UserService;
import com.example.test1.model.Comment;
import com.example.test1.model.User;


@RestController
@RequestMapping("/comments")
public class CommentController {
    private static final Logger logger = LoggerFactory.getLogger(CommentController.class);
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    
    @PostMapping("/comments/{postNumber}")
    private Comment registerComment(int postNumber,
                                    Integer parentCommentId,
                                    Comment comment, HttpSession session) {
        User user = (User) session.getAttribute("user");
        String email = user.getEmail();
        comment.setEmail(email);
        BigDecimal bdPostNumber = BigDecimal.valueOf(postNumber);
        comment.setpostNumber(bdPostNumber);

        System.out.println("Comment IDdsads: " + comment.getCommentId());
        System.out.println("Email: " + comment.getEmail());
        System.out.println("Content: " + comment.getContent());
        if (parentCommentId != null) {
            BigDecimal bdParentCommentId = BigDecimal.valueOf(parentCommentId);
            comment.setparentCommentId(bdParentCommentId);
        } else {
            comment.setparentCommentId(null);
        }

        Date date = Date.valueOf(LocalDateTime.now().toLocalDate());
        comment.setcreatedAt(date);
        comment = commentService.registerComment(comment);

        return comment;
    }
    @PostMapping("/{postNumber}")
    public Comment registerCommentWithoutParent(@PathVariable int postNumber,
    		@RequestBody Comment comment, HttpSession session) {
    	return registerComment(postNumber, null, comment, session);
    }
    
    @PostMapping("/{postNumber}/{parentCommentId}")
    public Comment registerCommentWithParent(@PathVariable int postNumber,
    		@PathVariable Integer parentCommentId,
    		@RequestBody Comment comment, HttpSession session) {
    	
    	// registerComment 메서드를 호출하여 부모 댓글 ID를 사용하여 댓글 등록
    	return registerComment(postNumber, parentCommentId, comment, session);
    }
 
    @Autowired
    private UserService userService;
    @GetMapping("/{postNumber}")
    public List<Comment> getComments(@PathVariable int postNumber) {
        BigDecimal postNumberBigDecimal = BigDecimal.valueOf(postNumber);
        List<Comment> comments = commentService.getComments(postNumberBigDecimal);

        // 각 댓글의 작성자 이름 가져와서 Comment 객체에 설정
        for (Comment comment : comments) {
            String userName = userService.getUserNameByEmail(comment.getEmail());
            comment.setName(userName);
        }

        logger.info("댓글 목록 조회 - 게시물 번호: {}", postNumber);
        return comments;
    }

    


    @GetMapping("/checkLoginStatus")
    public ResponseEntity<String> checkLoginStatus(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return ResponseEntity.ok("Logged in");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Not logged in");
        }
    }
	

    @PutMapping("/update/{commentId}")
    public ResponseEntity<?> updateComment(@PathVariable("commentId") BigDecimal commentId, @RequestBody Comment comment) {
        try {
            // 여기서 commentDTO는 댓글의 새로운 내용을 담는 객체입니다.
            // 해당 서비스 메서드로 댓글을 업데이트하는 로직 구현
            commentService.updateComment(commentId, comment.getContent());
            return ResponseEntity.ok().body("댓글이 수정되었습니다.");
        } catch (Exception e) {
            // 오류 처리 로직
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 수정 중 오류 발생");
        }
    }


    @DeleteMapping("/delete/{commentId}")
    public ResponseEntity<?> deleteComment(@PathVariable("commentId") BigDecimal commentId) {
        try {
            // 해당 서비스 메서드로 댓글을 삭제하는 로직 구현
            commentService.deleteComment(commentId);
            return ResponseEntity.ok().body("댓글이 삭제되었습니다.");
        } catch (Exception e) {
            // 오류 처리 로직
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("댓글 삭제 중 오류 발생");
        }
    }
    
//  // 대대댓글 수정 컨트롤러
    @PutMapping("/comments/update/{commentId}")
    public ResponseEntity<String> updateComment(@PathVariable Long commentId, @RequestBody Map<String, String> requestBody) {
        String newContent = requestBody.get("content");
        try {
            // 대대댓글 수정 로직을 여기에 구현합니다.
            // commentId를 사용하여 대대댓글을 찾고 newContent로 내용을 업데이트합니다.
            return ResponseEntity.ok("대대댓글이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("대대댓글 수정에 실패했습니다. 에러: " + e.getMessage());
        }
    }

    // 대대댓글 삭제 컨트롤러
    @DeleteMapping("/comments/delete/{commentId}")
    public ResponseEntity<String> deleteComment(@PathVariable Long commentId) {
        try {
            // 대대댓글 삭제 로직을 여기에 구현합니다.
            // commentId를 사용하여 대대댓글을 삭제합니다.
            return ResponseEntity.ok("대대댓글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("대대댓글 삭제에 실패했습니다. 에러: " + e.getMessage());
        }
    }

}

