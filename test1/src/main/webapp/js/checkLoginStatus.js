// checkLoginStatus.js

export function checkLoginStatus() {
    $.get("/checkLoginStatus", function(data) {
        if (data.loggedIn) {
            $('.mr-2').text(data.user.name);
        }
    });
}
