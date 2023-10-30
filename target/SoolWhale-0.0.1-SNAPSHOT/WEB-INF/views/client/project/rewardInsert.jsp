\<%@ page language="java" contentType="text/html; charset=UTF-8"
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
		<link rel="stylesheet" href="/SoolWhale/resources/css/project/rewardInsert.css">
		
		<script type="text/javascript" src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
		<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
		<script src="/SoolWhale/resources/js/project/rewardInsert.js"></script>
		<script src="/SoolWhale/resources/js/common/common.js"></script>
		
		<title>Insert title here</title>
		<script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
	</head>
	<body>
		<div class="reward_insert_page">
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
        <div class="reward_insert">
        	<div class="reward_view" id="reward_view">
        	</div>
        	<div class="reward_list" id="reward_list">
        		<c:choose>
						<c:when test="${not empty rewardList}">
							<c:forEach var="reward" items="${rewardList}" varStatus="status">
								<c:if test="${not empty reward}">
									<div class='wrap_reward_list'>
										<div>리워드 이름: ${reward.rewardName}</div>
										<div>리워드 소개: ${reward.rewardDesc}</div>
										<div>리워드 금액: ${reward.amount}</div>
										<div>배송비 유무: ${reward.deliveryCharge}</div>
										<button class='delete_reward_btn' data-reward-id="${reward.reward}">삭제</button>
									</div>
								</c:if>
							</c:forEach>
						</c:when>
					</c:choose>
        	</div>
            <form id="reward_insert_form">
            	<input type="hidden" id="projectNum" name="projectNum" value="${rewardInsert.projectNum}">
                <div class="reward_name">
                    <div class="reward_name_guide">
                        <h3>1️⃣리워드 이름</h3>
                            <p>전통주를 대표할 이름을 입력해주세요.</p>
                    </div>
                    <div class="reward_name_form">
                        <input type="text" id="rewardName" name="rewardName" class="reward_name_input" maxlength="20" placeholder="20자가 최대입니다.">
                    </div>
                </div>
                <div class="reward_introduce">
                    <div class="reward_introduce_guide">
                        <h3>2️⃣리워드 소개</h3>
                            <p>전통주의 특징을 알 수 있도록 소개해주세요.</p>
                    </div>
                    <div class="reward_introduce_form">
                        <textarea class="reward_introduce_input" name="rewardDesc" id="rewardDesc" maxlength="200"></textarea>
                    </div>
                </div>
                <div class="delivery_fee">
                    <div class="delivery_fee_guide">
                        <h3>3️⃣배송비 여부</h3>
                            <p>배송비 유무를 선택해주세요.</p>
                    </div>
                    <div class="delivery_fee_form" id="delivery_fee_form">
                        <input type="radio" name="deliveryCharge" id="deliveryChargeY" value="Y" checked>배송비 유료
                        <input type="radio" name="deliveryCharge" id="deliveryChargeN" value="N" >배송비 무료
                    </div>
                </div>
                <div class="reward_price">
                    <div class="reward_price_guide">
                        <h3>4️⃣리워드 금액</h3>
                            <p>전통주의 금액을 입력해주세요.</p>
                    </div>
                    <div class="reward_price_form">
                        <input type="text" id="amount" name="amount" placeholder="금액을 입력해주세요" class="reward_price_input" maxlength="9">
                    </div>
                </div>
                <button type="button" id="reward_insert_btn">저장</button>
            </form>
        </div>
        <div class="go_page">
            <button type="button" id="prev_funding_plan_btn">이전</button>
            <button type="button" id="project_complete_btn">작성 완료</button>
        </div>
    </div>
	</body>
</html>