<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <script type="module" src="<c:url value='/js/membership.js'/>"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<script src="js/common.js"></script>
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
                                   <div id="mailMessage" style="margin-top: 3px;"></div>
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
                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
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
                                        <button type="button" class="btn btn-primary btn-user btn-block" onclick="openDaumPostcodeService()" value="우편번호 찾기">주소찾기</button>
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
								<button type="button" onclick="register()" class="btn btn-primary btn-user btn-block" id="registerBtn" disabled>Register Account</button>
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



function openDaumPostcodeService() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("note").value = extraAddr;
            
            } else {
                document.getElementById("note").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postalCode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addressDetail").focus();
        }
    }).open();
}




function register() {
    var name = document.getElementById('name').value;
    var password = document.getElementById('password').value;
    var confirmPassword = document.getElementById('confirmPassword').value;
    var email = document.getElementById('email').value;
    var phone = document.getElementById('phone').value;
    var address = document.getElementById('address').value;
    var addressDetail = document.getElementById('addressDetail').value;
    var postalCode = document.getElementById('postalCode').value;
    var note = document.getElementById('note').value;

    // 모든 필드가 비어있는지 체크
    if (!name || !password || !confirmPassword || !email || !phone || !address || !addressDetail || !postalCode || !note) {
        alert("모든 필드를 입력하세요.");
        return;
    }

    // 이름에 한글이 포함되었는지 확인
    var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    if (regex.test(name)) {
        alert("이름에는 한글을 사용할 수 없습니다.");
        return;
    }

    // 이메일 형식 확인
    var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailRegex.test(email)) {
        alert("올바른 이메일을 입력해주세요");
        return;
    }

    // 비밀번호와 비밀번호 확인이 일치하는지 확인
    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return;
    }

    // 비밀번호가 올바른 형식인지 확인
    var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z\d!@#$%^&*(),.?":{}|<>]{8,15}$/;
    if (!passwordRegex.test(password)) {
        alert("비밀번호는 숫자, 영어, 특수문자가 각 1자 이상 포함되어야 하며, 8~15자리여야 합니다.");
        return;
    }

    // 전화번호 형식이 올바른지 확인
    var phoneRegex = /^010\d{8}$/;
    if (!phoneRegex.test(phone)) {
        alert("올바른 휴대폰 번호를 입력하세요.");
        return;
    }

    // Register 버튼을 비활성화하여 중복 확인 요청 중임을 표시
    var registerBtn = document.getElementById('registerBtn');
    registerBtn.disabled = true;

    var data = {
        name: name,
        password: password,
        email: email,
        phone: phone,
        address: address,
        addressDetail: addressDetail,
        postalCode: postalCode,
        note: note
    };

    public_ajax('/register', 'POST', data,
            function(responseData) { // 성공 콜백 함수
                console.log('Success:', responseData);
                if (confirm("가입하시겠습니까?")) {
                    window.location.href = "login";
                }
            },
            function(xhr, textStatus, errorThrown) { // 오류 콜백 함수
                console.error('Error:', errorThrown);
                alert("데이터 전송 중 오류가 발생했습니다.");
                registerBtn.disabled = false; // 오류가 발생했을 때 버튼을 다시 활성화
            }
        );
}            
  


document.addEventListener('DOMContentLoaded', function() {
    var emailField = document.getElementById('email');
    var mailMessageElement = document.getElementById('mailMessage'); // 메시지를 표시할 요소의 ID를 가정함

    emailField.addEventListener("blur", function() {
        var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        if (regex.test(emailField.value)) {
            mailMessageElement.textContent = "중복체크를 해주세요.";
            mailMessageElement.style.color = "green";
        } else {
            mailMessageElement.textContent = "올바른 이메일 형식이 아닙니다.";
            mailMessageElement.style.color = "red";
        }
    });


   // 중복 체크 버튼 클릭 여부를 추적하는 변수
   var isCheckButtonClicked = false;

window.checkEmail = function() {
    isCheckButtonClicked = true;
    var mailMessageElement = document.getElementById('mailMessage'); // 메일 메시지를 표시할 요소의 ID를 가정함
    var emailField = document.getElementById('email'); // 이메일 필드의 ID가 'email'이라고 가정함
    mailMessageElement.textContent = "";
    var email = emailField.value;
    emailField.blur();
    
    // 이메일 형식을 확인하는 정규표현식
    var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // 이메일 주소의 형식을 검사
    if (!emailRegex.test(email)) {
        alert('올바른 이메일 형식이 아닙니다.');
        return;
    }

    // 이메일이 형식에 맞는 경우 서버로 중복 확인 요청
    var url = '/checkEmail?email=' + encodeURIComponent(email);

    public_ajax(url, 'GET', null, 
        function(data) { // 성공 콜백 함수
            // 서버 응답을 올바르게 처리하기 위해 result 처리 방식을 확인해야 합니다.
            // 예제에서는 서버 응답이 단순 문자열 'duplicate' 또는 그렇지 않은 경우를 가정합니다.
            if (data === 'duplicate') {
                alert('중복된 이메일입니다.');
                document.getElementById('registerBtn').disabled = true; // 버튼 비활성화
                emailField.disabled = false; // 이메일 필드 활성화 유지
            } else {
                alert('사용 가능한 이메일입니다.');
                document.getElementById('registerBtn').disabled = false; // 버튼 활성화
                emailField.disabled = true; // 이메일 필드 비활성화
            }
        },
        function(xhr, textStatus, errorThrown) { // 오류 콜백 함수
            console.error('오류 발생:', textStatus + ": " + errorThrown);
            alert('서버 응답이 실패했습니다.');
        }
    );
};
});

/* // 이메일이 형식에 맞는 경우 서버로 중복 확인 요청
public_ajax(url, 'GET', {}, // GET 요청이므로 data는 비워둠
        function(data) { // 성공 콜백 함수
            if (data === 'duplicate') {
                alert('중복된 이메일입니다.');
                document.getElementById('registerBtn').disabled = true; // 버튼 비활성화
                document.getElementById('email').disabled = false; // 이메일 필드 활성화 유지
            } else {
                alert('사용 가능한 이메일입니다.');
                document.getElementById('registerBtn').disabled = false; // 버튼 활성화
                document.getElementById('email').disabled = true; // 이메일 필드 비활성화
            }
        },
        function(xhr, textStatus, errorThrown) { // 오류 콜백 함수
            console.error('오류 발생:', errorThrown);
            alert('서버 응답이 실패했습니다.');
        }
    );
 */

</script>

  <script type="module">
        import * as membership from './js/membership.js';
      
        
    
      

        document.addEventListener('DOMContentLoaded', () => {
            const inputField = document.getElementById("name");
            const messageElement = document.getElementById("message");
            const emailField = document.getElementById("email");
            const mailMessageElement = document.getElementById("mailMessage");
            const passwordField = document.getElementById("password");
            const confirmPasswordField = document.getElementById("confirmPassword");
            const passwordMessageElement = document.getElementById("passwordMessage");
            const phoneField = document.getElementById("phone");
            const phoneMessageElement = document.getElementById("phoneMessage");

            // 닉네임 처리
            membership.handleNicknameInput(inputField, messageElement);
            
            // 이메일 처리
            membership.validateEmail(emailField, mailMessageElement);
            
            // 비밀번호 처리
            membership.validatePassword(passwordField, confirmPasswordField, passwordMessageElement);
            
            // 휴대폰 번호 처리
            membership.validatePhoneNumber(phoneField, phoneMessageElement);
	
			 document.getElementById('verifyFieldsButton').addEventListener('click', async () => {
        const result = await verifyFieldsWithServer(nameField.value, emailField.value, phoneField.value);
        // 여기에 result를 사용하여 추가적인 UI 업데이트 또는 액션 수행
    });
        });
        </script>

    
    
</body>
</html>
