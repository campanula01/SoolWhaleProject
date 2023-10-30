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
		
		<link rel="shortcut icon" href="/SoolWhale/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/SoolWhale/resources/image/icon.png"/>
		
		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
		<link rel="stylesheet" href="/SoolWhale/resources/css/project/fundingPlan.css">
		
		<script type="text/javascript" src="/resources/js/common/jquery-3.7.0.min.js"></script>
		<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
		<script src="/SoolWhale/resources/js/project/fundingPlan.js"></script>
		<script src="/SoolWhale/resources/js/common/common.js"></script>
		
		<title>Insert title here</title>
		<script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
	</head>
	<body>
		<div class="funding_plan_page">
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
        <div class="funding_plan">
            <form id="funding_plan_form">
            	<input type="hidden" id="projectNum" name="projectNum" value="${fundingPlan.projectNum}">
                <div class="funding_target_amount">
                    <div class="funding_target_amount_guide">
                        <h3>1️⃣목표 금액</h3>
                        <p>프로젝트를 완수하기 위해 필요한 금액을 설정해주세요.</p>
                        <div class="funding_target_amount_guide_sub">
                            <p>종료일까지 목표금액을 달성하지 못하면 후원자 결제가 진행되지 않습니다.</p>
                            <p>후원 취소 및 결제 누락을 대비해 10% 이상 초과 달성을 목표로 해주세요.</p>
                            <p>제작비, 선물 배송비, 인건비, 예비 비용 등을 함께 고려해주세요. </p>
                        </div>
                    </div>
                    <div class="funding_target_amount_form">
                        <h4>목표 금액💵</h4>
                        <input type="text" id="targetAmount" name="targetAmount" placeholder="금액을 입력해주세요" class="funding_target_amount_input" value="${fundingPlan.targetAmount}">
                        <div class="funding_amount_view">
                            <div>목표 금액 달성 시 예상 수령액 : <span class="funding_real_amount"></span>원
                            </div>
                            <div>총 수수료 : <span class="funding_payment_fee"></span>원
                            </div>
                        </div>
                    </div>
                </div>
                <div class="funding_schedule">
                    <div class="funding_schedule_guide">
                        <h3>2️⃣펀딩 일정</h3>
                            <p>설정한 일시가 되면 펀딩이 시작됩니다. 펀딩 시작 전까지 날짜를 변경할 수 있습니다.</p>
                    </div>
                    <div class="funding_schedule_form">
                        <div class="funding_start_date_form">
                            <h4>시작 날짜📅</h4>
                            <input type="date" id="startDate" name="startDate" class="funding_start_date" value="${fundingPlan.startDate}">
                        </div><br/>
                        <div class="funding_end_date_form">
                            <h4>종료 날짜📅</h4>
                            <input type="date" id="endDate" name="endDate" class="funding_end_date" value="${fundingPlan.endDate}">
                        </div>
                        <div class="funding_period_form">
                            <br/><h5>펀딩 기간</h5>
                            <span class="funding_period"></span>
                        </div>
                    </div>
                </div>
            </form>
            <div class="go_page">
                <button type="button" id="prev_project_info_btn">이전</button>
                <button type="button" id="next_reward_insert_btn">저장 후 다음</button>
            </div>
        </div>
    </div>
	</body>
</html>