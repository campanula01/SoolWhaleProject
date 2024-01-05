document.addEventListener('DOMContentLoaded', function() {
	const verificationCodeField = document.getElementById('identityVerification');



	$(function() {
		// jQuery로 각 필드의 값을 가져오기
		var lastName = $("#lastName").val();
		var lastuserNickname = $("#lastuserNickname").val();
		var lastId = $("#lastId").val();
		var lastPassword = $("#lastPassword").val();
		var lastEmail = $("#lastEmail").val();
		var lastPhoneNumber = $("#lastPhoneNumber").val();
		var userNum = $("#userNum").val();



		$("#phoneVerificationBtn").click(function(e) {
			e.preventDefault();

			// 핸드폰 번호 유효성 검사
			var phoneNumber = $("#phoneNumber").val();
			var phoneRegex = /^01(?:0|1|[6-9])(?:\d{7,8})$/;
			if (!phoneRegex.test(phoneNumber)) {
				alert("핸드폰 번호를 입력해주세요.");
				return;
			}

			if (!chkData("#phoneNumber", "phoneNumber를")) {
				return;
			}

			identity.style.display = 'block';

			var phoneNumber = $("#phoneNumber").val();

		});


		// Handle registration form submission.
		$("#editBtn").click(function(e) {
			e.preventDefault();

			if (!chkData("#id", "id를")) return;

			var password = $("#password").val(); // 비밀번호
			var password2 = $("#password2").val(); // 비밀번호 확인


			if (password != "" && password.length < 8) {
				alert("비밀번호는 8자 이상이어야 합니다.");
				return;
			}

			if (password != "" && !chkData("#password2", "비밀번호 확인을")) return;
			if (password !== password2) {
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}

			if (!chkData("#name", "이름을")) return;


			// Ensure full email value
			var emailLocalPart = $("#email").val();
			var emailDomain;
			if ($("#emailOption").val() === "custom") {
				emailDomain = $("#emailDomain").val();
			} else {
				emailDomain = $("#emailOption").val();
			}
			var fullEmail = emailLocalPart + "@" + emailDomain;
			$("#email").val(fullEmail); // Set the full email value


			if (!chkData("#email", "이메일을")) return;
			if (!chkData("#userNickname", "별칭을")) return;

			var newPassword = "";
			if ($("#password").val() == "") {
				newPassword = lastPassword
			} else {
				newPassword = $("#password").val();
			}

			var newEmail = "";
			if ($("#email").val() == "") {
				newEmail = lastEmail
			} else {
				newEmail = $("#email").val();
			}

			var newPhoneNumber = "";
			if ($("#phoneNumber").val() == "") {
				newPhoneNumber = lastPhoneNumber
			} else {
				newPhoneNumber = $("#phoneNumber").val();
			}

			// 데이터를 객체로 구성
			var formData = {
				userNickname: $("#userNickname").val(),
				id: $("#id").val(),
				password: newPassword,
				email: newEmail,
				phoneNumber: newPhoneNumber,
				userNum: userNum,

			};

			// Ajax 요청을 수행
			$.ajax({
				type: "POST",
				url: "/SoolWhale/admin/userEditComplete",
				data: formData, // 데이터를 전송
				success: function(response) {
					 window.location.href = "/SoolWhale/admin/userManagement";
				},
				error: function(xhr, status, error) {
					// 에러 처리 로직
				}
			});
		});
		$("#id").blur(function() {
			// 아이디 입력 필드의 값을 가져옵니다.
			var enteredId = $(this).val();

			// 아이디 유효성 검사 메시지를 초기화합니다.
			$("#id_check").html("");

			// 공백이 있는지 검사합니다.
			if (enteredId.trim() === "") {
				$("#id_check").html("아이디를 입력하세요.");
				$("#editBtn").attr("disabled", "disabled"); // 버튼 비활성화
				return;
			}

			// 아이디의 길이 검사 (예: 6자 이상, 20자 이하)
			if (enteredId.length < 6 || enteredId.length > 20) {
				$("#id_check").html("아이디는 6자 이상 20자 이하로 입력하세요.");
				$("#editBtn").attr("disabled", "disabled"); // 버튼 비활성화
				return;
			}

			// 아이디의 문자 제한 검사 (예: 알파벳, 숫자, 언더스코어만 허용)
			var idPattern = /^[a-zA-Z0-9_]+$/;
			if (!idPattern.test(enteredId)) {
				$("#id_check").html("아이디는 알파벳, 숫자, 언더스코어(_)만 허용됩니다.");
				$("#editBtn").attr("disabled", "disabled"); // 버튼 비활성화
				return;
			}



			// 아이디 중복 체크를 수행합니다.
			if (enteredId != lastId) {
				$.ajax({
					type: "POST",
					url: "/SoolWhale/member/checkId",
					data: { id: enteredId },
					success: function(result) {
						if (result == 1) {
							// 중복된 아이디가 있을 때 메시지를 표시
							$("#id_check").html("중복된 ID");
							// 아이디 입력 필드를 리셋하고 다시 포커스를 맞춥니다.
							$("#id").val("").focus();
							$("#editBtn").attr("disabled", "disabled");
						} else {
							// 사용 가능한 아이디일 때 메시지를 표시
							$("#id_check").html("사용 가능 ID");
							$("#editBtn").removeAttr("disabled");
						}
					}
				});
			};
		});
		// 비밀번호 입력 필드에서 키 입력 이벤트 감지
		$("#password").blur(function() {
			// 비밀번호 입력 필드의 값을 가져옵니다.
			var password = $(this).val();

			// 비밀번호 유효성 검사 메시지를 초기화합니다.
			$("#pw_check").html("");

			// 비밀번호가 8자 이상인지 검사합니다.
			if (password.length < 8) {
				$("#pw_check").html("비밀번호 8자 이상");
			}

			// 공백 문자를 검사합니다.
			if ($.trim(password) !== password) {
				$("#pw_check").html("공백은 입력이 불가능합니다.");
			}
		});

		// 확인 비밀번호 입력 필드에서 키 입력 이벤트 감지
		$("#password2").blur(function() {
			// 비밀번호와 확인 비밀번호 값을 가져옵니다.
			var password = $("#password").val();
			var password2 = $(this).val();

			// 확인 비밀번호 유효성 검사 메시지를 초기화합니다.
			$("#pw_check2").html("");

			// 비밀번호와 확인 비밀번호가 일치하지 않는 경우 메시지를 표시합니다.
			if (password !== password2) {
				$("#pw_check2").html("비밀번호가 불일치");
			} else {
				// 비밀번호가 일치하면 메시지를 표시합니다.
				$("#pw_check2").html("비밀번호 일치");
			}
		});



	});

	// 이메일 입력 필드에서 blur 이벤트를 감지합니다.
	$("#email").blur(function() {
		// Get email's local part (the part before the '@')
		var emailLocalPart = $(this).val();
		var emailLocalPattern = /^[a-zA-Z0-9._%+-]+$/;
		// Handle empty input
		if (emailLocalPart.trim() === "") {
			$("#email_check").html("이메일을 입력하세요.");
			return;
		}

		// Verify basic email pattern (without domain)

		if (!emailLocalPattern.test(emailLocalPart)) {
			$("#email_check").html("올바른 이메일 형식이 아닙니다.");
			return;
		}

		// Determine the domain part based on the user's choice or input
		var emailDomain;
		if ($("#emailOption").val() === "custom") {
			emailDomain = $("#emailDomain").val();
		} else {
			emailDomain = $("#emailOption").val();
		}

		// Construct the full email
		var fullEmail = emailLocalPart + "@" + emailDomain;
		$("#fullEmail").val(fullEmail);


		if (fullEmail != lastEmail) {
			// 서버에서 이메일 중복 검사
			$.ajax({
				url: "/SoolWhale/member/checkEmail",
				type: "POST",
				data: { email: fullEmail },  // using fullEmail here
				success: function(result) {
					if (result == 1) {
						$("#email_check").html("중복된 이메일");
					} else {
						$("#email_check").html("사용 가능한 이메일");
					}
				}
			});
		} else if (fullEmail = lastEmail) {
			$("#email_check").html("기존 이메일");
		}
	});
});

function handleDomainChange() {
	const selectedValue = document.getElementById('emailOption').value;

	if (selectedValue === 'custom') {
		document.getElementById('emailDomain').disabled = false;
		document.getElementById('emailDomain').focus();
	} else {
		document.getElementById('emailDomain').disabled = true;
		document.getElementById('emailDomain').value = selectedValue;
	}
}