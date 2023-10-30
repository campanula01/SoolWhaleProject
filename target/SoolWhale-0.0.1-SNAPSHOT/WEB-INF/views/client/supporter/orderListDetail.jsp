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
		
		<title>내문의</title>
		
	    <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
  		<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/supporter/orderListDetail.css">
  	
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		
  			<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
  		<script src="/SoolWhale/resources/js/supporter/orderListDetail.js"></script>
  		<script src="/SoolWhale/resources/js/common/common.js"></script>
  		<script src="/SoolWhale/resources/js/common/pop.js"></script>
		
		<script type="text/javascript">
 	
 			
 	
 		</script>
 
 
 
</head>
<body>
 <div id="wrap">
 <%-- ${order_num } --%>
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
            <h1 class="orderListDetail_title">
                <i class="fa-solid fa-arrow-left"></i>  주문 상세 내역
            </h1>

            <div class="order_num">
                <span class="order_dn order_date"><span class="order_date_t order_dn_t">주문날자</span></span>
                <span class="order_dn order_number"><span class="order_number_t order_dn_t">주문번호</span> </span>
            </div>

            <table class="order_table">
                <thead class="order_thead">
                    <tr>
                        <th>상품정보</th>
                        <th>배송비</th>
                        <th>배송상태</th>
                    </tr>
                </thead>
                <tbody>
                
                
                	<c:choose>
               		<c:when test="${not empty detail}">
                		<c:forEach var="payment" items="${detail}"> 
                		
					<tr>
                        <td>
                            <span class="table_img">
                                <img />
                            </span>
                            <span class="table_pro">
                                <p class="text_wrap">${payment.project.title}</p>
                                <p>${payment.rewardr.rewardName}</p>
                                <p>${payment.rewardr.rewardDesc}</p>
                                
                            </span>
                        </td>
                        <td>
                           
                        </td>
                        <td>
                           
                        </td>
                    </tr>
          	 		</c:forEach>
					</c:when>
					<c:otherwise>
						<div>
							<h2>관심 프로젝트를 등록해 보세요.</h2>
						</div>
					</c:otherwise>
              	</c:choose>
                    
                </tbody>
            </table>

            	
            <h2 class="mid_title">주문정보</h2>
            <p class="mid_mid_title">주문자</p>
            <p>${choice.user.name}</p>
            <p class="mid_mid_title">연락처</p>
            <p></p>
            <p class="mid_mid_title">이메일</p>
            <p></p>

            <h2 class="mid_title">배송지 정보</h2>
            <p class="mid_mid_title">수령인</p>
            <p>이름불러오기</p>
            <p class="mid_mid_title">연락처</p>
            <p>연락처불러오기</p>
            <p class="mid_mid_title">배송정보</p>
            <p>배송지 정보를 불러와보자</p>
            <p class="mid_mid_title">배송메모</p>
            <p>배송시 메모 남길거 불러오기</p>

            <h2 class="mid_title">주문 금액 상세</h2>
            <p>
            <span>주문금액</span> <span></span><i class="fa-solid fa-minus"></i> <span>할인금액</span>
            <span>금액불러오기</span> <i class="fa-solid fa-equals"></i> <span>총 주문금액</span> <span>합친금액불러오기</span>
            </p>

            <p>
                <span>
                    <span><span class="mid_mid_title">상품금액</span> <span>금액불러올 장소</span></span>
                    <span><span class="mid_mid_title">배송비</span> <span>3,000원 불러오기</span></span>
                </span>
                <span>
                    <span><span class="mid_mid_title">포인트 </span><span>포인트 불러올 장소</span></span>
                </span>
                <span>
                    <ul>
                        <li>결제방법 불러오기</li>
                        <li>결제불러오기</li>
                        <li><button>영수증조회버튼만들기</button></li>
                        <li>예상 포인트 적립금</li>
                        <li>예상포인트 끌고오기</li>
                    </ul>
                </span>
            </p>

        </section>



    </div>
</div>

    

</body>
</html>