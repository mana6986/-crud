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
         <!-- Sidebar -->
      <ul
        class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
        id="accordionSidebar"
      >
        <!-- Sidebar - Brand -->
        <a
          class="sidebar-brand d-flex align-items-center justify-content-center"
          href="tables"
        >
          <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
          </div>
          <div class="sidebar-brand-text mx-3">게시판</div>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0" />

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
          <a
            class="nav-link collapsed"
            href="#"
            data-toggle="collapse"
            data-target="#collapsePages"
            aria-expanded="true"
            aria-controls="collapsePages"
          >
            <i class="fas fa-fw fa-folder"></i>
            <span>Pages</span>
          </a>
          <div
            id="collapsePages"
            class="collapse"
            aria-labelledby="headingPages"
            data-parent="#accordionSidebar"
          >
            <div class="bg-white py-2 collapse-inner rounded">
              <h6 class="collapse-header">Login Screens:</h6>
              <a class="collapse-item"  id="loginCollapseLink">Login</a>
              <a class="collapse-item" href="membership">membership</a>
            </div>
          </div>
        </li>

        <!-- Nav Item - Tables -->
        <li class="nav-item active">
          <a class="nav-link" href="tables">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span>
          </a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider d-none d-md-block" />

        <!-- Sidebar Toggler (Sidebar) -->
        <div class="text-center d-none d-md-inline">
          <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
      </ul>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
           <!-- Topbar -->
          <nav
            class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow"
          >
            <!-- Sidebar Toggle (Topbar) -->
            <form class="form-inline">
              <button
                id="sidebarToggleTop"
                class="btn btn-link d-md-none rounded-circle mr-3"
              >
                <i class="fa fa-bars"></i>
              </button>
            </form>

            <!-- Topbar Navbar -->
            <ul class="navbar-nav ml-auto">
              <div class="topbar-divider d-none d-sm-block"></div>

              <!-- Nav Item - User Information -->
              <li class="nav-item dropdown no-arrow">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="userDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <span class="mr-2 d-none d-lg-inline text-gray-600 small">
			    <% if(isLoggedIn) { %>
			        <%= ((com.example.test1.model.User)user).getName() %>
			    <% } else { %>
			        guest
			    <% } %>
			</span>
                  <img
                    class="img-profile rounded-circle"
                    src="img/undraw_profile.svg"
                  />
                </a>
                <!-- Dropdown - User Information -->
                <div
                  class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                  aria-labelledby="userDropdown"
                >
                  <a class="dropdown-item" href="profile">
                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                    Profile
                  </a>

                  <div class="dropdown-divider"></div>
                  <a id="loginDropdownLink" class="dropdown-item" href="#" 
                     <% if (isLoggedIn) { %>data-toggle="modal" data-target="#logoutModal"<% } %>>
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    <% if (isLoggedIn) { %>Logout<% } else { %>Login<% } %>
                  </a>
                </div>
              </li>
            </ul>
          </nav>
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
	    var isLoggedIn = <%= session.getAttribute("user") != null ? "true" : "false" %>;
	    var postNumber = "<%= board.getPostNumber() %>";
	
	    function loadAndRenderComments() {
	        $.ajax({
	            url: "/comments/" + postNumber, // 서버로부터 댓글 데이터를 조회하는 URL
	            method: "GET",
	            success: function(comments) {
	                var $container = $('#commentSectionMain');
	                $container.empty();
	                
	                // 임시 저장소 객체를 생성합니다.
	                var commentsMap = {};
	                
	                // 최상위 댓글만을 담는 배열
	                var topLevelComments = [];

	                // 댓글을 ID를 키로 사용하여 저장소에 저장합니다.
	                comments.forEach(function(comment) {
	                    commentsMap[comment.commentId] = comment;
	                    comment.replies = []; // 각 댓글에 대한 대댓글 컨테이너 초기화
	                    if(comment.parentCommentId) {
	                        // 대댓글이면 해당 부모의 replies에 추가
	                        if(commentsMap[comment.parentCommentId]) {
	                            commentsMap[comment.parentCommentId].replies.push(comment);
	                        }
	                    } else {
	                        // 최상위 댓글이면 별도 배열에 추가
	                        topLevelComments.push(comment);
	                    }
	                });

	                // 최상위 댓글과 해당 댓글의 대댓글을 렌더링합니다.
	                topLevelComments.forEach(function(comment) {
	                    $container.append(createCommentHtml(comment));
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error("댓글 로딩 중 오류 발생: ", error);
	            }
	        });
	    }
	 
	    function createCommentHtml(comment) {
	    	 var replyButtonHtml = <%= isLoggedIn %> ? '<button class="toggleReplyForm">답글</button>' +
	 	            '<div class="replyFormContainer" style="display:none;">' +
	 	            // 대댓글 작성 대상 정보를 위한 빈 div 추가
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
                // 대댓글을 부모 댓글의 replies 컨테이너에 추가
                $(this).appendTo($(`div[data-comment-id='${parentCommentId}'] > .replies`));
            }
        });
    }



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

function submitComment(content) {
    $.ajax({
        url: "/comments/" + postNumber,
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({ content: content }),
        success: function() {
            loadAndRenderComments();
            $('#commentInputMain').val(''); // 입력 필드 비우기
            alert('댓글이 성공적으로 작성되었습니다.');
        },
        error: function(xhr, status, error) {
            console.error("댓글 제출 중 오류 발생: ", error);
        }
    });
}


$(document).on('click', '.submitReplyButton', function() {
    var $commentContainer = $(this).closest('.comment, .reply');
    var parentCommentId = $commentContainer.data('comment-id'); // 올바른 부모 ID를 가져옴
    var replyContent = $(this).prev('.replyInput').val().trim();

    if (replyContent && parentCommentId) {
        $.ajax({
            url: "/comments/" + postNumber + "/" + parentCommentId,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({ content: replyContent }),
            success: function(reply) {
                // 대댓글 HTML 생성
                var replyHtml = createCommentHtml(reply);

                // 대댓글을 부모 댓글 바로 다음에 삽입
    loadAndRenderComments();                // 대댓글 입력 필드 초기화 및 숨기기
                $(this).prev('.replyInput').val('').closest('.replyFormContainer').hide();
            },
            error: function(xhr, status, error) {
                console.error("Error submitting reply:", error);
            }
        });
    } else {
        console.error("Missing reply content or undefined parentCommentId.");
    }
});




function submitReply(postNumber, parentCommentId, content) {
    console.log(postNumber, parentCommentId);
    $.ajax({
        url: "/comments/" + postNumber + "/" + parentCommentId,
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({ content: content }),
        success: function() {
            console.log("Reply submitted successfully.");
            // 대댓글 제출 후 새로 고침
            location.reload();
        },
        error: function(xhr, status, error) {
            console.error("Error submitting reply:", error);
        }
    });
};



    
  

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
    
    $(document).on('click', '.editCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        console.log(commentId); 
        var newContent = prompt("댓글 내용을 수정하세요:");
        if (newContent) {
            updateComment(commentId, newContent);
        }
    });

    $(document).on('click', '.deleteCommentButton', function() {
        var commentId = $(this).closest('.comment, .reply').data('comment-id');
        console.log(commentId); 
        if (confirm("댓글을 삭제하시겠습니까?")) {
            deleteComment(commentId);
        }
    });

    function updateComment(commentId, content) {
        $.ajax({
            url: "/comments/update/" + commentId,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({ content: content }),
            success: function() {
                alert("댓글이 수정되었습니다.");
                loadAndRenderComments();
            },
            error: function(xhr, status, error) {
                alert("댓글 수정 중 오류가 발생했습니다: " + error);
            }
        });
    }

    function deleteComment(commentId) {
        $.ajax({
            url: "/comments/delete/" + commentId,
            method: "DELETE",
            success: function() {
                alert("댓글이 삭제되었습니다.");
                loadAndRenderComments();
            },
            error: function(xhr, status, error) {
                alert("댓글 삭제 중 오류가 발생했습니다: " + error);
            }
        });
    }

 // 다운로드 버튼 클릭 이벤트 핸들러
    document.getElementById("downloadButton").addEventListener("click", function() {
       
        var downloadPath = this.getAttribute("href");
        console.log("다운로드 경로:", downloadPath);
    });

  

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

    
});
	$(document).ready(function() {
	    var isLoggedIn = <%= isLoggedIn %>; // 서버 사이드에서 확인한 로그인 여부
	    var loginDropdownLink = $('#loginDropdownLink');
	    var loginCollapseLink = $('#loginCollapseLink');

	    if (isLoggedIn) { // 로그인한 상태
	        loginDropdownLink.text('로그아웃');
	        loginCollapseLink.text('로그아웃');

	        loginDropdownLink.on('click', function(event) {
	            event.preventDefault(); // 링크 클릭 이벤트 취소
	            confirmLogout(); // 로그아웃 확인 대화 상자 표시
	        });
	        loginCollapseLink.on('click', function() {
	            var result = confirm('로그아웃 하시겠습니까?');
	            if (result == true) {
	                alert('로그아웃 되었습니다.'); // 로그아웃 처리 URL로 이동
	                window.location.href = 'logout';
	            } else {
	                alert('로그아웃이 취소되었습니다.'); // 취소되었다는 메시지 출력
	            }
	        });

	    } else { // 로그인하지 않은 상태
	        loginDropdownLink.text('로그인');
	        loginDropdownLink.attr('href', 'login');
	        loginCollapseLink.text('로그인');
	        loginCollapseLink.attr('href', 'login');
	    }
	    
	    // 로그아웃 확인 대화 상자 표시 함수
	    function confirmLogout() {
	        var result = confirm('로그아웃 하시겠습니까?');
	        if (result == true) {
	            alert('로그아웃 되었습니다.'); // 로그아웃 처리 URL로 이동
	            window.location.href = 'logout';
	        } else {
	            alert('로그아웃이 취소되었습니다.'); // 취소되었다는 메시지 출력
	        }
	    }

	    $.get("/checkLoginStatus", function(data) {
	        if (data.loggedIn) {
	            $('.mr-2').text(data.user.name);
	        }
	    });
	});




</script>



     
     

  </body>
</html>
