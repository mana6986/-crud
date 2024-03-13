<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>

    <!-- Bootstrap CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="fontawesome/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/header.css" rel="stylesheet">
</head>

<body>
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
                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                        <c:if test="${not empty user}">
                            <c:out value="${user.name}" />
                        </c:if>
                        <c:if test="${empty user}">
                            guest
                        </c:if>
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
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="module" src="/auth.js"></script>
<script>
  // 서버 사이드에서 제공한 로그인 여부와 사용자 이메일을 JavaScript 변수로 변환
  $(document).ready(function() {
    const isLoggedIn = ${not empty user};
    const userEmail = "${user.email}";

    // auth 모듈의 코드를 직접 여기에 포함시킵니다.
    const auth = {
        setupAuth: function(isLoggedIn, userEmail) {
            const loginDropdownLink = $('#loginDropdownLink');
            const loginCollapseLink = $('#loginCollapseLink');

            if (isLoggedIn) {
                loginDropdownLink.text('로그아웃');
                loginCollapseLink.text('로그아웃');

                loginDropdownLink.on('click', function(event) {
                    event.preventDefault();
                    auth.confirmLogout();
                });

                loginCollapseLink.on('click', function() {
                    auth.confirmLogout();
                });

            } else {
                loginDropdownLink.text('로그인').attr('href', 'login');
                loginCollapseLink.text('로그인').attr('href', 'login');
            }
        },

        confirmLogout: function() {
            const result = confirm('로그아웃 하시겠습니까?');
            if (result) {
                alert('로그아웃 되었습니다.');
                window.location.href = 'logout';
            } else {
                alert('로그아웃이 취소되었습니다.');
            }
        },

        checkUserStatus: function() {
            $.get("/checkLoginStatus", function(data) {
                if (data.loggedIn) {
                    $('.mr-2').text(data.user.name);
                }
            });
        }
    };

    auth.setupAuth(isLoggedIn, userEmail);
  });
</script>

</html>
