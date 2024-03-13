<%@page import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import= "java.time.format.DateTimeFormatter"
 %>
 <%@ page import="java.text.SimpleDateFormat" %>
 <%@ page import="java.util.Date" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 로그인 여부를 확인
    boolean isLoggedIn = false;
    String userEmail = ""; // 사용자 이메일 초기화

    // 사용자 객체에서 이메일 값을 가져옴
    Object user = session.getAttribute("user");
    if (user != null) {
        isLoggedIn = true;
        userEmail = ((User) user).getEmail(); // 사용자 객체에서 이메일 값 가져오기
    }
%>



<%@ page import="com.example.test1.model.Board" %>
<%@ page import="com.example.test1.model.Comment" %>
<%@ page import="com.example.test1.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<style>
   .reply {
    margin-left: 10px;
    padding: 5px;
    border-left: 2px solid #ccc; /* 대댓글 구분을 위한 왼쪽 테두리 */
</style>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>Tables</title>

    <!-- Custom fonts for this template -->
    <link
      href="vendor/fontawesome-free/css/all.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />

    <!-- Custom styles for this template -->
    <link href="css/sb-admin-2.min.css" rel="stylesheet" />

    <!-- Custom styles for this page -->
    <link
      href="vendor/datatables/dataTables.bootstrap4.min.css"
      rel="stylesheet"
    />
  </head>

  <body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
      <!-- Sidebar -->
        <%@ include file="sidebar.jsp" %>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
           <!-- Topbar -->
         	<%@ include file="header.jsp" %>       
<!-- Begin Page Content -->
<div class="container-fluid h-100">
    <h1 class="h3 mb-2 text-gray-800">${board.title}</h1>
    <div class="card shadow mb-4 h-75">
        <div class="card-body">
            <div class="card shadow mb-4 h-100">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary btn float-left">
                        ${board.title}
                    </h6>
                    <% 
                        User loggedInUser = (User)session.getAttribute("user");
                        Board board = (Board)request.getAttribute("board");
                    
                        if (loggedInUser != null && board != null && loggedInUser.getEmail().equals(board.getEmail())) {
                    %>
                        <a href="/modify?postNumber=${board.postNumber}">
                            <button type="button" class="btn btn-primary btn float-right ml-1">
                                수정
                            </button>
                        </a>
                        <a href="/boards?postNumber=${board.postNumber}"></a>
                           <button type="button" class="btn btn-danger btn-delete-board" data-post-number="${board.postNumber}">
					    삭제
					</button>
                        
                        
                        
                    <% } %>
                </div>
                <div class="card-body navbar-nav-scroll" style="height: 290px !important">
                    ${board.content}
                </div>
                 <!-- File Download Button -->
<%
    String fileName = (String) request.getAttribute("fileName");
%>

<%
    if (fileName != null) {
%>
        <a href="/download/${fileName}" download="${fileName}">
            <button id="downloadButton">Download File</button>
        </a>
<%
    }
%>




                    
<div class="card-footer">
    <div>
        <textarea id="commentInputMain" placeholder="댓글을 입력하세요."></textarea>
        <button id="submitCommentMain">댓글 작성</button>
    </div>

<div id="commentSectionMain">
    <!-- AJAX를 통해 로드된 댓글이 여기에 표시됩니다 -->
</div>
</div>




		        <!-- End of Main Content -->

        <!-- Footer -->
        <footer class="sticky-footer bg-white">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright &copy; Your Website 2020</span>
            </div>
          </div>
        </footer>
        <!-- End of Footer -->
      </div>
      <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
  
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



   
	<script>
	
	
	$(document).ready(function() {
	    const postNumber = "<%= board.getPostNumber() %>";
	    const isLoggedIn = <%= session.getAttribute("user") != null ? "true" : "false" %>;

	    function init() {
	        loadAndRenderComments();
	        setupEventHandlers();
	    }

	    function loadAndRenderComments() {
	        $.ajax({
	            url: "/comments/" + postNumber, // 서버로부터 댓글 데이터를 조회하는 URL
	            method: "GET",
	            success: function(comments) {
	                var $container = $('#commentSectionMain');
	                $container.empty();
	                
	                var commentsMap = {};
	                
	                var topLevelComments = [];

	                comments.forEach(function(comment) {
	                    commentsMap[comment.commentId] = comment;
	                    comment.replies = []; // 각 댓글에 대한 대댓글 컨테이너 초기화
	                    if(comment.parentCommentId) {
	                        if(commentsMap[comment.parentCommentId]) {
	                            commentsMap[comment.parentCommentId].replies.push(comment);
	                        }
	                    } else {
	                        topLevelComments.push(comment);
	                    }
	                });

	                topLevelComments.forEach(function(comment) {
	                    $container.append(createCommentHtml(comment));
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error("댓글 로딩 중 오류 발생: ", error);
	            }
	        });
	    }

	    function renderComments(comments) {
	        const $container = $('#commentSectionMain').empty();
	        const commentsMap = {};
	        
	        comments.forEach(comment => {
	            commentsMap[comment.commentId] = comment;
	            comment.replies = [];
	        });

	        comments.forEach(comment => {
	            if(comment.parentCommentId && commentsMap[comment.parentCommentId]) {
	                commentsMap[comment.parentCommentId].replies.push(comment);
	            }
	        });

	        comments.filter(comment => !comment.parentCommentId)
	                .forEach(comment => $container.append(createCommentHtml(comment, isLoggedIn)));
	    }

	


	   
	    function createCommentHtml(comment) {
	    	 var replyButtonHtml = <%= isLoggedIn %> ? '<button class="toggleReplyForm">답글</button>' +
	 	            '<div class="replyFormContainer" style="display:none;">' +
	 	            '<input type="text" class="replyInput" placeholder="답글을 입력하세요">' +
	 	            '<button type="button" class="submitReplyButton">답글 작성</button>' +
	 	            '</div>' : '';
	 	           var isLoggedIn = <%= isLoggedIn %>;
	 		        var loggedInUserEmail = '<%= userEmail %>';

	        var commentClass = comment.parentCommentId ? 'reply' : 'comment';

	        var userNameHtml = '<p class="userName">작성자: ' + comment.name + '</p>';

	        var editButtonHtml = isLoggedIn && comment.email === loggedInUserEmail ? '<button class="editCommentButton">수정</button>' : '';
	        var deleteButtonHtml = isLoggedIn && comment.email === loggedInUserEmail ? '<button class="deleteCommentButton">삭제</button>' : '';
	        
	        var html = '<div class="' + commentClass + '" data-comment-id="' + comment.commentId + '" ' +
	            (comment.parentCommentId ? 'data-parent-comment-id="' + comment.parentCommentId + '"' : '') + '>' +
	            '<p><strong>' + comment.email + '</strong>: ' + comment.content + '</p>' +
	            userNameHtml + editButtonHtml + deleteButtonHtml + replyButtonHtml + '<div class="replies">';
	        
	        if (comment.replies && Array.isArray(comment.replies)) {
	            comment.replies.forEach(function(reply) {
	                html += createCommentHtml(reply); // 대댓글도 같은 방식으로 처리
	            });
	        }

	        html += '</div></div>';
	        return html;
	    }

	     








    function positionReplies() {
        $('.reply').each(function() {
            var parentCommentId = $(this).attr('data-parent-comment-id');
            if (parentCommentId) {
                $(this).appendTo($(`div[data-comment-id='${parentCommentId}'] > .replies`));
            }
        });
    }


    function submitComment(content) {
        ajaxRequest({
            url: "/comments/" + postNumber,
            method: "POST",
            data: { content: content },
            onSuccess: function() {
                loadAndRenderComments();
                $('#commentInputMain').val('');
                alert('댓글이 성공적으로 작성되었습니다.');
            },
            onError: function(xhr, status, error) {
                console.error("댓글 제출 중 오류 발생: ", error);
            }
        });
    }


    function submitReply(postNumber, parentCommentId, content) {
        console.log(postNumber, parentCommentId);
        $.ajax({
            url: "/comments/" + postNumber + "/" + parentCommentId,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({ content: content }),
            success: function() {
                console.log("Reply submitted successfully.");
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Error submitting reply:", error);
            }
        });
    };


    $(document).on('click', '.submitReplyButton', function() {
        var $commentContainer = $(this).closest('.comment, .reply');
        var parentCommentId = $commentContainer.data('comment-id');
        var replyContent = $(this).prev('.replyInput').val().trim();

        if (replyContent && parentCommentId) {
            ajaxRequest({
                url: "/comments/" + postNumber + "/" + parentCommentId,
                method: "POST",
                data: { content: replyContent },
                onSuccess: function(reply) {
                    var replyHtml = createCommentHtml(reply);
                    loadAndRenderComments();
                    // Clear and hide the reply input field
                    $(this).prev('.replyInput').val('').closest('.replyFormContainer').hide();
                },
                onError: function(xhr, status, error) {
                    console.error("Error submitting reply:", error);
                }
            });
        } else {
            console.error("Missing reply content or undefined parentCommentId.");
        }
    });


// 댓글 제출
$("#submitCommentMain").click(function() {
    var commentContent = $('#commentInputMain').val().trim();
    if (!isLoggedIn) {
        alert('로그인 후 이용 가능합니다.');
    } else if (commentContent) {
        submitComment(commentContent);
    } else {
        alert("댓글 내용을 입력해주세요.");
    }
});





    
  

 // 대댓글 폼 토글 함수
    $(document).on('click', '.toggleReplyForm', function() {
        var $this = $(this);
        var $replyFormContainer = $this.next('.replyFormContainer');
        var $parentComment = $this.closest('.comment, .reply');
        var parentCommentId = $parentComment.data('comment-id');
        var parentCommentEmail = $parentComment.find('strong').first().text(); 

        $replyFormContainer.find('.replyTo').remove(); 
        $replyFormContainer.prepend('<div class="replyTo">답변 대상: ' + parentCommentEmail + '</div>'); 

        $replyFormContainer.toggle(); 
    });

    loadAndRenderComments();
    
    function handleComment(action, commentId, newContent = null) {
        let url = "";
        let method = "";
        let data = {};
        let successMessage = "";
        
        if (action === "update") {
            url = "/comments/update/" + commentId;
            method = "PUT";
            data = JSON.stringify({ content: newContent });
            successMessage = "댓글이 수정되었습니다.";
        } else if (action === "delete") {
            url = "/comments/delete/" + commentId;
            method = "DELETE";
            successMessage = "댓글이 삭제되었습니다.";
        } else {
            console.error("Invalid action:", action);
            return;
        }

        $.ajax({
            url: url,
            method: method,
            contentType: "application/json",
            data: data,
            success: function() {
                alert(successMessage);
                loadAndRenderComments();
            },
            error: function(xhr, status, error) {
                alert(`댓글 ${action} 중 오류가 발생했습니다: ` + error);
            }
        });
    }
    $(document).on('click', '.btn-delete-board', function() {
        var postNumber = $(this).data('post-number');

        if (confirm("게시글을 삭제하시겠습니까?")) {
            $.ajax({
                url: '/boards/' + postNumber,
                type: 'DELETE',
                success: function(response) {
                    console.log('게시글 삭제 성공');
                    window.location.href = '/tables';
                },
                error: function(xhr, status, error) {
                    console.error('게시글 삭제 실패:', error);
                }
            });
        }
    });


  
    // 수정 버튼 클릭 이벤트 핸들러
    $(document).on('click', '.editCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        var newContent = prompt("댓글 내용을 수정하세요:");
        if (newContent) {
            handleComment("update", commentId, newContent);
        }
    });

    // 삭제 버튼 클릭 이벤트 핸들러
    $(document).on('click', '.deleteCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        if (confirm("댓글을 삭제하시겠습니까?")) {
            handleComment("delete", commentId);
        }
    });

 // 다운로드 버튼 클릭 이벤트 핸들러
    document.getElementById("downloadButton").addEventListener("click", function() {
       
        var downloadPath = this.getAttribute("href");
        console.log("다운로드 경로:", downloadPath);
    });

    
});
	
// POST형식의 ajax
	function ajaxRequest({ url, method, data, onSuccess, onError }) {
	    $.ajax({
	        url: url,
	        method: method,
	        contentType: "application/json",
	        data: JSON.stringify(data),
	        success: onSuccess,
	        error: onError
	    });
	}


</script>



     
     

  </body>
</html>
