package com.example.test1.dao;

import java.math.BigDecimal;
import java.util.List;

import com.example.test1.model.Comment;

public interface CommentService {
    Comment retrieveComment(int commentId);
    List<Comment> retrieveAllComments();
    void updateComment(BigDecimal commentId, String content);
    void deleteComment(BigDecimal commentId);
    List<Comment> retrieveCommentsByPostNumber(BigDecimal postNumber);
    Comment registerReply(Comment comment);
    List<Comment> getComments(BigDecimal post_number);
    List<Comment> getReplies(BigDecimal parentCommentId);
    Comment registerComment(Comment comment);
    int getCommentCountByPostNumber(BigDecimal postNumber);
    Comment saveComment(Comment comment);
    void deleteCommentsByPostNumber(BigDecimal postNumber) throws Exception;
}

