<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/SoolWhale/resources/css/member/userLoginForm.css">

<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>

<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/member/userLoginForm.js"></script>
<link rel="stylesheet" href="/SoolWhale/resources/css/member/userLoginForm.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login</title>
<script type="text/javascript">
	$(function() {

		$("#loginBtn").click(function() {		
		    if (!chkData("#managerId", "id를")) {
		        $("#managerId").focus();
		        return;  // 이 부분을 중괄호 안으로 이동합니다.
		    } else if (!chkData("#managerPwd", "비밀번호를")) {
		    	 $("#managerPwd").focus();
		        return;
		    } else {
		        $("#ManagerLoginForm").attr({
		            "method" : "post",
		            "action" : "/SoolWhale/admin/login"
		        });
		        $("#ManagerLoginForm").submit();
		    }
		});

	

		$("#logOutBtn").click(function() {
			location.href = "/SoolWhale/admin/adminLogout"
		});

	});
	
</script>

	    <script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
</head>
<body>
	<div class="container" id="container">
		<div class="form-container sign-in-container">
			<form id="ManagerLoginForm">
				<h1>Sign in</h1>
				<input type="text" id="managerId" name="managerId" placeholder="manager Id" aria-label="Enter your ID" /> 
				<input type="password" id="managerPwd" name="managerPwd" placeholder="Manager Password" aria-label="Enter your password" />
				
			
				<p>
					<!-- type="button" 추가 -->
					<button type="button" id="loginBtn" style="color:blue;">Sign In</button>
				</p>
				
			</form>
		</div>
		
		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-left">
					
					<!-- type="button" 추가 -->
					
				</div>
				<div class="overlay-panel overlay-right">
			
					<h1> ADMIN </h1>
		
				</div>
			</div>
		</div>
	</div>
</body>
</html>