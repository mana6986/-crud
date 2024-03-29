<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link
      href="vendor/fontawesome-free/css/all.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet" />
  </head>

  <body class="bg-gradient-primary">
    <div class="container">
      <!-- Outer Row -->
      <div class="row justify-content-center">
        <div class="col-xl-10 col-lg-12 col-md-9">
          <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
              <!-- Nested Row within Card Body -->
              <div class="row">
                <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                <div class="col-lg-6">
                  <div class="p-5">
                    <div class="text-center">
                      <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                    </div>
                    <form class="user" action="/login" method="post">
                      <div class="form-group">
                        <input
                          type="email"
                          class="form-control form-control-user"
                          aria-describedby="emailHelp"
                          placeholder="Enter Email Address..."
                          id="email"
                          name="email"
                        />
                      </div>
                      <div class="form-group">
                        <input
                          type="password"
                          class="form-control form-control-user"
                          placeholder="Password"
                          id="password"
                          name="password"
                        />
                      </div>
                      <div class="form-group">
                        <div class="custom-control custom-checkbox small">
						<input type="checkbox" id="idSaveCheck">아이디 저장하기
                        </div>
                      </div>
                    <button type="submit" class="btn btn-primary btn-user btn-block" id="loginButton">
					    로그인
					</button>

                      <hr />
                      <div class="text-center">
                        <a class="small" href="membership">Create an Account!</a>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
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
   <script>console.log(sessionStorage.getItem('session'));</script>
   
<script>
    $(document).ready(function () {
        var key = getCookie("key");
        $("#email").val(key);

        if ($("#email").val() != "") {
            $("#idSaveCheck").attr("checked", true);
        }

        $("#idSaveCheck").change(function () {
            if ($("#idSaveCheck").is(":checked")) {
                setCookie("key", $("#email").val(), 7);
            } else {
                deleteCookie("key");
            }
        });

        $("#email").keyup(function () {
            if ($("#idSaveCheck").is(":checked")) {
                setCookie("key", $("#email").val(), 7);
            }
        });

        // URL에서 error 매개변수를 가져옴
        const urlParams = new URLSearchParams(window.location.search);
        // error 매개변수의 값이 1이면 아이디나 비밀번호가 올바르지 않음
        const error = urlParams.get('error');
        if (error === '1') {
            alert('아이디나 비밀번호를 확인해주세요.');
        }
    });

    function setCookie(cookieName, value, exdays) {
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }

    function deleteCookie(cookieName) {
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }

    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if (start != -1) {
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if (end == -1) end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }

    // 로그인 버튼 클릭 시 알림 표시
    document.getElementById("loginButton").addEventListener("click", function () {
        // 여기에 로그인 처리 로직을 추가할 수 있음
        // alert("로그인되었습니다."); // 이 줄을 주석 처리하여 알림을 표시하지 않음
    });
</script>
  </body>
</html>
