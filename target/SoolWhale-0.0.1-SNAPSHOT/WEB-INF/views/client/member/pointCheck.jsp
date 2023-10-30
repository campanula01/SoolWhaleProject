<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page trimDirectiveWhitespaces="true" %>
    <%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<title>내 정보 보기</title>
		
	    <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
  		<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/member/pointCheck.css">
  	
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		
  		<script src="/SoolWhale/resources/js/member/pointCheck.js"></script>
  		<script src="/SoolWhale/resources/js/common/common.js"></script>
  		<script src="/SoolWhale/resources/js/common/pop.js"></script>
		<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
 		
<script type="text/javascript">
 		$(function(){
 			
 		});
 	
 		</script>
 
 
</head>
<body>

     <div id="wrap">
      <div data-include1="header" id="header"></div>
      <div class="wrap_center wrap_myinfo">
        <aside class="main_aside" id="wrap_aside">
            <div class="user_img"></div>
                  <p class="user_id" id="user_id"><a>사용자 아이디 &gt;</a></p>

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
        
            <div class="my_btn_list">
                <span class="basic_info info_box" id="basic_info"><a>기본정보</a></span>
                <span class="point_info info_box" id="point_info"><a>포인트 내역</a></span>
            </div>

            <h1 class="info_text">술고래 포인트</h1>

            <h3 class="point_text">내 술고래 포인트 <span class="point_sum">${pointSum.pointSum} </span></h3>

            <div class="point_back">

            <table class="point_table">
                <thead>
                    <tr>
                        <th>적립일</th>
                        <th>적립 내용</th>
                        <th>적립 포인트</th>
                        <th>소멸일시</th>
                    </tr>
                     </thead>
                <tbody>
                      <c:choose>
                                <c:when test="${not empty pointcheck}">
                            	 <c:forEach var="point" items="${pointcheck}">
    							<c:if test="${point.payment.addPoint != 0}">
    							<tr class="text-center" data-num="${point.payment.paymentDate}">
        						<td class="text-left">${point.payment.paymentDate}</td>
        						<td>${point.pointDesc}</td>
      							  <td>${point.payment.addPoint}</td>
       							 <td>${point.pointDelete}</td>
   							 </tr>
   							 </c:if>
								</c:forEach>
                                </c:when>
                                <c:otherwise>
                                	<td colspan="4" >포인트 내역이 존재하지 않습니다.</td>
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