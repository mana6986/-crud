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
         <%@ include file="sidebar.jsp" %>
        <!-- End of Sidebar -->
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
              
                <!-- End of Topbar -->
 			<%@ include file="header.jsp" %> 
 			
 			               
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
			        <td>${board.name}</td>
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



</script>



    
    
    
</body>
</html>
