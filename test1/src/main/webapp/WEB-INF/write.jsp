
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    // 로그인 여부를 확인
    boolean isLoggedIn = false;
    Object user = session.getAttribute("user");
    if (user != null) {
        isLoggedIn = true;
    }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <script src="js/common.js"></script>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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
          <!-- End of Topbar -->

          <!-- Begin Page Content -->
         <div class="container-fluid h-100">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">게시판</h1>

    <!-- DataTales Example -->
   <!-- DataTales Example -->
<div class="card shadow mb-4 h-75">
    <div class="card-body">
        <!-- Basic Card Example -->
        <form action="#" method="post" enctype="multipart/form-data" class="h-100">
    <div class="card shadow mb-4 h-100">
        <div class="card-header py-3">
            <div class="col-sm-11 float-left">
                <input type="text" id="titleInput" class="form-control" placeholder="제목" />
            </div>
            <!-- 추가된 부분 -->
            <button type="button" class="btn btn-primary btn float-right ml-1" onclick="insertPost()">
                작성완료
            </button>
        </div>
         <input type="file" id="fileInput" />
        <div class="card-body h-100">
            <textarea id="contentInput" cols="30" class="form-control h-100" placeholder="내용" style="resize: none"></textarea>
        </div>
    </div>
</form>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Page level custom scripts -->
    <script src="js/demo/datatables-demo.js"></script>
    
   
    <script>
   

     
    

    function insertPost() {
	    var title = document.getElementById("titleInput").value;
	    var content = document.getElementById("contentInput").value;
	    var file = document.getElementById('fileInput').files[0];

	    var formData = new FormData();
	    formData.append("title", title);
	    formData.append("content", content);
	    if (file) { // 파일이 선택되었는지 확인
	        formData.append("file", file);
	    }

	    // 게시물 저장 전에 확인 창을 표시
	    if (confirm("작성하시겠습니까?")) {
	        // 공통 AJAX 함수를 사용하여 서버로 데이터 전송
	        public_ajax("/write", "POST", formData,
	            function(response) { // 성공 콜백
	                console.log("게시물이 성공적으로 저장되었습니다.");
	                alert("저장되었습니다.");
	                window.location.href = "/tables";
	            },
	            function(xhr, status, error) { // 오류 콜백
	                console.error("게시물 저장 중 오류가 발생하였습니다.", error);
	                alert("게시물 저장 중 오류가 발생했습니다.");
	            }
	        );
	    }
	}
    	    
    	    
     

    	</script>
 <!-- function insertPost() {
    	    var title = document.getElementById("titleInput").value;
    	    var content = document.getElementById("contentInput").value;
    	    var file = document.getElementById('fileInput').files[0];

    	    var formData = new FormData();
    	    formData.append("title", title);
    	    formData.append("content", content);
    	    formData.append("file", file);

    	    if (confirm("작성하시겠습니까?")) {
    	    	  public_ajax("/write/" , 'POST', data,
    	      	        function(result, textStatus) {
    	      	            loadAndRenderComments(); // 댓글을 다시 로드하고 렌더링
    	      	            console.log("게시물이 성공적으로 저장되었습니다.", result);
    	      	            alert("저장되었습니다.");
    	      	            window.location.href = "/tables";
    	      	        },
    	      	        function(xhr, textStatus, errorThrown) {
    	      	        	 console.error("게시물 저장 중 오류가 발생하였습니다.");
    	   	                console.error(xhr.responseText);
    	      	        }
    	      	    );
    	      	}
    	} -->
  </body>
</html>
