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
    Object user = session.getAttribute("user");
    if (user != null) {
        isLoggedIn = true;
    }
%>

<%@ page import="com.example.test1.model.Board" %>
<%@ page import="com.example.test1.model.Comment" %>
<%@ page import="com.example.test1.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
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
              <a class="collapse-item" href="login" id="loginCollapseLink">Login</a>
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
			        닉네임
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
                       <button type="button" class="btn btn-danger btn-delete-board" data-post-number="${board.postNumber}">
					    삭제
					</button>
                        
                        
                        
                    <% } %>
                </div>
                <div class="card-body navbar-nav-scroll" style="height: 290px !important">
                    ${board.content}
                </div>
                 <!-- File Download Button -->
      <%-- detail.jsp --%>
<a href="/download/${fileName}" download="${fileName}">
    <button id="downloadButton">Download File</button>
</a>

                    
  <div class="card-footer">
    <div class="row" id="commentsContainer">
        <!-- 댓글이 여기에 동적으로 생성됩니다. -->
    </div>
</div>
<div class="col-md-12 col-sm-12">
    <hr class="sidebar-divider d-none d-md-block" />
    <% if(isLoggedIn) { %>
        <textarea id="commentInputMain" class="form-control" placeholder="댓글을 입력하세요"></textarea>
        <button id="submitCommentMain" class="btn btn-primary">댓글 작성</button>
    <% } else { %>
        <p>댓글을 작성하려면 로그인하세요.</p>
    <% } %>
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
    <div
      class="modal fade"
      id="logoutModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button
              class="close"
              type="button"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            Select "Logout" below if you are ready to end your current session.
          </div>
          <div class="modal-footer">
            <button
              class="btn btn-secondary"
              type="button"
              data-dismiss="modal"
            >
              Cancel
            </button>
            <a class="btn btn-primary" href="login">Logout</a>
          </div>
        </div>
      </div>
    </div>

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
    // 댓글 작성 함수
    function submitComment(url, commentInputSelector, commentSectionSelector) {
        var commentContent = $(commentInputSelector).val();
        var requestData = { content: commentContent };

        $.ajax({
            url: url,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(requestData),
            success: function(data, status){
                var commentHtml = "<li>" + data.email + ": " + data.content + "</li>";
                $(commentSectionSelector).append(commentHtml);
                $(commentInputSelector).val("");
                // 댓글 작성 성공 후 페이지 새로고침
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Error occurred while submitting comment:", error);
            }
        });
    }
 // 댓글 작성 이벤트
    $("#submitCommentMain").click(function(){
        var postNumber = ${board.postNumber};
        submitComment("/comments/" + postNumber, "#commentInputMain", "#commentSectionMain");

        // Close the reply form
        $(".replyFormContainer").hide();
    });

    function renderComments(comments, parentElement) {
        comments.forEach(function(comment) {
            var commentElement = $('<div>').addClass('comment').attr('data-comment-id', comment.id);
            commentElement.append($('<p>').addClass('comment-author').text(comment.author));
            commentElement.append($('<p>').addClass('comment-content').text(comment.content));

            // 대댓글 작성 폼 (필요에 따라 수정)
            var replyForm = $('<textarea>').addClass('form-control replyInput');
            commentElement.append(replyForm);
            commentElement.append($('<button>').addClass('btn btn-primary submitReply').text('대댓글 작성'));

            // 자식 댓글이 있으면 재귀적으로 렌더링
            if (comment.children && comment.children.length > 0) {
                var childrenContainer = $('<div>').addClass('children-comments');
                renderComments(comment.children, childrenContainer);
                commentElement.append(childrenContainer);
            }

            $(parentElement).append(commentElement);
        });
    }

    // 예시: 댓글 데이터를 가져와서 렌더링하는 코드
    $(document).ready(function() {
        // 댓글 데이터를 가져오는 AJAX 요청 (가정)
        $.ajax({
            url: '/api/comments',
            method: 'GET',
            success: function(data) {
                renderComments(data, '#commentsContainer');
            }
        });
    });

});
</script>





     
     

  </body>
</html>
