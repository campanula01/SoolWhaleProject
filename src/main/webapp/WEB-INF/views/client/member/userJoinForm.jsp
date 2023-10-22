<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/member/userJoinForm.css">
    <script src="/resources/js/common/jquery-3.7.0.min.js"></script>
    <script src="/resources/js/common/common.js"></script>
     <script src="/resources/js/member/userJoinForm.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 가입</title>
</head>
<body>
    <div class="container" id="container">
        <div class="form-container sign-in-container">
            <form id="userJoinForm" name="userJoinForm">
               <h1>	
				<img src="/resources/img/common/user_img.png" />
				JOIN</h1>
                <div class="field">
                    <label>아이디</label><input type="text" id="id" name="id" maxlength="10" required>
              		<label></label><span id="id_check"></span>  
                </div>
                <div class="field">
                    <label>비밀번호</label><input type="password" id="password"  name="password" maxlength="15" required >
                     <label></label><span id="pw_check"></span>
                    </div>                    
                <div class="field">
                     <label>비밀번호확인</label><input type="password" id="password2" name="password2" maxlength="15" required >
                      <label></label><span id="pw_check2"></span>               
				</div>
                <div class="field">
                    <label>이름</label><input type="text" id="name" name="name"  maxlength="10" required>
                </div>
	            <div class="field email">
				    <label>이메일</label>
				    <input type="text" id="email" name="email" maxlength="10" required>
				    @
				    <input type="text" id="emailDomain" name="emailDomain" placeholder="도메인 입력" disabled>
				    <select id="emailOption" name="emailOption" onchange="handleDomainChange()">
				        <option value="naver.com">naver.com</option>
				        <option value="gmail.com">gmail.com</option>
				        <option value="yahoo.com">daum.net</option>
				        <option value="hotmail.com">nate.com</option>
				        <!-- 다른 이메일 도메인 옵션을 추가할 수 있습니다. -->
				        <option value="custom">직접 입력</option>
				    </select>
				      <input type="hidden" id="fullEmail" name="fullEmail">
				    <span id="email_check"></span>
				</div>
                <div class="field">
                    <label>별칭</label><input type="text" id="userNickname" name="userNickname" maxlength="10"  >
                </div>
                <!-- 3. 필드(생년월일) -->
                <!-- 4. 필드(성별) -->
                <div class="field">
                    <label>성별</label>
                    <input type="radio" name="sex" id="sex" value="M">남자
                    <input type="radio" name="sex" id="sex" value="W">여자
                </div>
                <div class="field tel-number">
                    <div class="field">
                        <label>휴대전화</label> 
                        <select>
                            <option value="">대한민국 +82</option>
                        </select>
                    </div>				
                    <div class="field">
                        <label></label>    <input type="text" placeholder="전화번호 입력" id="phoneNumber" name="phoneNumber"> 
                        <input type="button" value="인증" id="phoneVerificationBtn">
                    </div>
                    <div id="identity">
                        <label></label><input type="text" placeholder="인증번호를 입력하세요" id="identityVerification" name="identityVerification">  <input type="button" id="verifyCodeBtn" name="verifyCodeBtn" value="인증확인">
                    </div>
                </div>
                <!-- 6. 가입하기 버튼 -->
                <button id="joinBtn" name="joinBtn">Sign In</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-right">
                </div>
            </div>
        </div>
    </div>
</body>
</html>
