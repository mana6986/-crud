<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>회원가입</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        #mailMessage {
            position: relative;
            left: 10px;
        }
    </style>
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                            <form class="user">
                                <div class="form-group">
                                    <input
                                        type="text"
                                        class="form-control form-control-user"
                                        placeholder="이름"
                                        id="name"
                                        name="name"
                                        maxlength="10"
                                    />
                                </div>
                                <div id="message" style="margin-top: 3px;"></div>
                                <div class="form-group row">
                                    <div class="col-sm-9 mb-3 mb-sm-0">
                                        <input
                                            type="email"
                                            class="form-control form-control-user"
                                            placeholder="이메일주소"
                                            id="email"
                                            name="email"
                                        />
                                    </div>
                                    <div class="col-sm-3">
                                        <button type="button" class="btn btn-primary btn-user btn-block" onclick="checkEmail()">중복확인</button>
                                    </div>
                                   <!--  <div id="mailMessage" style="margin-top: 3px;"></div> -->
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input
                                            type="password"
                                            class="form-control form-control-user"
                                            placeholder="비밀번호"
                                            id="password"
                                            name="password"
                                            minlength="8"
                                            maxlength="15"
                                            required
                                        />
                                        <div id="passwordMessage"></div>
                                    </div>
                                    <div class="col-sm-6">
                                        <input
                                            type="password"
                                            class="form-control form-control-user"
                                            placeholder="비밀번호 확인"
                                            id="confirmPassword"
                                            name="confirmPassword"
                                            minlength="8"
                                            maxlength="15"
                                            required
                                        />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input
                                        type="tel"
                                        class="form-control form-control-user"
                                        placeholder="전화번호"
                                        id="phone"
                                        name="phone"
                                        maxlength="11"
                                    />
                                    <div id="phoneMessage"></div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-9 mb-3 mb-sm-0">
                                        <input
                                            type="text"
                                            class="form-control form-control-user"
                                            placeholder="주소"
                                            id="address"
                                            name="address"
                                        />
                                    </div>
                                    <div class="col-sm-3">
                                        <button type="button" class="btn btn-primary btn-user btn-block" onclick="openDaumPostcodeService()">주소찾기</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input
                                        type="text"
                                        class="form-control form-control-user"
                                        placeholder="상세주소"
                                        id="addressDetail"
                                        name="addressDetail"
                                    />
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input
                                            type="text"
                                            class="form-control form-control-user"
                                            placeholder="우편번호"
                                            id="postalCode"
                                            name="postalCode"
                                        />
                                    </div>
                                    <div class="col-sm-6">
                                        <input
                                            type="text"
                                            class="form-control form-control-user"
                                            placeholder="참고사항"
                                            id="note"
                                            name="note"
                                        />
                                    </div>
                                </div>
                                <button type="button" onclick="register()" class="btn btn-primary btn-user btn-block">Register Account</button>
                            </form>
                            <div id="checkMessage"></div>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="login">이미 계정이 있으신가요? 로그인!</a>
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        // 여기에 스크립트 내용 추가
        var inputField = document.getElementById("name");
        var messageElement = document.getElementById("message");
        var emailField = document.getElementById("email");
        var mailMessageElement = document.getElementById("mailMessage");
        var passwordField = document.getElementById("password");
        var passwordMessageElement = document.getElementById("passwordMessage");
        var confirmPasswordField = document.getElementById("confirmPassword");
        var phoneField = document.getElementById("phone");
        var phoneMessageElement = document.getElementById("phoneMessage");
        var checkMessageElement = document.getElementById("checkMessage");

        // 사용자 이름 입력 제한
        inputField.addEventListener("blur", function() {
            var regex = /^[a-zA-Z0-9]*$/;
            var name = inputField.value;

            if (!regex.test(name)) {
                messageElement.textContent = "사용 불가능한 닉네임입니다. 영어와 숫자만 입력해주세요.";
                messageElement.style.color = "red";
                return;
            }

            fetch('/checkName?name=' + encodeURIComponent(name))
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('서버 응답이 실패했습니다.');
                    }
                    return response.text();
                })
                .then(function(data) {
                    if (data === 'duplicate') {
                        messageElement.textContent = "중복된 닉네임입니다.";
                        messageElement.style.color = "red";
                    } else {
                        messageElement.textContent = "사용 가능한 닉네임입니다.";
                        messageElement.style.color = "green";
                    }
                })
                .catch(function(error) {
                    console.error('오류 발생:', error);
                    alert('서버 응답이 실패했습니다.');
                });
        });



        // 이메일 형식 확인
        emailField.addEventListener("input", function() {
            var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!regex.test(emailField.value)) {
                emailField.value = emailField.value.replace(/[^a-zA-Z0-9._@]/g, '');
            }
        });

        emailField.addEventListener("blur", function() {
            var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (regex.test(emailField.value)) {
                mailMessageElement.textContent = "사용 가능한 이메일입니다.";
                mailMessageElement.style.color = "green";
            } else {
                mailMessageElement.textContent = "사용 불가능한 이메일입니다.";
                mailMessageElement.style.color = "red";
            }
        });

     // 비밀번호 일치 확인
       function validatePassword(password) {
    var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,15}$/;
    return regex.test(password);
}

       passwordField.addEventListener("input", function() {
    	    var password = passwordField.value;
    	    var confirmPassword = confirmPasswordField.value;

    	    if (!validatePassword(password)) {
    	        passwordMessageElement.textContent = "비밀번호는 숫자, 영문, 특수문자가 각각 최소 1번 이상 포함되어야 하며, 길이는 8~15자여야 합니다.";
    	        passwordMessageElement.style.color = "red";
    	    } else if (password !== confirmPassword) {
    	        passwordMessageElement.textContent = "비밀번호가 일치하지 않습니다.";
    	        passwordMessageElement.style.color = "red";
    	    } else {
    	        passwordMessageElement.textContent = "사용 가능한 비밀번호입니다.";
    	        passwordMessageElement.style.color = "green";
    	    }
    	});

    	confirmPasswordField.addEventListener("input", function() {
    	    var password = passwordField.value;
    	    var confirmPassword = confirmPasswordField.value;

    	    if (validatePassword(password)) {
    	        if (password === confirmPassword) {
    	            passwordMessageElement.textContent = "사용 가능한 비밀번호입니다.";
    	            passwordMessageElement.style.color = "green";
    	        } else {
    	            passwordMessageElement.textContent = "비밀번호가 일치하지 않습니다.";
    	            passwordMessageElement.style.color = "red";
    	        }
    	    } else {
    	        passwordMessageElement.textContent = "비밀번호는 숫자, 영문, 특수문자가 각각 최소 1번 이상 포함되어야 하며, 길이는 8~15자여야 합니다.";
    	        passwordMessageElement.style.color = "red";
    	    }
    	});

        // 전화번호 형식 확인
        phoneField.addEventListener("input", function() {
            var phoneNumber = phoneField.value;

            if (/^010\d{8}$/.test(phoneNumber)) {
                phoneMessageElement.textContent = "맞는 번호입니다.";
                phoneMessageElement.style.color = "green";
            } else {
                phoneMessageElement.textContent = "사용 불가능한 번호입니다.";
                phoneMessageElement.style.color = "red";
            }
        });

        // 다음 주소 API
        function openDaumPostcodeService() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var roadAddr = data.roadAddress;
                    var extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    document.getElementById('postalCode').value = data.zonecode;
                    document.getElementById('address').value = roadAddr;
                    document.getElementById('addressDetail').value = data.jibunAddress + extraRoadAddr;

                    if (roadAddr !== '') {
                        document.getElementById("note").value = extraRoadAddr;
                    } else {
                        document.getElementById("note").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                    if (data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                    document.getElementById('address').removeEventListener('click', openDaumPostcodeService);
                }
            }).open();
        }

        document.getElementById('address').addEventListener('click', function() {
            openDaumPostcodeService();
        });

        // 회원가입 함수
        function register() {
            var username = document.getElementById('name').value;
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            var email = document.getElementById('email').value;
            var phone = document.getElementById('phone').value;
            var address = document.getElementById('address').value;
            var addressDetail = document.getElementById('addressDetail').value;
            var postalCode = document.getElementById('postalCode').value;
            var note = document.getElementById('note').value;

            if (username && password && confirmPassword && email && phone && address && addressDetail && postalCode && note) {
                if (password === confirmPassword) {
                    var data = {
                        name: username,
                        email: email,
                        password: password,
                        phone: phone,
                        address: address,
                        addressDetail: addressDetail,
                        postalCode: postalCode,
                        note: note
                    };

                    console.log('회원가입 데이터:', data);

                    fetch('/register', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(data)
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log('Success:', data);
                        alert("가입되었습니다.");
                        window.location.href = "login";
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        alert("데이터 전송 중 오류가 발생했습니다.");
                    });
                } else {
                    alert("비밀번호가 일치하지 않습니다.");
                }
            } else {
                alert("모든 필드를 입력하세요.");
            }
            
        }
        function checkEmail() {
            var email = document.getElementById('email').value;
            fetch('/checkEmail?email=' + encodeURIComponent(email))
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('서버 응답이 실패했습니다.');
                    }
                    return response.text();
                })
                .then(function(data) {
                    if (data === 'duplicate') {
                        alert('중복된 이메일입니다.');
                    } else {
                        alert('사용 가능한 이메일입니다.');
                    }
                })
                .catch(function(error) {
                    console.error('오류 발생:', error);
                    alert('서버 응답이 실패했습니다.');
                });
        }


        
        function checkFields() {
            var name = document.getElementById('name').value;
            var email = document.getElementById('email').value;
            var phone = document.getElementById('phone').value;

            fetch('/checkFields', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ name: name, email: email, phone: phone })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답이 실패했습니다.');
                }
                return response.json();
            })
            .then(data => {
                // 사용자 이름 메시지 처리
                if (data.nameUnique) {
                    document.getElementById('message').textContent = "사용 가능한 이름입니다.";
                    document.getElementById('message').style.color = "green";
                } else {
                    document.getElementById('message').textContent = "사용 불가능한 이름입니다.";
                    document.getElementById('message').style.color = "red";
                }

                // 이메일 메시지 처리
                if (data.emailUnique && data.emailFormat) {
                    document.getElementById('mailMessage').textContent = "사용 가능한 이메일입니다.";
                    document.getElementById('mailMessage').style.color = "green";
                } else {
                    document.getElementById('mailMessage').textContent = "사용 불가능한 이메일입니다.";
                    document.getElementById('mailMessage').style.color = "red";
                }

                // 전화번호 메시지 처리
                if (data.phoneFormat) {
                    document.getElementById('phoneMessage').textContent = "사용 가능한 전화번호입니다.";
                    document.getElementById('phoneMessage').style.color = "green";
                } else {
                    document.getElementById('phoneMessage').textContent = "사용 불가능한 전화번호입니다.";
                    document.getElementById('phoneMessage').style.color = "red";
                }

                // 모든 조건이 만족하면 사용 가능 메시지 출력
                if (data.nameUnique && data.emailUnique && data.emailFormat && data.phoneFormat) {
                    alert('모든 조건이 만족하여 사용 가능합니다.');
                }
            })
            .catch(error => {
                console.error('오류 발생:', error);
                alert('필드 확인 중 오류가 발생했습니다.');
            });
        }


    </script>
</body>
</html>
