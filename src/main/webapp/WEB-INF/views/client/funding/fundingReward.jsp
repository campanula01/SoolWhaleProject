<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>

<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Insert title here</title>

<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />

<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->

<script src="/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/resources/js/common/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/css/funding/fundingReward.css">
<script src="/resources/js/funding/fundingReward.js"></script>
<script src="https://kit.fontawesome.com/312ff11b0d.js"
	crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/common/common.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <script src="/resources/js/common/common.js"></script>
    <script src="/resources/js/common/header.js"></script>
    
    <script src="/resources/js/common/delayPayment.js"></script>
</head>
<body>
  <div id="wrap">

	 <c:set var="day" value="${fn:substring(payment.endDate, 8, 10)}" />
            <c:set var="year" value="${fn:substring(projectDetail.endDate, 0, 4)}" />
			<c:set var="month" value="${fn:substring(projectDetail.endDate, 6, 8)}" />
  	<!-- 선택한 리워드 정보를 저장할 hidden input 요소들 -->
  	
      <div data-include1="header" id="header"></div>

    <div class="wrap_center wrap_fundingPay">
      <div class="purchase_title">
      	<input type="hidden" id="projectNum" value="${projectDetail.projectNum }">
        	<!-- 첫 번째 요소의 title만 출력 -->
        		<div>${projectDetail.title}</div>

      </div>
      <div id="purchase_wrap">

        <div class="container">
          <div class="circle_container">
            <div class="circle_selected">
              <div class="word">리워드 선택</div>
            </div>
          </div>

          <div class="connector"></div>
          <div class="circle_container">
            <div class="circle">
              <div class="word">결제 하기</div>
            </div>
          </div>

          <div class="circle_container">
            <div class="circle">
              <div class="word">결제 완료</div>
            </div>
          </div>

        </div>
      </div>
      <div id="reward_content_box">
        <h4>리워드 선택</h4>


  	<!-- 다른 필요한 input 요소들 -->
       
<input type="hidden" id="selectedReward" value="${selectedReward }">

<input type="hidden" id="yearInput" value="${year}">
		<input type="hidden" id="monthInput" value="${month}">
		<input type="hidden" id="dayInput" value="${day}">
		<input type="hidden" id="endDate" value="${projectDetail.endDate}">
<form id="selectedRewardsForm">
   
	<c:choose>
    	<c:when test="${not empty rewardList}">
        	<!-- rewardList가 비어 있지 않으면 이 블록 실행 -->
        	<c:forEach var="reward" items="${rewardList}" varStatus="status">
            	<!-- rewardList의 각 요소에 대해 반복 작업 -->
            	<div class="reward_item_price">
                	<label>
                	
                	
                    	<input type="checkbox" class="show_content_checkbox product" data-target="content${status.index + 1}" name="checkReward" data-reward="${reward.reward}" >
                    	<fmt:formatNumber value="${reward.amount}" pattern="###,###,###,###" /> 원
                    		<div class="reward_item_title">${reward.rewardName } <span class="reward_item_max">최대 구매 가능 수량 500개</span></div>
                    		<div class="reward_item_description">
                    			${reward.rewardDesc }
                    		</div>
                    		<div class="reward_delivery">
                    			<br />
                    			<span>
                    				<i class="fa-solid fa-bus-simple"></i>배송비 
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
                    			<span class="reward_delivery_divide"> | </span>
                    			<span>배송 예정일 : <span  class="deliveryDate"></span> <span class="periodPlace"></span> 리워드 제공</span>
                    		</div>
                	</label>
            	</div>
            	
            	<!-- 각 보상 항목에 대한 내용 -->
            	<br />
            	<div class="price_details" id="content${status.index + 1}" price-per-unit=${reward.amount }>
            	<span class="close_button_content1" id="close_content${status.index + 1}" data-target="content${status.index + 1}">&times;</span>
                	<div class="content_reward" id="content_reward${status.index + 1}">${reward.rewardName }</div>
                    	

                	<br />
                	<div class="quantity_price_container">
                    	<div class="quantity_container">
                    	<input type="hidden" name="rewardNum" id="rewardNum" value="${reward.reward }" data-target="content${status.index + 1}">
                    	<input type="hidden" name="projectNum" id="projectNum" value="${reward.projectNum }" data-target="content${status.index + 1}">
                        	<button type="button" class="quantity_button_decrease">-</button>
                        	<input type="text" id="quantity${status.index + 1}" class="quantity_input" value="0" min="0" max="500">
                        	<button type="button" class="quantity_button_increase">+</button>
                    	</div>
                    	<p><span class="sum_price"> <span class="total_price"></span></span></p>
                    	<br />
                	</div>
            	</div>
        	</c:forEach>
    	</c:when>
	</c:choose>
	
	 <div id="additional">
        <h1>후원금 더하기(선택)</h1> <p> 후원금을 더하여 참여할 수 있습니다. 추가 후원금을 입력하시겠습니까?</p>
    		<input type="text" id="additional_donation" value="0">원
   	 </div>
	

    <div id="final_sum_price">
        		'${projectDetail.title}'
    	에 <span id="final_sum_price_detail"></span> 원을 참여합니다.
    </div>
 
   </form>
 
  <button type="button" id="open_modal_button">다음 단계로 > </button>

  </div>
  <div class="modal" id="modal">
    <div class="modal_content">
      <div class="check_box">
        <span class="close_button" id="close_modal_button">&times;</span>
        <div class="check_next_title">
          <h2>결제 예약 전 미리 체크해 보세요!&nbsp;&nbsp;<i class="fa-solid fa-check"></i></h2>
        </div>
        <br />
        <label>

          <span class="check_next_main_text">
            <input type="checkbox" class="check_next">
            프로젝트 끝나기 전까지 언제든 결제 예약을 취소할 수 있어요.
            <span class="check_icon">
              <i class="fa-solid fa-ban"></i>
            </span>
          </span>
        </label>
        <br />
        <div class="check_next_content">
          ・ 결제 예정일 : ${projectDetail.payDate } <br />
          ・ 취소 가능 기한: ~ ${projectDetail.endDate } <br />
          단, 프로젝트가 끝나면 바로 리워드 제작이 시작되기 때문에 결제를 취소할 수 없습니다.
        </div>

        <br />

        <label>

          <span class="check_next_main_text">
            <input type="checkbox" class="check_next">
            리워드에 문제가 있거나 배송일을 지키지 않으면 환불 받을 수 있어요.
            <span class="check_icon">
              <i class="fa-regular fa-credit-card"></i>
            </span>
            <br />
          </span>
        </label>
        <div class="check_next_content">
          <div class="toggle_button">환불 정책 확인</div>
          <div class="toggle_content">
            <p>프로젝트 스토리에서 소개한 내용과 실제 리워드가 다르거나 다른 제품・콘텐츠를 모방하는 지적재산권 침해와 같은 문제가 있을 때, 혹은 메이커가 약속한 배송일에 참여한 리워드를 받지 못했을
              때, 환불 신청할 수 있어요.

              환불 안내
              환불은 펀딩 참여 내역에서 신청할 수 있습니다.
              환불 신청 후 정책에 따라 확인 절차를 거쳐 진행되며, 참여한 결제 건을 취소하는 방식으로 진행됩니다.
              자세한 내용은 메이커 문의하기 또는 와디즈 고객센터 이용을 부탁드립니다.

              1) 리워드가 지연될 경우
              메이커가 리워드 발송 시작 예정일까지 리워드를 발송하지 않을 경우, 서포터는 환불 신청 할 수 있습니다.
              리워드 별 발송 시작 예정일은 다를 수 있으니, 펀딩 참여 내역에서 참여한 리워드의 발송 시작 예정일을 확인하세요.


              2) 리워드에 하자가 있을 경우
              서포터가 수령한 리워드가 아래 하자 기준에 해당할 경우, 배송 완료일로부터 14일 이내에 환불 신청 할 수 있습니다. 이때 메이커는 하자 판단을 위한 증빙자료, 리워드 반송을 서포터에게
              요청할 수 있습니다.

              리워드의 품질에 아래와 같은 하자가 발생한 경우
              예)

              공산품, 공예품 등
              제품 흠집, 휨, 백화현상 및 도장 불량, 악취 등 자극성 냄새, 좀 등의 벌레 발생, 균열, 뒤틀림 또는 변색, 녹, 누수, 오염
              신발, 의류, 패션 잡화 등
              봉제 불량, 접착 불량, 염색 불량, 원단 불량(제직, 세탁 후 변색, 탈색, 수축 등), 부자재 불량(단추, 지퍼, 천조각, 실오라기 등), 치수(사이즈)의 부정확
              식품, 의약품, 의약외품, 생활위생용품, 화장품 등
              이물혼입, 함량 부적합, 변질, 부패, 성분이상
              그 외 품목
              소비자분쟁해결 기준을 따름
              정상적인 사용상태에서 리워드의 기능/성능상 오작동 또는 미작동 되는 경우
              리워드로 인해 아래와 같은 피해를 입은 경우
              부작용으로 인해 신체상의 피해가 발생한 경우
              용기 불량, 파손 등으로 인한 상해, 피해사고를 입은 경우
              자세한 하자 환불 기준은 환불 정책을 확인하세요.
              단, 아래 어느 하나에 해당될 경우 환불 불가합니다.

              메이커가 프로젝트 페이지 내에 명시적으로 고지한 하자 불인정 사유에 해당하는 경우
              (예) 공장 제작 과정상 벌어짐 방지를 위해 봉제되어 제공되는 포켓은 하자 사유가 되지 않습니다.
              서포터의 귀책 사유로 리워드의 일부 혹은 전체가 분실/파손/고장/오염/훼손이 발생된 경우
              모니터 해상도의 차이로 인해 색상이나 이미지가 실제와 다른 경우
              공연, 디지털컨텐츠, 여행 패키지 상품, 무형 서비스 및 컨텐츠의 제공이 완료되었을 경우
              다음과 같은 경우 하자에 해당하지 않아 환불 불가합니다.


              3) 기타 주의 사항
              크라우드펀딩의 특성상 프로젝트 종료 후 서포터의 단순변심으로 인한 환불은 불가합니다.
              회사는 메이커와 상호 협의 하에 프로젝트를 취소할 수 있으며, 펀딩 종료 후 프로젝트가 취소될 경우에는 환불됩니다.
              하자가 있는 경우, 리워드 반송을 위한 배송비는 메이커가 부담하여야 하고 하자가 없는 경우에는 리워드 반송 및 재반송에 대한 배송비를 서포터에게 청구될 수 있습니다.
              ※ 더 자세한 사항은 환불 정책에서 확인하세요.
              사용 중 발생한 하자에 대한 A/S 정책
              예시)
              보증 기간: 리워드 수령일로부터 1년
              규정: 정상적인 상태에서 사용 중 발생한 제품 하자인 경우 1:1 교체
              A/S 불가 규정: 보증 기간 이내일지라도 사용자의 고의 또는 과실로 인하여 제품 수리 및 재생이 불가능한 경우
              접수 방법: 접수처를 통해 하자에 대한 정확한 소명 후 처리됩니다.
            </p>
          </div>
        </div>
        <br />

        <label>

          <span class="check_next_main_text">
            <input type="checkbox" class="check_next">
            단순 변심에 의한 환불은 신청할 수 없어요.
            <span class="check_icon">
              <i class="fa-solid fa-heart"></i>
            </span>
            <br />
          </span>
        </label>
        <div class="check_next_content">
          펀딩은 일반 쇼핑과 달리 리워드를 만드는 메이커에게 투자하고,<br />
          투자의 보상으로 제품이나 서비스를 받는 구조이기 때문에<br />
          전자상거래법상 통신 판매에 해당하지 않아요.<br />
          그래서 단순 변심을 이유로 한 환불은 신청할 수 없습니다.
        </div>

        <br />
        <button type="submit" id="check_nextpage">계속해서 진행하기</button>
 </div>
     
</div>
</div>
 
 
 
 
    
  </div>

</div>
</body>
</html>
