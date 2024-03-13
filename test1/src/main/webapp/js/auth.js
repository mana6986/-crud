// auth.js
export const auth = {
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
