<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세 페이지</title>

<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="/SoolWhale/resources/css/funding/fundingDetail.css">


<script src="https://kit.fontawesome.com/312ff11b0d.js"
	crossorigin="anonymous"></script>


<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/common/header.js"></script>
<script type="text/javascript">
	function goBack() {
		window.history.back();
		}
	</script>
<style type="text/css">
	#goBackButton {
    position: fixed;
    top: 20px;
    left: 20px;
    padding: 10px 20px;
    background-color: #007BFF;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    z-index: 1000;
}

#goBackButton:hover {
    background-color: #0056b3;
}
</style>

<script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
</head>
<body>
<button id="goBackButton" onclick="goBack()">돌아가기</button>
	<div id="wrap">
		<div data-include1="header" id="header"></div>
		<c:set var="day" value="${fn:substring(payment.endDate, 8, 10)}" />
		<c:set var="year" value="${fn:substring(projectDetail.endDate, 0, 4)}" />
		<c:set var="month"
			value="${fn:substring(projectDetail.endDate, 6, 8)}" />
		<c:choose>
			<c:when test="${day <= 10}">
				<c:set var="period" value="초" />
			</c:when>
			<c:when test="${day <= 20}">
				<c:set var="period" value="중순" />
			</c:when>
			<c:otherwise>
				<c:set var="period" value="말" />
			</c:otherwise>
		</c:choose>


		<div id="wrap_main">
			<div class="detail">
				<div class="wrap_center_detail">
					<div class="wrap_center">
						<!-- 첫 번째 섹션 -->
						<div class="product-detail-row">
							<div class="product-slider">
								<!-- Slide 1 -->
								<div class="product-slide">
									<!-- 이미지 -->
									<img
										src="/home/tomcat/file/project/${projectDetail.firstImgFilename}"
										alt="">
								</div>
							</div>
							<div class="product-details">
								<div class="product-info">
									<div class="subject">${projectDetail.title }</div>
									${day }
									<ul class="content">
										<li>${projectDetail.projectDesc }</li>
									</ul>
								</div>
								<div class="project-progress"></div>
								<ul class="content">
									<li>목표금액 :<fmt:formatNumber
											value="${projectDetail.targetAmount}" type="number"
											pattern="#,###" />원
									</li>

									<li>펀딩 기간 :${projectDetail.startDate } ~
										${projectDetail.endDate} &nbsp;
									</li>
								</ul>
								<div class="people">0명 후원</div>
								<span><span class="price">0</span>원
									달성</span>
							</div>
						</div>

						<!-- 두 번째 섹션 -->
						<div class="product-detail-row">
							<!-- 이미지와 설명을 하나의 컨테이너로 묶기 -->

							<c:forEach var="image" items="${imageListProject}">

								<img
									src="/home/tomcat/file/multiple/${image.imgFilename}"
									alt="">
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="reward-selection">
					<div class="creator-profile">
						<div class="profile-container">
							<div class="profile-image">
								<img
									src="/home/tomcat/file/project/${projectDetail.firstImgFilename}"
									alt="">
								<h2>${projectDetail.makerName }</h2>
							</div>
							${projectDetail.makerDesc }
						</div>
						<br>
						<div class="reward-options">
							<c:choose>
								<c:when test="${not empty rewardDetail}">
									<!-- rewardList가 비어 있지 않으면 이 블록 실행 -->
									<c:forEach var="reward" items="${rewardDetail}"
										varStatus="status">
										<div class="reward-option" data-reward="${reward.reward}">
											<!-- rewardList의 각 요소에 대해 반복 작업 -->
											<div class="reward_item_price">
												<label class="purchase_location"> <fmt:formatNumber
														value="${reward.amount}" pattern="###,###,###,###" /> 원
													<div class="reward_item_title">${reward.rewardName }</div>
													<div class="reward_item_description">
														${reward.rewardDesc }</div>
													<div class="reward_delivery">
														<br /> <span> <i class="fa-solid fa-bus-simple"></i>
															배송비 <c:choose>
																<c:when test="${reward.deliveryCharge == 'Y'}">
																	3,000원
																</c:when>
																<c:otherwise>무료</c:otherwise>
															</c:choose>
														</span>
														<div>2023년 09월 중순 리워드 제공 예정</div>
													</div>
												</label>
											</div>

											<br />

										</div>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
						<div class="reward-details" id="selectedRewardDetails">
							<h2>선택한 리워드 상세정보</h2>
							<h3 id="selectedRewardTitle"></h3>
							<p id="selectedRewardPrice"></p>
						</div>
						<div class="likeempty" data-id="product1">
							<i class="far fa-heart"></i> <i class="fas fa-heart"></i>
						</div>
						<button class="purchase-button">구매하기</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>