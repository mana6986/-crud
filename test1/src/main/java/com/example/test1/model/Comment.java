package com.example.test1.model;

import java.sql.Date;

import java.math.BigDecimal;


public class Comment {
    private BigDecimal commentId;
    private BigDecimal parentCommentId;
    private BigDecimal postNumber;
    private String email;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private String name;
    // 기본 생성자
    public Comment() { }

    
    
    public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	// 생성자 추가
    public Comment(BigDecimal postNumber, String email, String content, BigDecimal parentCommentId, String name) {
        this.postNumber = postNumber;
        this.email = email;
        this.content = content;
        this.parentCommentId = parentCommentId;
        this.name = name;
    }

    // getter, setter
    public BigDecimal getCommentId() {
        return commentId;
    }

    public void setCommentId(BigDecimal commentId) {
        this.commentId = commentId;
    }

    public BigDecimal getparentCommentId() {
        return parentCommentId;
    }

    public void setparentCommentId(BigDecimal parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public BigDecimal getpostNumber() {
        return postNumber;
    }

    public void setpostNumber(BigDecimal postNumber) {
        this.postNumber = postNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getcreatedAt() {
        return createdAt;
    }

    public void setcreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getupdatedAt() {
        return updatedAt;
    }

    public void setupdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}