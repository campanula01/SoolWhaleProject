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
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
      
      <title>Insert title here</title>
      
      <link rel="shortcut icon" href="/SoolWhale/resources/image/icon.png" />
      <link rel="apple-touch-icon" href="/SoolWhale/resources/image/icon.png" />
      
      <!--[if lt IE 9]>
      <script src="/SoolWhale/resources/js/html5shiv.js"></script>
      <![endif]-->
      
        <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
  <script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  <script src="/SoolWhale/resources/js/common/paymentDelay.js"></script>
  <link rel="stylesheet" href="/SoolWhale/resources/css/funding/fundingPayComplete.css">
  <script src="/SoolWhale/resources/js/funding/fundingPayComplete.js"></script>

  <!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  
  <script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>

  <script type="text/javascript">
    $(function () {
      var includes1 = $('[data-include1="header"]');
      $.each(includes1, function () {
        $(this).load('../00_common/01_header.html');
      });

    });  
  </script>
      <link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
    <link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
    <script src="/SoolWhale/resources/js/common/common.js"></script>
    <script src="/SoolWhale/resources/js/common/header.js"></script>
    <script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
    
   </head>
   <body>
    <div id="wrap">
     <div data-include1="header" id="header"></div>
    <div class="wrap_center wrap_fundingPay">

      <div id="purchase_wrap">

        <div class="container">
          <div class="circle_container">
            <div class="circle">
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
            <div class="circle_selected">
              <div class="word">결제 완료</div>
            </div>
          </div>

        </div>
      </div>


<input type="hidden" name="paymentCount" class="paymentCount" value=" ${paymentComplete.paymentCount }">

    <div class="funding_complete_info">
       <div class="complete_title">
            <h2>펀딩 완료</h2>
            <img src="/SoolWhale/resources/img/funding/fundingPayComplete.gif" alt="펀딩 완료 gif">
         </div>
      <h3><span id="counter">0</span>번째 서포터 <span class="supporter_name">${userData.name}</span>님</h3>
      <h3>'${ paymentComplete.project.title}'  펀딩해 주셔서 감사합니다.</h3>
      <div class="funding_complete_content_all">
        <div class="funding_complete_content_title">
          결제 예정일: <fmt:formatDate value="${dueDate}" pattern="yyyy년 MM월 dd일"/>
        </div>
        <div class="funding_complete_content">
          프로젝트 성공 시에만 결제됩니다.
          
          


        </div>

        <div class="funding_complete_content_title">
          리워드 발송예정일: 
          <fmt:formatDate value="${dueDeliveryDate}" pattern="yyyy년 MM월 "/>
         <c:choose>
             <c:when test="${dayOfMonth <= 10}">
                 초
             </c:when>
             <c:when test="${10 < dayOfMonth && dayOfMonth <= 20}">

                 중순
             </c:when>
             <c:otherwise>
                 말
             </c:otherwise>
         </c:choose>
        </div>
        <div class="funding_complete_content">
          리워드 준비 중 예기치 못한 사정으로
          <div class="funding_complete_content_high">
            리워드 발송이 <fmt:formatDate value="${maxDelayDate}"  pattern="yyyy년 MM월 dd일"/>까지 지연
          </div>
          되거나 리워드 품질이 기대와 다를 수 있음을 알려드립니다.
        </div>
        
               
      </div>

      <div class="button-container">
        <button type="button" id="p_detail">주문 내역 보기</button>
        <button type="button" id="p_return_main">메인 화면으로 돌아가기</button>
      </div>

    </div>

    <div class="slider-wrap">
      <p>최신 리워드</p>
      <div class="slides">
        <c:forEach var="project" items="${recommendRewardList}" begin="0" end="5">
        <a href="/SoolWhale/project/fundingDetailView?projectNum=${project.projectNum}">
          <div class="slide">
             ${project.title }
              <img src="/home/tomcat/file/project/${project.firstImgFilename}" alt="Image for ${project.title}" onclick="redirectToAnotherPage(this)" data-project-num="${project.projectNum}"/>
          </div>
          </a>
      </c:forEach>
      </div>
     
    </div>


  </div>
  </div>

   </body>
</html>