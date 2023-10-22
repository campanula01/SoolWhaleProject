<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page trimDirectiveWhitespaces="true" %>
    <%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<title>내 정보 보기</title>
		
	    <script src="/resources/js/common/jquery-3.7.0.min.js"></script>
  		<script src="/resources/js/common/jquery-1.12.4.min.js"></script>
  		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  		
  		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
  		
  		<link rel="stylesheet" href="/resources/css/supporter/orderList.css">
  	
  		<link rel="stylesheet" href="/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/resources/css/common/common.css">
  		<link rel="stylesheet" href="/resources/css/common/header.css">
  		<link rel="stylesheet" href="/resources/css/common/pop.css">
  		
  		<script src="/resources/js/supporter/orderList.js"></script>
  		<script src="/resources/js/common/common.js"></script>
  		<script src="/resources/js/common/pop.js"></script>
	<script src="/resources/js/common/sidebutton.js"></script>
 
 <script type="text/javascript">
 
 
 $(function(){
	 
 	
	 
	 
 
 
 
 });;; //마지막
 
 
 
 </script>
</head>
<body>

        <div id="wrap">
      <div data-include1="header" id="header"></div>
      <div class="wrap_center wrap_myinfo">
        <aside class="main_aside" id="wrap_aside">
            <div class="user_img"></div>
                <p class="user_id" id="user_id"><a>내 정보 보기 &gt;</a></p>

            <p class="question" id="question"><a>문의 내역</a></p>
            <div class="support_form">
                <p class="support_p smp"> 서포트</p>
                <ul class="support_ul">
                    <li class="support_li1 li_style" id="support_li1"><a>주문 내역</a></li>
                    <li class="support_li2 li_style" id="support_li2"><a>관심 프로젝트</a></li>
                </ul>
            </div>
           
            <div class="maker_form">
                <p class="maker_p smp">메이커</p>
                <ul class="maker_ul">
                    <li class="maker_li1 li_style" id="maker_li1"><a>내 프로젝트</a></li>
                    <li class="maker_li2 li_style" id="maker_li2"><a>판매현황</a></li>
                </ul>
            </div>

        </aside>
        <section class="main_section">
    
            <h1 class="order_text">최근 주문내역</h1>
           <div id="order_list" class="order_list">
                <table summary = "주문게시판" class="order list_table">
                    <thead class="list_table_h">
                        <tr>
                        <!--     <th data-value="inquiry_num" class="text_center order_no">No</th> -->
                            <th class="or_date">주문날짜</th>
                            <th class="or_info">상품정보</th>
                            <th class="or_deli">배송상태</th>
                            <th class="or_conf">확인/신청</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty paymentList}">
                                <c:forEach var="payment" items="${paymentList}" varStatus="status" >
                                    <tr class="text-center" data-num="${payment.merchantUid}" >
                                       
                                        <td class=" text-left">${payment.paymentDate}</td>
                                        <td class="name goDetail" data-order-num="${payment.merchantUid}">${payment.project.title} </td>
                                   
                                        <td class="text-left">
                                         <script type="text/javascript">
       										 var deliveryYN = "${payment.deliveryYN}";
      										var displayText = "";
        
       										 if (deliveryYN === "ORD_01") {
           										 displayText = "주문예약완료";
       										 } else if (deliveryYN === "ORD_02") {
           										 displayText = "결제완료";
       										 } else if (deliveryYN === "ORD_03") {
         							  			 displayText = "배송준비중";
       										 }  else if (deliveryYN === "ORD_02") {
           										 displayText = "배송중";
       										 } else if (deliveryYN === "ORD_03") {
         							  		 	displayText = "배송완료";
       										 }else {
          									  // 기타 상황에 대한 처리
          									  displayText = deliveryYN;
        									}
        
      										  document.write(displayText);
    									</script></td>
                                        <td class="text-center">
                                           <button class="receipt_btn" name="receipt_btn" id="receipt_btn">수취확인</button>
                                            <!-- if 수취확인이 눌려야 반품신청과 교환신청 불이 들어오는 쪽으로 .... -->
                                           <form class="cancel" >
                                           <input type="hidden" class="userNum" value="${payment.userNum}">
                                           <input type="hidden" class="projectNum" value="${payment.projectNum}">
                                           <input type="hidden" class="paymentAmount" value="${payment.payAmount}">
                                           <input type="hidden" class="paymentDate" value="${payment.paymentDate}">
                                           <input type="hidden" class="billingKey" value="${payment.billingKey}">
											<input type="hidden" class="merchantUid" value="${payment.merchantUid}">
											<input type="hidden" class="sts" value="${payment.project.sts }">

                                            <button class="reprise_btn" name="reprise_btn" class="reprise_btn" >환불신청</button>
                                           </form>
                                           <form id="detailForm_${payment.merchantUid}" name="detailForm" method="get">
											<input type="hidden" id="user_num" name="userNum" value="${payment.userNum}" />
           									<input type="hidden" class="billingKey" name="billingKey" value="${payment.billingKey}">
											<input type="hidden" class="merchantUid" name="merchantUid" value="${payment.merchantUid}">
											</form> 
                                           
                                           
                                           
                                            <button class="exchange_btn" name="exchange_btn" id="exchange_btn">교환신청</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                	<td colspan="4" >주문 하시겠습니까?</td>
                                </c:otherwise>
                       </c:choose> 
                    </tbody>
                </table>
           </div>

        </section>



    </div>
</div>

</body>
</html>