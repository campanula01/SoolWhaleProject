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
		
		<title>내 정보 보기 MAIN</title>
		
	    <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
  		<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/member/myInfoMain.css">
  		<script src="/SoolWhale/resources/js/member/myInfoMain.js"></script>
<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		
  		<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
  	
<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/common/pop.js"></script>

 <script type="text/javascript">
 		$(function(){
 			
 		})
 	
 		</script>
 
 
</head>
<body>

    <div id="wrap">
      <div data-include1="header" id="header"></div>
      <div class="wrap_center wrap_myinfo">
        <aside class="main_aside" id="wrap_aside">
            <div class="user_img"></div>
                <p class="user_id" id="user_id"><a>내 정보 보기 &nbsp; &nbsp; &gt;</a></p>

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
                    <li class="maker_li1 li_style" id="maker_li1"><a href="/SoolWhale/project/projectList">내 프로젝트</a></li>
                    <li class="maker_li2 li_style" id="maker_li2"><a href="/SoolWhale/project/projectSellingList">판매현황</a></li>
                </ul>
            </div>

        </aside>
        <section class="main_section">
            <div class="etc_info">
             <span class="point_info">
                <a href="/SoolWhale/member/pwConfirm">
                    <i class="fa-brands fa-product-hunt">  포인트</i>
                    <span class="point_p"> ${pointSum.pointSum} P</span>
                </a>
             </span>
             <span class="maker_info">
                
                <span class="funding_info maker_info_span">
                    <a href="/SoolWhale/supporter/orderList" class="maker_info_a">
                        <span class="maker_info_span1">펀딩 오더</span>
                        <span class="maker_info_span2">0</span>
                    </a>
                </span>
                <span class="pro_info maker_info_span">
                    <a href="/SoolWhale/project/projectList" class="maker_info_a">
                        <span class="maker_info_span1">내 프로젝트</span>
                        <span class="maker_info_span2">0</span>
                    </a>
                </span>
             </span>
            </div>
            <div class="soolLike_wrap">
                <h3 class="soolLike_text"> 관심 프로젝트 <a id="likeAll" class="likeAll">더보기 &gt;</a></h3>

                <div class="flex_wrap"> 
                   

					<c:choose>
						<c:when test="${not empty likeAllList}">
							<c:forEach var="like" items="${likeAllList}" varStatus="status">

                   
                    <div class="slider">
                      <a href="#">
                        <div class="slider_div">
                        <!-- <div class="likeempty">
                          <i class="fa-regular fa-heart" ></i>
                          <i class="fa-solid fa-heart"></i>
                        </div> -->
                        <img src="/SoolWhale/resources/img/common/sample_1.jpg" alt="" class="simg">
                        <div class="subject">${like.project.title}</div>
                        <p class="gap"></p>
                        <div class="price">50,000원</div>
                        <div class="hr"></div>
                        
                        <ul class="tage">
                          <li>#전통주 소물리에PICK</li>
                          <li>#전통주 입문자 용</li>
                        </ul>
                        
                        </div>
                      </a>
                    </div>
                      
                     			</c:forEach>
						</c:when>
						<c:otherwise>
							<div>
								<h2>관심 프로젝트를 등록해 보세요.</h2>
							</div>
						</c:otherwise>
					</c:choose>
                      
                   
           
                    
                </div>
            </div>
        </section>



    </div>
</div>

</body>
</html>