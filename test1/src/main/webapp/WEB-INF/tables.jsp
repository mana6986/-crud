<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.test1.model.User" %>
<%@ page import="com.example.test1.model.Board" %>
<%
    // 로그인 여부를 확인
    boolean isLoggedIn = false;
    Object user = session.getAttribute("user");
    if (user != null) {
        isLoggedIn = true;
    }
%>
<!DOCTYPE html>

<html lang="ko">
<head>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Tables</title>
    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="css/sb-admin-2.min.css" rel="stylesheet" />
    <!-- Custom styles for this page -->
    <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" />
</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="tables">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">게시판</div>
            </a>
            <!-- Divider -->
            <hr class="sidebar-divider my-0" />
            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
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
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>
                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">
                        <div class="topbar-divider d-none d-sm-block"></div>
                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                               <span class="mr-2 d-none d-lg-inline text-gray-600 small">
									    <% if(isLoggedIn) { %>
									        <%= ((com.example.test1.model.User)user).getName() %>
									    <% } else { %>
									        guest
									    <% } %>
									</span>
	
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg" />
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
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
                <!-- End of Topbar -->
                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">게시판</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                      <div class="card-body">
    <div class="table-responsive">
        <table class="table table-bordered" id="boardTable" width="100%" cellspacing="0">
            <colgroup>
                <col width="20%" />
                <col width="40%" />
                <col width="30%" />
                <col width="10%" /> <!-- 댓글 카운트를 위한 열 추가 -->
            </colgroup>
            <thead>
                <tr>
                    <th>닉네임</th>
                    <th>제목</th>
                    <th>날짜</th>
                    <th>댓글</th>
                </tr>
            </thead>
            <tbody>
                <!-- 게시글 목록 표시 -->
                <c:forEach var="board" items="${boardList}">
			    <tr>
			        <td>${board.email}</td>
			        <td><a href="/detail?postNumber=${board.postNumber}">${board.title}</a></td>
			        <td>${board.boardDate}</td>
			        <td>${board.commentCount}</td> <!-- 댓글 카운트 표시 --> 
			    </tr>
			</c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 페이징 처리 -->
    <div class="pagination justify-content-center">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}" class="page-link">이전</a>
        </c:if>
        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
            <a href="?page=${pageNumber}" class="page-link">${pageNumber}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}" class="page-link">다음</a>
        </c:if>
    </div>

 <a id="writeLink" href="write">
    <button id="writeButton" type="button" class="btn btn-primary btn float-right">게시글 작성</button>
</a>
</div>
                <!-- /.container-fluid -->
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
    <script src="js/demo/datatables-demo.js"></script>
    <!-- Custom script for login link -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  


  <script>

  $(document).ready(function() {
	    $('#writeButton').click(function() {
	        // 버튼 클릭 시에만 로그인 상태 확인
	        $.get("/api/checkLoginStatus", function(data) {
	            if (data === "Logged in") {
	                // 로그인한 경우에는 글 작성 페이지로 이동
	                window.location.href = "/write";
	            } else {
	                // 로그인하지 않은 경우에는 알림 출력 및 이동 불가
	                alert("로그인 후에 게시글을 작성할 수 있습니다.");
	                return false; // 이동 막기
	            }
	        });
	        return false; // 이동 막기 (버블링과 기본 동작 방지)
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
