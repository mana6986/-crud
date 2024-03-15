// auth.js 파일
$(document).ready(function() {
    const isLoggedIn = false; // 이 부분을 서버 사이드 템플릿으로 대체해야 합니다.
    const userEmail = ""; // 이 부분도 서버 사이드 템플릿으로 대체

    const auth = {
        setupAuth: function(isLoggedIn, userEmail) {
            const loginDropdownLink = $('#loginDropdownLink');
            const loginCollapseLink = $('#loginCollapseLink');

            loginDropdownLink.off('click').on('click', function(event) {
                event.preventDefault();
                auth.confirmLogout();
            });

            loginCollapseLink.off('click').on('click', function(event) {
                event.preventDefault();
                auth.confirmLogout();
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
            const result = confirm('로그아웃 하시겠습니까?');
            if (result) {
                alert('로그아웃 되었습니다.');
                window.location.href = 'logout';
            } else {
                alert('로그아웃이 취소되었습니다.');
            }
        }
    };

    // 서버 사이드에서 제공한 로그인 여부와 사용자 이메일을 JavaScript 변수로 변환
    // 이 부분은 서버 사이드 코드로 대체되어야 합니다. 예시:
    // const isLoggedIn = ${not empty user};
    // const userEmail = "${user.email}";

    auth.setupAuth(isLoggedIn, userEmail);
});
