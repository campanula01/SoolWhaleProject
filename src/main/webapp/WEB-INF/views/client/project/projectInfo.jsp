<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/>
		
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		
		<link rel="stylesheet" href="/resources/css/common/common.css">
		<link rel="stylesheet" href="/resources/css/project/projectInfo.css">
		
		<script type="text/javascript" src="/resources/js/common/jquery-3.7.0.min.js"></script>
		<script src="/resources/js/common/jquery-1.12.4.min.js"></script>
		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
		<script src="/resources/js/project/projectInfo.js"></script>
		<script src="/resources/js/common/common.js"></script>
		
		<title>Insert title here</title>
		<script src="/resources/js/common/delayPayment.js"></script>
	</head>
	<body>
		<div class="project_info_page">
        <div class="maker_info_header">
            <button type="button" class="prev_page_btn" id="exit_button">
            	<i class="fa-solid fa-arrow-left fa-2xl" style="color: #808080;"></i>
            </button>
        </div>
        <div class="maker_info_container">
            <div class="info_title">프로젝트 등록</div>
            <div class="maker_info_status">
                <button type="button" class="maker_info_btn">기본정보</button>
                <button type="button" class="project_info_btn">창작자 정보</button>
                <button type="button" class="funding_plan_btn">펀딩 계획</button>
                <button type="button" class="reward_insert_btn">리워드 설계</button>
            </div>
        </div>
        <div class="project_info">
            <form id="project_info_form">
            <input type="hidden" id="projectNum" name="projectNum" value="${projectInfo.projectNum}">
            <input type="hidden" name="profilImgFilename" value="${projectInfo.profilImgFilename}">
                <div class="maker_name">
                    <div class="maker_name_guide">
                        <h3>1️⃣메이커 이름</h3>
                            <p>메이커 개인이나 팀을 대표하는 이름을 작성해주세요.</p>
                    </div>
                    <div class="maker_name_form">
                        <h3>이름</h3>
                        <input type="text" id="makerName" name="makerName" class="maker_name_input" maxlength="20" value="${projectInfo.makerName}">
                    </div>
                </div>
                <div class="maker_image">
                    <div class="maker_image_guide">
                        <h3>2️⃣프로필 이미지</h3>
                            <p>메이커 개인이나 팀의 사진을 올려주세요.</p>
                    </div>
                    <div class="maker_image_form">
                        <h3>이미지 업로드</h3>
                        <input type="file" id="profilImg" name="profilImg" accept="image/*">
                    </div>
                </div>
                <div class="maker_introduce">
                    <div class="maker_introduce_guide">
                        <h3>3️⃣메이커 소개</h3>
                            <p>메이커 개인이나 팀의 간단한 소개를 해주세요.</p>
                    </div>
                    <div class="maker_introduce_form">
                        <h3>소개</h3>
                        <textarea class="maker_introduce_input" name="makerDesc" id="makerDesc" maxlength="200">${projectInfo.makerDesc}</textarea>
                    </div>
                </div>
            </form>
            <div class="go_page">
                <button type="button" id="prev_maker_info_btn">이전</button>
                <button type="button" id="next_funding_plan_btn">저장 후 다음</button>
            </div>
        </div>
    </div>
	</body>
</html>