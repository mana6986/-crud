<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
                <a class="collapse-item" id="loginCollapseLink">Login</a>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="module" src="/auth.js"></script>
<script>
  // 서버 사이드에서 제공한 로그인 여부와 사용자 이메일을 JavaScript 변수로 변환
  $(document).ready(function() {
    const isLoggedIn = ${not empty user};
    const userEmail = "${user.email}";

    // 한 번 로그아웃 확인을 이미 한 경우를 체크하기 위한 변수
    let logoutConfirmed = false;

    // auth 모듈의 코드를 직접 여기에 포함시킵니다.
    const auth = {
        setupAuth: function(isLoggedIn, userEmail) {
            const loginDropdownLink = $('#loginDropdownLink');
            const loginCollapseLink = $('#loginCollapseLink');

            // 기존의 이벤트 리스너를 제거하고 새로운 이벤트 리스너를 추가
            loginDropdownLink.off('click').on('click', function(event) {
                event.preventDefault(); // 기본 동작 방지
                auth.confirmLogout(); // 로그아웃 확인
            });

            loginCollapseLink.off('click').on('click', function(event) {
                event.preventDefault(); // 기본 동작 방지
                auth.confirmLogout(); // 로그아웃 확인
            });

            if (isLoggedIn) {
                loginDropdownLink.text('로그아웃');
                loginCollapseLink.text('로그아웃');
            } else {
                loginDropdownLink.text('로그인').attr('href', 'login');
                loginCollapseLink.text('로그인').attr('href', 'login');
            }
        },

        confirmLogout: function() {
            if(isLoggedIn && !logoutConfirmed) {
                const result = confirm('로그아웃 하시겠습니까?');
                if (result) {
                    // 로그아웃 확인 후 로그아웃을 진행하고, 확인 상태를 저장
                    window.location.href = 'logout';
                    logoutConfirmed = true;
                }
            } else if (!isLoggedIn) {
                // 로그인되지 않은 상태에서는 로그인 페이지로 이동
                window.location.href = 'login';
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
