// 닉네임 입력 제한 및 중복 확인
export function handleNicknameInput(inputField, messageElement) {
    inputField.addEventListener("input", function(event) {
        var regex = /^[a-zA-Z0-9]*$/; // 영어 대소문자와 숫자만 허용하는 정규 표현식
        var input = event.target.value;

        if (!regex.test(input)) {
            event.target.value = input.replace(/[^a-zA-Z0-9]/g, ''); // 영어와 숫자 이외의 문자는 제거합니다.
        }

        var name = inputField.value.trim(); // 입력값에서 앞뒤 공백을 제거합니다.

        // 입력값이 빈 문자열인 경우
        if (name === "") {
            messageElement.textContent = "닉네임을 입력해주세요.";
            messageElement.style.color = "red";
            return;
        }

        // 닉네임 중복 확인을 위해 서버에 요청합니다.
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
}

// 이메일 형식 확인
export function validateEmail(emailField, mailMessageElement) {
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
}

// 비밀번호 확인
export function validatePassword(passwordField, confirmPasswordField, passwordMessageElement) {
    function validatePassword(password) {
        var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,15}$/;
        return regex.test(password);
    }

    passwordField.addEventListener("blur", function() {
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
}

// 휴대폰번호 형식 확인
export function validatePhoneNumber(phoneField, phoneMessageElement) {
    phoneField.addEventListener("blur", function() {
        var phoneNumber = phoneField.value;

        if (/^010\d{8}$/.test(phoneNumber)) {
            phoneMessageElement.textContent = "맞는 번호입니다.";
            phoneMessageElement.style.color = "green";
        } else {
            phoneMessageElement.textContent = "사용 불가능한 번호입니다.";
            phoneMessageElement.style.color = "red";
        }
    });
}
