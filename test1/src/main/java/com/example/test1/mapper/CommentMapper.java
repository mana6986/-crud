package com.example.test1.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.test1.model.Comment;
@Mapper
public interface CommentMapper {
    int insertComment(Comment comment);
    Comment selectComment(BigDecimal commentId);
    List<Comment> selectAllComments();
    void updateComment(@Param("commentId") BigDecimal commentId, @Param("content")String content);
    void deleteComment(BigDecimal commentId);
    List<Comment> retrieveCommentsByPostNumber(BigDecimal postNumber);
    List<Comment> selectComments(BigDecimal post_number);
    int insertReply(Comment comment);
    List<Comment> selectReplies(BigDecimal parentCommentId);
    int getCommentCountByPostNumber(@Param("postNumber") BigDecimal postNumber);
    void deleteCommentsByPostNumber(BigDecimal postNumber);
   
}