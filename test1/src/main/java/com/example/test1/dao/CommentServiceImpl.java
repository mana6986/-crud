package com.example.test1.dao;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import com.example.test1.mapper.CommentMapper;
import com.example.test1.model.Comment;

@Service
public class CommentServiceImpl implements CommentService {
    private final CommentMapper commentMapper;

    public CommentServiceImpl(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }
    
   
    @Override
    public Comment registerComment(Comment comment) {
        commentMapper.insertComment(comment);
        return commentMapper.selectComment(comment.getCommentId());
    }

    @Override
    public Comment retrieveComment(int commentId) {
        return commentMapper.selectComment(BigDecimal.valueOf(commentId));
    }

    @Override
    public List<Comment> retrieveAllComments() {
        return commentMapper.selectAllComments();
    }
    @Override
    public int getCommentCountByPostNumber(BigDecimal postNumber) {
        return commentMapper.getCommentCountByPostNumber(postNumber);
    }
    @Override
    public void updateComment(BigDecimal commentId, String content) {
        commentMapper.updateComment(commentId, content);
    }
    
    
    @Override
    public void deleteComment(BigDecimal commentId) {
        commentMapper.deleteComment(commentId);
    }

    @Override
    public List<Comment> retrieveCommentsByPostNumber(BigDecimal postNumber) {
        return commentMapper.retrieveCommentsByPostNumber(postNumber);
    }

    @Override
    public Comment registerReply(Comment comment) {
        commentMapper.insertReply(comment);
        return commentMapper.selectComment(comment.getCommentId());
    }

    @Override
    public List<Comment> getComments(BigDecimal post_number) {
        return commentMapper.selectComments(post_number);
    }
    @Override
    public Comment saveComment(Comment comment) {
        commentMapper.insertComment(comment);
        return comment; // 새로운 코멘트 객체 반환
    }
    @Override
    public List<Comment> getReplies(BigDecimal parentCommentId) {
        return commentMapper.selectReplies(parentCommentId);
    }
    @Override
    public void deleteCommentsByPostNumber(BigDecimal postNumber) throws Exception {
        commentMapper.deleteCommentsByPostNumber(postNumber);
    }
   
}

