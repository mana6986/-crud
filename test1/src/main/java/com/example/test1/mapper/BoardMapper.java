package com.example.test1.mapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.tomcat.jni.FileInfo;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;


@Mapper
public interface BoardMapper {
	void insertPost(Board board);
    void insertFile(@Param("postNumber") BigDecimal postNumber, @Param("filename") String filename);
    String getFileNameByPostNumber(BigDecimal postNumber);
    BigDecimal getPostNumberByTitleAndEmail(@Param("title") String title, @Param("email") String email);
    List<Board> getAllBoards();
    Board getBoardByPostNumber(BigDecimal postNumber);
    Board boardEdit(BigDecimal postNumber);
    void deleteBoardByPostNumber(BigDecimal postNumber);
    void deleteBoardByPostNumberAndUserEmail(@Param("postNumber") BigDecimal postNumber, @Param("userEmail") String userEmail);
    void updateBoard(Board board);
    void addComment(Board board);
    void deleteBoardAndComments(BigDecimal postNumber);
    Integer getTotalBoards();
    List<Board> getBoards(@Param("start") int start, @Param("end") int end);
    Board getFileById(Long fileNo);
    List<Comment> getCommentsByPostNumber(BigDecimal postNumber);
    void deleteComment(BigDecimal commentId);
    void deleteBoard(BigDecimal postNumber);
    void deleteBoardWithComments(BigDecimal postNumber);
    void insertFileWithPostNumber(BigDecimal postNumber, String fileName);
    BigDecimal writeAndGetPostNumber(Board board); 
    void insertBoard(Board board);
    List<Board> getBoardsWithUserInformation(Map<String, Integer> parameterMap);
    List<Board> selectBoardsWithCommentsAndUserInfo(Map<String, Integer> parameterMap);
    void updateCommentCount(@Param("postNumber") BigDecimal postNumber, @Param("increment") int increment);
    }
