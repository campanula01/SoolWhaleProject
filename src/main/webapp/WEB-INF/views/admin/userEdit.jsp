<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="/SoolWhale/resources/css/member/userJoinForm.css">
<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/member/userEdit.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 수정</title>
</head>
<body>
	<div class="container" id="container">
		<div class="form-container sign-in-container">
			<input type="hidden" id="userNum" name="userNum" value="${userData.userNum }">
			<input type="hidden" id="lastName" name="lastName" value="${userData.name }">
			<input type="hidden" id="lastuserNickname" name="lastuserNickname" value="${userData.userNickname }">
			<input type="hidden" id="lastId" name="lastId" value="${userData.id }">
			<input type="hidden" id="lastPassword" name="lastPassword" value="${userData.password }">
			<input type="hidden" id="lastEmail" name="lastEmail" value="${userData.email }">
			<input type="hidden" id="lastPhoneNumber" name="lastPhoneNumber" value="${userData.phoneNumber }">
			
			<form id="userJoinForm" name="userJoinForm">
			
				<h1>
					<img src="/SoolWhale/resources/img/common/user_img.png" />Edit
				</h1>
				<div class="field">
				
					<label>이름</label><input type="text" id="name" name="name" value="${userData.name}"
						maxlength="10" readonly>
				</div>
				<div class="field">
					<label>별칭</label><input type="text" id="userNickname"
						name="userNickname" value="${ userData.userNickname}" maxlength="10">
				</div>
				<div class="field">
					<label>아이디</label><input type="text" id="id" name="id"
						maxlength="10" value="${userData.id}" autocomplete="new-id"><span
						id="id_check"></span>
				</div>
				<div class="field">
					<label>비밀번호</label><input type="password" id="password"
						name="password" maxlength="15" autocomplete="new-password"> <label></label><span
						id="pw_check"></span>
				</div>
				<div class="field">
					<label>비밀번호확인</label><input type="password" id="password2"
						name="password2" maxlength="15" autocomplete="new-password"> <label></label><span
						id="pw_check2"></span>
				</div>

				<div class="field email">
					<label>이메일</label> <input type="text" id="email" name="email"
						maxlength="10" > @ <input type="text"
						id="emailDomain" name="emailDomain" placeholder="도메인 입력" disabled>
					<select id="emailOption" name="emailOption"
						onchange="handleDomainChange()">
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						<!-- 다른 이메일 도메인 옵션을 추가할 수 있습니다. -->
						<option value="custom">직접 입력</option>
					</select> 
					
					<input type="hidden" id="fullEmail" name="fullEmail"> <span
						id="email_check"></span>
				</div>
                    <div class="field">
                        <label>휴대전화</label>    <input type="text" placeholder="전화번호 입력" id="phoneNumber" name="phoneNumber"> 
                        
                    </div>
				<!-- 3. 필드(생년월일) -->
				<!-- 4. 필드(성별) -->


				<!-- 6. 가입하기 버튼 -->
				<button id="editBtn" name="editBtn">정보 수정</button>
			</form>
		</div>
		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-right"></div>
			</div>
		</div>
	</div>
</body>
</html>
