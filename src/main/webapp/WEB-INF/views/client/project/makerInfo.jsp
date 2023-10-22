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
		<link rel="stylesheet" href="/resources/css/project/makerInfo.css">
		
		<script type="text/javascript" src="/resources/js/common/jquery-3.7.0.min.js"></script>
		<script src="/resources/js/common/jquery-1.12.4.min.js"></script>
		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
		<script src="/resources/js/project/makerInfo.js"></script>
		<script src="/resources/js/common/common.js"></script>
		
		<title>Insert title here</title>
    <script src="/resources/js/common/delayPayment.js"></script>
	</head> 
	<body>
    	<div class="maker_info_page">
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
        <div class="maker_info">
            <form id="maker_info_form">
            	<input type="hidden" id="projectNum" name="projectNum" value="${makerInfo.projectNum}">
            	<input type="hidden" name="firstImgFilename" value="${makerInfo.firstImgFilename}">
                <div class="liquor_type">
                    <div class="liquor_type_guide">
                        <h3>1️⃣프로젝트 주종</h3>
                            <p>전통주의 주종을 선택하세요.</p>
                    </div>
                    <div class="liquor_type_form">
                        <h3>주종</h3>
                        <select name="liquorType" id="liquorType">
                            <option value="탁주">탁주</option>
                            <option value="증류주">증류주</option>
                            <option value="과실주">과실주</option>
                            <option value="약.청주">약.청주</option>
                        </select>
                    </div>
                </div>
                <div class="project_title">
                    <div class="project_title_guide">
                        <h3>2️⃣프로젝트 제목</h3>
                            <p>프로젝트의 주제, 특징이 드러나는 제목을 적어주세요.</p>
                    </div>
                    <div class="project_title_form">
                        <h3>제목</h3>
                        <textarea class="project_title_input" name="title" id="title" maxlength="30">${makerInfo.title}</textarea>
                    </div>
                </div>
                <div class="project_summary">
                    <div class="project_summary_guide">
                        <h3>3️⃣프로젝트 요약</h3>
                            <p>후원자들이 프로젝트를 빠르게 이해할 수 있도록 명확하고 간략하게 소개해주세요.</p>
                    </div>
                    <div class="project_summary_form">
                        <h3>요약</h3>
                        <textarea class="project_summary_input" name="projectDesc" id="projectDesc" maxlength="50">${makerInfo.projectDesc}</textarea>
                    </div>
                </div>
                <div class="project_image">
                    <div class="project_image_guide">
                        <h3>4️⃣프로젝트 대표이미지</h3>
                            <p>후원자들이 프로젝트의 내용을 쉽게 파악하게 하기위해 대표 이미지를 설정해주세요.</p>
                    </div>
                    <div class="project_image_form">
                        <h3>이미지</h3>
                        <input type="file" id="firstImg" name="firstImg" accept="image/*">
                    </div>
                </div>
                <div class="project_video">
                    <div class="project_video_guide">
                        <h3>5️⃣프로젝트 대표영상</h3>
                            <p>후원자들이 프로젝트의 내용을 쉽게 파악하게 하기위해 대표 영상을 설정해주세요.</p>
                    </div>
                    <div class="project_video_form">
                        <h3>동영상</h3>
                        <input type="file" id="firstVideoFile" name="firstVideoFile" accept="video/*">
                    </div>
                </div>
                <div class="project_detail_image">
                    <div class="project_detail_image_guide">
                        <h3>6️⃣프로젝트 상세이미지</h3>
                            <p>후원자들이 프로젝트의 내용을 상세히 파악하게 하기위해 상세 이미지를 설정해주세요.</p><br/>
                            <button type="button" id="addFile" class="btn">첨부파일추가</button>
                    </div>
                    <div class="project_detail_image_form">
                        <h3>상세이미지</h3>
                        <table class="table">
                        	<tr>
								<td></td>
								<td class="text-left"></td>
							</tr>
                        </table>
                    </div>
                </div>
            </form>
            <div class="go_page">
                <button type="button" id="next_project_info_btn">저장 후 다음</button>
            </div>
        </div>
    </div>
	</body>
</html>