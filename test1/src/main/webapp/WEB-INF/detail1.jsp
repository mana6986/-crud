<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
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
      <ul
        class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
        id="accordionSidebar"
      >
        <!-- Sidebar - Brand -->
        <a
          class="sidebar-brand d-flex align-items-center justify-content-center"
          href="index"
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
              <a class="collapse-item" href="login">Login</a>
              <a class="collapse-item" href="membership">membership</a>
            </div>
          </div>
        </li>

        <!-- Nav Item - Tables -->
        <li class="nav-item active">
          <a class="nav-link" href="tables">
            <i class="fas fa-fw fa-table"></i>
            <span>Tables</span></a
          >
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
                  <span class="mr-2 d-none d-lg-inline text-gray-600 small"
                    >닉네임</span
                  >
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
                  <a
                    class="dropdown-item"
                    href="#"
                    data-toggle="modal"
                    data-target="#logoutModal"
                  >
                    <i
                      class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"
                    ></i>
                    Logout
                  </a>
                </div>
              </li>
            </ul>
          </nav>
          <!-- End of Topbar -->
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
                        <a href="/delete/${board.postNumber}">
                            <button type="button" class="btn btn-danger btn float-right ml-1">
                                삭제
                            </button>
                        </a>
                    <% } %>
                </div>
                <div class="card-body navbar-nav-scroll" style="height: 290px !important">
                    ${board.content}
                </div>
             <div class="card-footer">
			    <div class="row">
			        <p class="col-md-1"></p>
			        <div class="col-md-10 border-left" style="max-height: 200px; overflow-y: scroll">
			          <% 
			    @SuppressWarnings("unchecked")
			    List<Comment> comments = (List<Comment>)request.getAttribute("comments");
			
			    if (comments != null) {
			        for (Comment comment : comments) {
			%>
			            <div class="comment" id="comments">
			                <div class="comment-email"><%= comment.getEmail() %></div>
			                <div class="comment-content"><%= comment.getContent() %></div>
			                <div class="comment-date"><%= comment.getCreated_at() %></div>
			            </div>
			<% 
			        }
			    } 
			%>

        </div>
        <p class="col-md-1 border-left">${boardDate}</p>
    </div>
    <hr class="sidebar-divider d-none d-md-block" />
    <!-- 댓글 입력창 -->
    <textarea id="commentInput" cols="30" rows="5" class="form-control" placeholder="댓글을 입력하세요" style="resize: none"></textarea>
    <button id="submitComment">댓글 작성</button>
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
    <script src="js/demo/datatables-demo.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
     <script>
     $(document).ready(function() {
    	    var isLoggedIn = <%= isLoggedIn %>; // 서버 사이드에서 확인한 로그인 여부
    	    var loginDropdownLink = $('#loginDropdownLink');
    	    var loginCollapseLink = $('#loginCollapseLink');

    	    if (isLoggedIn) { // 로그인한 상태
    	        loginDropdownLink.text('로그아웃');
    	        loginDropdownLink.attr('href', 'logout');
    	        loginCollapseLink.text('로그아웃');
    	        loginCollapseLink.attr('href', 'logout');

    	        loginDropdownLink.on('click', function(event) {
    	            event.preventDefault(); // 링크 클릭 이벤트 취소
    	            confirmLogout(); // 로그아웃 확인 대화 상자 표시
    	        });
    	        loginCollapseLink.on('click', function() {
    	            alert('로그아웃 하시겠습니까?.');
    	        });
    	    } else { // 로그인하지 않은 상태
    	        loginDropdownLink.text('로그인');
    	        loginDropdownLink.attr('href', 'login');
    	        loginCollapseLink.text('로그인');
    	        loginCollapseLink.attr('href', 'login');

    	        loginDropdownLink.on('click', function() {
    	            alert('로그인이 필요합니다.');
    	        });
    	        loginCollapseLink.on('click', function() {
    	            alert('로그인이 필요합니다.');
    	        });
    	    }

    	    // 로그아웃 확인 대화 상자 표시 함수
    	    function confirmLogout() {
    	        if (confirm('로그아웃 하시겠습니까?')) {
    	            window.location.href = 'logout'; // 로그아웃 처리 URL로 이동
    	        }
    	    }

    	    $.get("/checkLoginStatus", function(data) {
    	        if (data.loggedIn) {
    	            $('.mr-2').text(data.user.name);
    	        }
    	    });
    	});
     
     
     function confirmDelete(postNumber) {
         if (confirm("삭제하시겠습니까?")) {
             // 사용자가 확인을 선택한 경우 삭제 요청 보내기
             deleteBoard(postNumber);
         }
     }

     function deleteBoard(postNumber) {
    	    // AJAX를 사용하여 서버에 삭제 요청 보내기
    	    $.ajax({
    	        url: '/delete/' + postNumber,
    	        type: 'DELETE',
    	        success: function(response) {
    	            alert("삭제되었습니다.");
    	            // 페이지 이동
    	            window.location.href = '/tables';
    	        },
    	        error: function(xhr, status, error) {
    	            alert("삭제를 실패했습니다.");
    	            console.error(xhr.responseText);
    	        }
    	    });
    	}
     
     document.getElementById("submitComment").addEventListener("click", function() {
    	    var commentInput = document.getElementById("commentInput");
    	    var comment = commentInput.value.trim();
    	    if (comment === "") {
    	        alert("댓글을 입력하세요.");
    	        return;
    	    }

    	    var request = new XMLHttpRequest();
    	    request.open("POST", "/comments/${board.postNumber}", true);  // URL 경로 변경
    	    request.setRequestHeader("Content-Type", "application/json");
    	    request.onreadystatechange = function() {
    	        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
    	            // 댓글 등록 성공 시 댓글 목록 다시 불러오기
    	            loadComments();
    	        }
    	    }
    	    request.send(JSON.stringify({
    	        "content": comment
    	    }));
    	    commentInput.value = ""; // 댓글 입력창 초기화
    	});

     
    	    
    	    // 댓글 작성 버튼이 클릭되면 서버에 댓글 데이터를 보낸다.
    	    $("#submitComment").click(function(){
    	        var commentContent = $("#commentInput").val();
    	        var commentData = { content: commentContent };
    	        
    	        $.post("/api/comments", commentData, function(data, status){
    	            // 서버로부터 응답이 오면, 새로 작성한 댓글을 HTML에 추가한다.
    	            var commentHtml = "<li>" + data.email + ": " + data.content + "</li>";
    	            $("#commentSection").append(commentHtml);
    	            
    	            // 댓글 입력란을 비운다.
    	            $("#commentInput").val("");
    	        });
    	    });
     
    	    $(document).ready(function() {
    	        var postNumber = ${postNumber}; // 게시글 번호는 서버로부터 전달받아야 합니다.

    	        $.get("/comments/" + postNumber, function(data) {
    	            // 댓글 출력
    	            data.forEach(function(comment) {
    	                $("#comments").append("<div class='comment'>" +
    	                    "<div class='comment-email'>" + comment.email + "</div>" +
    	                    "<div class='comment-content'>" + comment.content + "</div>" +
    	                    "<div class='comment-date'>" + comment.created_at + "</div>" +
    	                    "</div>");
    	            });
    	        });
    	    });
     // 페이지 로드 시 댓글 목록 불러오기
     loadComments();
    </script>
  </body>
</html>
