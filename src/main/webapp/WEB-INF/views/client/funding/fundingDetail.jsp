
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 상세 페이지</title>
    

   <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
  <script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  <link rel="stylesheet" href="/SoolWhale/resources/css/funding/fundingDetail.css">
  
  <script src="/SoolWhale/resources/js/funding/fundingDetail.js"></script>

    <script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
    
    
    <link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
    <link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
    <script src="/SoolWhale/resources/js/common/common.js"></script>
    <script src="/SoolWhale/resources/js/common/header.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
    var projectNum1 = "${projectDetail.projectNum}";
    var projectTitle1 = "${projectDetail.title}";
    var projectImg1 = "http://13.124.185.70:8080//home/tomcat/file/project/"+encodeURIComponent("${projectDetail.firstImgFilename}");
    var projectDesc1 = "${projectDetail.projectDesc}";

    console.log("http://13.124.185.70:8080/home/tomcat/file/project/"+encodeURIComponent("${projectDetail.firstImgFilename}"));
    Kakao.init('69d8c5c31722f274d01b6a59f77df9cc'); // 초기화

    function sendLink() { // 카카오톡 공유하기
    	
        Kakao.Link.sendDefault({
            objectType: "feed",
            content: {
                title: projectTitle1,
                description: projectDesc1,
                imageUrl: projectImg1,
                link: {
                    mobileWebUrl: 'https://soolwhale.store/SoolWhale/project/fundingDetailView?projectNum=' + projectNum1,
                    webUrl: 'https://soolwhale.store/SoolWhale/project/fundingDetailView?projectNum=' + projectNum1
                }
            },
        });
    }

    </script>
    

    <script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
</head>
<body>
<input type="hidden" id="projectNum" value="${projectDetail.projectNum }" />
    <div id="wrap">
        <div data-include1="header" id="header"></div>
            <c:set var="day" value="${fn:substring(payment.endDate, 8, 10)}" />
            <c:set var="year" value="${fn:substring(projectDetail.endDate, 0, 4)}" />
			<c:set var="month" value="${fn:substring(projectDetail.endDate, 6, 8)}" />
				<c:choose>
    				<c:when test="${day <= 10}">
        				<c:set var="period" value="초"/>
    				</c:when>
    				<c:when test="${day <= 20}">
        				<c:set var="period" value="중순"/>
    				</c:when>
    				<c:otherwise>
        				<c:set var="period" value="말"/>
    				</c:otherwise>
				</c:choose>
			<form id="detailData">
        		<input type="hidden" name="projectNum" id="projectNum" value="${projectDetail.projectNum }">
			</form>
		<!-- 연도와 월 값을 가진 input hidden 요소 -->
		<input type="hidden" id="yearInput" value="${year}">
		<input type="hidden" id="monthInput" value="${month}">
		<input type="hidden" id="dayInput" value="${day}">
		<input type="hidden" id="endDate" value="${projectDetail.endDate}">
		
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
						 <img src="/home/tomcat/file/project/${projectDetail.firstImgFilename}" alt="">
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
                    <div class="project-progress">
                      
                    </div>
                    <ul class="content">
                        <li>목표금액 :<span id="targetAmount"> <fmt:formatNumber value="${projectDetail.targetAmount}" type="number" pattern="#,###" /></span>원</li>
                        
                        <li>펀딩 기간 :${projectDetail.startDate } ~ ${projectDetail.endDate} &nbsp;<span id="remainDate">${projectDetail.remainDate} 일 남음</span></li>
                        <li>결제 예정일 :<span id="payDate"></span></li>
                        <li>리워드 발송 예정일 : <span  class="deliveryDate"></span> <span class="periodPlace"></span> </li>
                        <li>리워드 발송 지연 : <span id="deliveryDelayDate"></span><span id="DateDay"></span></li>

                        
                      
                    </ul>
                    



                    <div class="people">${projectDetailCount.paymentCount }명 후원</div>
                    <!-- 가격 -->
                    <span><span class="price">${projectDetailCount.totalAmount }</span>원 달성 <span id="percent"></span></span>
                    <div>
                    	<progress id="progress" value="${projectDetailCount.totalAmount }" max="${projectDetail.targetAmount}"></progress>
                    </div>
                </div>
            </div>

            <!-- 두 번째 섹션 -->
            <div class="product-detail-row">
                <!-- 이미지와 설명을 하나의 컨테이너로 묶기 -->
                
      				<c:forEach var="image" items="${imageListProject}">
            			
               <img src="/home/tomcat/file/multiple/${image.imgFilename}" alt="">
                
         
        			</c:forEach>
            
            </div>
        </div>
    </div>


<div class="reward-selection">
    <div class="creator-profile">
        <div class="profile-container">
            <div class="profile-image">
                <img src="/home/tomcat/file/project/${projectDetail.firstImgFilename}" alt="">
            <h2>${projectDetail.makerName }</h2>
        </div>

    </div>
            ${projectDetail.makerDesc }
    <br>
        <br>
    <div class="reward-options">

        
        
        
        
        
        
        
        
       
        
        
      <c:choose>
    	<c:when test="${not empty rewardDetail}">
        	<!-- rewardList가 비어 있지 않으면 이 블록 실행 -->
        	<c:forEach var="reward" items="${rewardDetail}" varStatus="status">
        	 <div class="reward-option" data-reward="${reward.reward}">
            	<!-- rewardList의 각 요소에 대해 반복 작업 -->
            	<div class="reward_item_price">
                	<label class="purchase_location">
                		
                    	<fmt:formatNumber value="${reward.amount}" pattern="###,###,###,###" /> 원
                    		<div class="reward_item_title">${reward.rewardName }</div>
                    		<div class="reward_item_description">
                    			${reward.rewardDesc }
                    		</div>
                    		<div class="reward_delivery">
                    			<br />
                    			<span>
                    				<i class="fa-solid fa-bus-simple"></i> 배송비 
                    				<c:choose>
                            			<c:when test="${reward.deliveryCharge == 'Y'}">
                               				<!-- deliveryCharge가 'Y'인 경우 -->
                               				3,000원
                            			</c:when>
                           				<c:otherwise>
                               				<!-- deliveryCharge가 'N'인 경우 -->
                               				무료
                           				</c:otherwise>
                        			</c:choose>
                    			</span>
                    			<div>배송 예정일 : <span  class="deliveryDate"></span> <span class="periodPlace"></span></div> 
                    		</div>
                	</label>
            	</div>
            	
            	<!-- 각 보상 항목에 대한 내용 -->
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
        <div class="container1">
    <div class="likeempty" data-id="product1">
        <i class="far fa-heart"></i>
        <i class="fas fa-heart"></i>
    </div>

    <div class="share">
  		 <a href="javascript:sendLink()"><img id="kakao" src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" /></a>
	</div>
</div>
    <button class="purchase-button">구매하기</button>
</div>
</div>
</div>
</div>
</body>
</html>