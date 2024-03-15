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
 <script src="js/common.js"></script>
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
				    <div class="card-body navbar-nav-scroll" style="height: auto;">
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
        <button id="submitCommentMain" data-post-number="${board.postNumber}">댓글 작성</button>
        
    </div>

<div id="commentSectionMain">
    <!-- AJAX를 통해 로드된 댓글이 여기에 표시됩니다 -->
</div>
</div>




		        <!-- End of Main Content -->

        <!-- Footer -->
   <%@ include file="footer.jsp" %>
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
	        // 'postNumber'는 이 함수가 호출되는 컨텍스트에서 정의되어 있어야 합니다.
	        var url = "/comments/" + postNumber;

	        public_ajax(url, 'GET', null, 
	            function(comments) { // 성공 콜백 함수
	                var $container = $('#commentSectionMain');
	                $container.empty();
	                
	                var commentsMap = {};
	                var topLevelComments = [];

	                comments.forEach(function(comment) {
	                    commentsMap[comment.commentId] = comment;
	                    comment.replies = [];
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
	            function(xhr, textStatus, errorThrown) { // 오류 콜백 함수
	                console.error("댓글 로딩 중 오류 발생: ", textStatus + ": " + errorThrown);
	                alert('댓글 로딩 중 오류가 발생했습니다.');
	            }
	        );
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
	 	            '<button type="button" class="submitReplyButton" data-post-number="${board.postNumber}">답글 작성</button>' +
	 	            '</div>' : '';
	 	           var isLoggedIn = <%= isLoggedIn %>;
	 		        var loggedInUserEmail = '<%= userEmail %>';

	        var commentClass = comment.parentCommentId ? 'reply' : 'comment';

	        var userNameHtml = '<p class="userName">작성자: ' + comment.name + '</p>';

	        var editButtonHtml = isLoggedIn && comment.email === loggedInUserEmail ? '<button class="editCommentButton">수정</button>' : '';
	        var deleteButtonHtml = isLoggedIn && comment.email === loggedInUserEmail ? '<button class="deleteCommentButton">삭제</button>' : '';
	        
	        var html = '<div class="' + commentClass + '" data-comment-id="' + comment.commentId + '" ' +
	            (comment.parentCommentId ? 'data-parent-comment-id="' + comment.parentCommentId + '"' : '') + '>' +
	            '<p><strong>' + comment.name + '</strong>: ' + comment.content + '</p>' +
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


 // 댓글 제출 함수
function submitComment(content, postNumber) {
    var data = { content: content };
    // HTTP 메소드 'POST'를 명시적으로 추가하고, 오류 처리 콜백 함수도 포함
    public_ajax("/comments/" + postNumber, 'POST', data,
        // 성공 콜백 함수
        function(result, textStatus) {
            loadAndRenderComments(); // 댓글을 다시 로드하고 렌더링
            console.log("댓글이 성공적으로 처리되었습니다.", result);
            alert("댓글이 성공적으로 처리되었습니다.");
            $('#commentInputMain').val(''); // 댓글 입력 필드를 초기화
        },
        // 오류 처리 콜백 함수
        function(xhr, textStatus, errorThrown) {
            console.error("댓글 처리 중 오류 발생:", textStatus, errorThrown);
            alert("댓글 처리 중 오류가 발생했습니다.");
        }
    );
}


$("#submitCommentMain").click(function() {
    var commentContent = $('#commentInputMain').val().trim();
    var postNumber = $(this).data('post-number');
	
    if (!isLoggedIn) {
        alert('로그인 후 이용 가능합니다.');
    } else if (commentContent) {
        submitComment(commentContent, postNumber); // postNumber도 함께 전달합니다.
    } else {
        alert("댓글 내용을 입력해주세요.");
    }
});
    


$(document).on('click', '.submitReplyButton', function() {
    var $commentContainer = $(this).closest('.comment, .reply');
    var postNumber = $(this).data('post-number');
    var parentCommentId = $commentContainer.data('comment-id');
    var replyContent = $(this).prev('.replyInput').val().trim();

    if (replyContent && parentCommentId) {
        public_ajax("/comments/" + postNumber + "/" + parentCommentId, 'POST', { content: replyContent }, function(reply) {
            var replyHtml = createCommentHtml(reply);
            loadAndRenderComments();
            $('.replyInput').val('').closest('.replyFormContainer').hide();
        });
    } else {
        console.error("Missing reply content or undefined parentCommentId.");
    }
});


    $(document).on('click', '.toggleReplyForm', function() {
        var $this = $(this);
        var $replyFormContainer = $this.next('.replyFormContainer');
        var $parentComment = $this.closest('.comment, .reply');
        var parentCommentId = $parentComment.data('comment-id');
        var parentCommentName = $parentComment.find('strong').first().text();
        
        $replyFormContainer.find('.replyTo').remove(); 
        $replyFormContainer.prepend('<div class="replyTo">답변 대상: ' + parentCommentName + '</div>'); 

        $replyFormContainer.toggle(); 
    });

    loadAndRenderComments();
    
    function handleAction(entity, action, id, newContent = null) {
        let url = "";
        let method = "";
        let data = {};
        let successMessage = "";

        if (entity === "comment") {
            if (action === "update") {
                url = "/comments/update/" + id;
                method = "PUT";
                data = { content: newContent }; // JSON.stringify를 사용하지 않고 객체를 직접 전달
                successMessage = "댓글이 수정되었습니다.";
            } else if (action === "delete") {
                url = "/comments/delete/" + id;
                method = "DELETE";
                // DELETE 요청에는 본문 데이터가 필요 없으므로 data는 빈 객체로 둡니다.
                successMessage = "댓글이 삭제되었습니다.";
            }
        } else if (entity === "board") {
            if (action === "delete") {
                url = "/boards/" + id;
                method = "DELETE";
                // DELETE 요청에는 본문 데이터가 필요 없으므로 data는 빈 객체로 둡니다.
                successMessage = "게시글이 삭제되었습니다.";
            }
        } else {
            console.error("Invalid entity or action:", entity, action);
            return;
        }

        public_ajax(url, method, data,
            function(result) {
                alert(successMessage);
                if (entity === "comment") {
                    loadAndRenderComments();
                } else if (entity === "board" && action === "delete") {
                    window.location.href = '/tables';
                }
            },
            function(xhr, textStatus, errorThrown) {
                alert(`${entity} ${action} 중 오류가 발생했습니다: ` + errorThrown);
            }
        );
    }


    $(document).on('click', '.btn-delete-board', function() {
        var postNumber = $(this).data('post-number');

        if (confirm("게시글을 삭제하시겠습니까?")) {
            handleAction("board", "delete", postNumber);
        }
    });
    
    $(document).on('click', '.editCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        var newContent = prompt("댓글 내용을 수정하세요:");
        if (newContent) {
            handleAction("comment", "update", commentId, newContent);
        }
    });

    $(document).on('click', '.deleteCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        if (confirm("댓글을 삭제하시겠습니까?")) {
            handleAction("comment", "delete", commentId);
        }
    });

    

    document.getElementById("downloadButton").addEventListener("click", function() {
       
        var downloadPath = this.getAttribute("href");
        console.log("다운로드 경로:", downloadPath);
    });

    
});


</script>
  </body>
</html>
