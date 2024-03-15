package com.example.test1.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Board {
	private String deleted;
	  private BigDecimal postNumber;
	    private String email;
	    private String title;
	    private String content;
	    private Date boardDate;
	    private String filename;
	    private BigDecimal fileNo;
	    private BigDecimal commentCount;
		private String name;
	    
	    public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

    public Board() {
    }

    public Board(BigDecimal postNumber, BigDecimal fileNo, String email, String title, String content, String filename, Date boardDate, BigDecimal commentCount) {
        this.postNumber = postNumber;
        this.fileNo = fileNo;
        this.email = email;
        this.title = title;
        this.content = content;
        this.filename = filename;
        this.boardDate = boardDate;
        this.commentCount = commentCount;
    }
    
    // 모든 필드를 매개변수로 받는 생성자
    public Board(BigDecimal postNumber, String email, String title, String content, String deleted, Date boardDate, String filename, BigDecimal fileNo, BigDecimal commentCount) {
        this.postNumber = postNumber;
        this.email = email;
        this.title = title;
        this.content = content;
        this.deleted = deleted;
        this.boardDate = boardDate; // 현재 시간이 아닌 파라미터로 받은 boardDate로 설정
        this.filename = filename;
        this.fileNo = fileNo;
        this.commentCount = commentCount;
    }

    public Board(BigDecimal postNumber, String email, String title, String content, Date boardDate) {
        this.postNumber = postNumber;
        this.email = email;
        this.title = title;
        this.content = content;
        this.boardDate = boardDate;
    }

    // 필요한 필드만 매개변수로 받는 생성자
 // 네 번째 파라미터로 LocalDateTime을 받는 생성자 추가
    public Board(String email, String title, String content) {
        this.email = email;
        this.title = title;
        this.content = content;
    }
    public Board(String email, String title, String content, Date boardDate) {
        this.email = email;
        this.title = title;
        this.content = content;
        this.boardDate = boardDate; // 파라미터로 받은 날짜로 설정
    }

	public BigDecimal getCommentCount() {
		return commentCount;
	}

	 public void setCommentCount(BigDecimal commentCount) {
	        this.commentCount = commentCount;
	    }

	public BigDecimal getPostNumber() {
	    return postNumber;
	}
	public void setPostNumber(BigDecimal postNumber) {
		this.postNumber = postNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public BigDecimal getFileNo() {
		return fileNo;
	}

	public void setFileNo(BigDecimal fileNo) {
		this.fileNo = fileNo;
	}
}