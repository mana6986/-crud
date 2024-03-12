package com.example.test1.dao;
import org.apache.ibatis.annotations.Param;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.example.test1.model.Board;
import com.example.test1.model.User;


public interface BoardService {
	BigDecimal getPostNumber(Board board);
	String getFileNameByPostNumber(BigDecimal postNumber);
	  void write(Board board);
	    void insertFile(BigDecimal postNumber, String filename);
    List<Board> getAllBoards();
    Board getBoardByPostNumber(BigDecimal postNumber);
    void deleteBoardByPostNumber(BigDecimal postNumber);
    void deleteBoardByPostNumberAndUserEmail(BigDecimal postNumber, String userEmail);
    void updateBoard(Board board);
    void addComment(Board board);
    int getTotalBoards();
    List<Board> getBoards(int page, int pageSize);
    String storeFile(MultipartFile file);
    void insertFileWithPostNumber(BigDecimal postNumber, String fileName);
    Board saveBoard(Board board);
    void deleteBoard(BigDecimal postNumber);
    BigDecimal writeAndGetPostNumber(Board board);
	 void deleteBoardAndComments(BigDecimal postNumber);
}