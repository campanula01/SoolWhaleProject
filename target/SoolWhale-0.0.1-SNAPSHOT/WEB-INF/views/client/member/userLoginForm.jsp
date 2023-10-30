<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 네아로 SDK -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<link rel="stylesheet" href="/SoolWhale/resources/css/member/userLoginForm.css">

<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/member/userLoginForm.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<script type="text/javascript">
	$(document).ready(function() {
		var errorMsg = $("#errorMsg").text();
		if (errorMsg) {
			alert(errorMsg);
		}

		$("#loginBtn").click(function() {
			if (!chkData("#id", "id를 ")) {
				$("#id").focus();
				return;
			}
			if (!chkData("#password", "비밀번호를 ")) {
				$("#password").focus();
				return;
			}

			$("#userLoginForm").attr({
				"method" : "post",
				"action" : "/SoolWhale/member/login"
			});
			$("#userLoginForm").submit();
		});
		var naverLogin = new naver.LoginWithNaverId({
			clientId : "hunJ26EH0p6NJfI8aHRJ",
			// 본인의 Client ID로 수정, 띄어쓰기는 사용하지 마세요.
			callbackUrl : "http://localhost:8080/member/callback", // 수정: 원하는 콜백 URL로 변경
			isPopup : false,
			loginButton : {
				color : "white",
				type : 5,
				height : 40
			}
		// 네이버 로그인 버튼 디자인 설정. 필요한 경우 변경하세요.
		});
		naverLogin.init();

	});
</script>
</head>
<body>
	<span id="errorMsg" style="display: none;">${errorMsg}</span>
	<div class="container" id="container">
		<div class="form-container sign-in-container">
			<form id="userLoginForm">
				<h1>Sign in</h1>
				<input type="text" id="id" name="id" placeholder="id"
					aria-label="Enter your ID" /> <input type="password" id="password"
					name="password" placeholder="Password"
					aria-label="Enter your password" />

				<!-- 네이버 로그인 버튼 생성 위치 -->
				<p>
					<!-- type="button" 추가 -->
					<button type="button" id="loginBtn">Sign In</button>
				</p>
				<div id="naverIdLogin"></div>
			</form>
		</div>

		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-left">
					<h1>Welcome Back!</h1>
					<p>To keep connected with us please login with your personal
						info</p>
					<!-- type="button" 추가 -->
					<button type="button" class="ghost" id="signIn">Sign In</button>
				</div>
				<div class="overlay-panel overlay-right">
					<h1>SoolWhale</h1>
					<p>Enter your personal details and start journey with us</p>
					<a href="join"> <!-- type="button" 추가 -->
						<button type="button" class="ghost" id="signUp">Sign Up</button>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>