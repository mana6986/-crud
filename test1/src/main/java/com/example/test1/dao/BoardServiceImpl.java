package com.example.test1.dao;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.mapper.CommentMapper;
import com.example.test1.model.Board;
import com.example.test1.model.User;
import com.example.test1.model.Comment;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.file.ConfigurationSource.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
    private BoardMapper boardMapper;
    @Autowired
    private CommentService commentService; // CommentService 주입

    @Override
    @Transactional
    public void deleteBoardAndComments(BigDecimal postNumber) {
        // 게시글과 관련된 모든 댓글 삭제
        // 게시글 삭제
        boardMapper.deleteBoard(postNumber);
    }
    
    @Override
    public void write(Board board) {
        boardMapper.insertPost(board);
    }

    @Override
    @Transactional
    public void insertFile(BigDecimal postNumber, String filename) {
        // 파일 이름이 제공되지 않은 경우 또는 파일이 업로드되지 않은 경우
        if (filename == null || filename.isEmpty()) {
            // 파일 이름을 null로 설정하여 DB에 저장합니다.
            boardMapper.insertFile(postNumber, null);
        } else {
            // 파일 이름이 제공된 경우 DB에 파일 정보를 저장합니다.
            boardMapper.insertFile(postNumber, filename);
        }
    }
    @Override
    public void updateCommentCount(BigDecimal postNumber, int increment) {
        boardMapper.updateCommentCount(postNumber, increment);
    }
    
    @Override
    public String getFileNameByPostNumber(BigDecimal postNumber) {
        return boardMapper.getFileNameByPostNumber(postNumber);
    }
    @Override
    public List<Board> getBoardsWithUserInformation(Map<String, Integer> parameterMap) {
        return boardMapper.getBoardsWithUserInformation(parameterMap);
    }
    @Override
    public BigDecimal getPostNumber(Board board) {
        // 주어진 게시글 정보를 기반으로 데이터베이스에서 postNumber를 조회합니다.
        BigDecimal postNumber = null; // 조회된 postNumber를 저장할 변수

        // 게시글의 기타 정보(예: 제목, 내용, 작성자 등)을 이용하여 적절한 조회 쿼리를 작성합니다.
        // 여기서는 제목(title)과 작성자(email)을 이용하여 조회한다고 가정합니다.
        String title = board.getTitle();
        String email = board.getEmail();

        try {
            postNumber = boardMapper.getPostNumberByTitleAndEmail(title, email);
        } catch (Exception e) {
            // 조회 중 오류가 발생할 경우 적절히 처리합니다.
            e.printStackTrace();
        }

        return postNumber;
    }

    
    @Override
    public List<Board> getAllBoards() {
        return boardMapper.getAllBoards(); // 모든 게시물을 가져오는 매퍼 메서드 호출
    }
    @Override
    public Board getBoardByPostNumber(BigDecimal postNumber) {
        return boardMapper.getBoardByPostNumber(postNumber);
    }
    @Override
    public void deleteBoardByPostNumber(BigDecimal postNumber) {
    	  boardMapper.deleteBoardByPostNumber(postNumber);
    }
    

    @Override
    public void deleteBoardByPostNumberAndUserEmail(BigDecimal postNumber, String userEmail) {
        boardMapper.deleteBoardByPostNumberAndUserEmail(postNumber, userEmail);
    }
    

    @Override
    public void updateBoard(Board board) {
        boardMapper.updateBoard(board);
    }

 

    
    @Override
    public void addComment(Board board) {
        boardMapper.addComment(board);
    }
    @Override
    public int getTotalBoards() {
        return boardMapper.getTotalBoards();
    }

    @Override
    public List<Board> getBoards(int start, int end) {
        return boardMapper.getBoards(start, end);
    }

    @Override
    public String storeFile(MultipartFile file) {
        // 파일 저장 로직 구현
        return "stored-file-name.jpg"; // 저장된 파일의 이름 반환
    }

    @Override
    @Transactional
    public void deleteBoard(BigDecimal postNumber) {
        boardMapper.deleteBoard(postNumber);
    }

    @Override
    public void insertFileWithPostNumber(BigDecimal postNumber, String fileName) {
        boardMapper.insertFileWithPostNumber(postNumber, fileName);
    }
    @Override
    @Transactional
    public Board saveBoard(Board board) {
        boardMapper.insertBoard(board);
        // insertBoard 메소드 실행 후, MyBatis 또는 JPA가 자동으로 생성된 ID를 board 객체에 설정
        return board;
    }

    @Override
    public BigDecimal writeAndGetPostNumber(Board board) {
        write(board); // 게시글을 작성하고 DB에 저장합니다.
        return board.getPostNumber(); // 저장된 게시글의 postNumber를 반환합니다.
    }
  
}

