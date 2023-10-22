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
		
	    <script src="/resources/js/common/jquery-3.7.0.min.js"></script>
  		<script src="/resources/js/common/jquery-1.12.4.min.js"></script>
  		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<!-- Add the slick-theme.css if you want default styling -->
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  		<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  		
  		<link rel="stylesheet" href="/resources/css/member/questionInsert.css">
  	
  		<link rel="stylesheet" href="/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/resources/css/common/common.css">
  		<link rel="stylesheet" href="/resources/css/common/header.css">
  		<link rel="stylesheet" href="/resources/css/common/pop.css">
  		
  		<script src="/resources/js/member/questionInsert.js"></script>
  		<script src="/resources/js/common/common.js"></script>
  		<script src="/resources/js/common/pop.js"></script>
  		<script src="/resources/js/common/sidebutton.js"></script>
		<script type="text/javascript">
 		$(function(){
 			
 				$("#q_sub_btn").click(function(){ // 수정
 				
 					$("#inqu_up_data").attr({
 						"method":"get",
 						"action":"/member/questionUpdateform"
 					});
 					$("#inqu_up_data").submit();
 					
 				});
 			
 		
 			$("#q_delete_btn").click(function(){
 				if(confirm("정말로 삭제하시겟습니까?")){
 					$("#inqu_data").attr({
 						"method":"get",
 						"action":"/member/questionDelete"
 					});
 					
 					$("#inqu_data").submit();
 				} 				
 			});
 			
 			
 			$("#q_can_btn").click(function(){
 				console.log("문의 내역 페이지 호출")
 				location.href="/member/questionList"
 			})
 		
 		});
 	
 		
 		</script>
 
 
 
</head>
<body>
<div id="wrap">
      <div data-include1="header" id="header"></div>
      <div class="wrap_center wrap_myinfo">
        <aside class="main_aside" id="wrap_aside">
            <div class="user_img"></div>
                <p class="user_id" id="user_id"><a>내 정보 보기&gt;</a></p>

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
                <span class="my_que que_box" id="my_que"><a>내 문의 내역</a></span>
                <span class="try_que que_box" id="try_que"><a>문의 하기</a></span>
            </div>
				<form name="inqu_data" id="inqu_data" method="get">
					<input type="hidden" name="inquiryNum" value="${inquiry.inquiryNum}" />
	
				</form>
				<form name="inqu_up_data" id="inqu_up_data" method="get">
					<input type="hidden" name="inquiryNum" value="${inquiry.inquiryNum}" />
					<input type="hidden" name="cat" value="${inquiry.cat}" />
					<input type="hidden" name="userType" value="${inquiry.userType}" />
					<input type="hidden" name="inquiryQ" value="${inquiry.inquiryQ}" />
					<input type="hidden" name="inquiryTitle" value=" ${inquiry.inquiryTitle}" />
				</form>

           <h1 class="que_try">문의 하기</h1>
           <form name="que_try_a" id="que_try_a" class="que_try_a">
                <ul class="que_try_ul">
                    <li class="q_li">
                        <label for="name">아이디</label>
                        <span  id="name">
                       			${user.id} 
                        </span>
                    </li>
                    <li  class="q_li">
                        <label for="cat">카테고리</label>
                        <span>${inquiry.cat}</span>
                    </li>
                       <li  class="q_li">
                        <label for="userType">사용자선택</label>
                        <span>${inquiry.userType}</span>
                    </li>
                    <li  class="q_li">
                        <label for="inquiryTitle">제목</label>
                        <span  id="inquiryTitle" class="q_sub inquiryTitle"> ${inquiry.inquiryTitle}</span>
                   
                    </li>
                    <li class="q_textarea">
                        <label for="inquiryQ" class="q_textarea_l">문의내용</label>
                        <span id="inquiryQ" class="q_text inquiryQ"  >${inquiry.inquiryQ}</span>
                    </li>
                 
                </ul>

                <div class="btn_hap">
                    <button type="button" name="q_sub_btn" id="q_sub_btn" class="q_sub_btn qb" >수정하기</button>
                    <button type="button" name="q_delete_btn" id="q_delete_btn" class="q_delete_btn">삭제</button>
                    <button type="button" name="q_can_btn" id="q_can_btn" class="q_can_btn qb" >취소</button>
                	<span id="msg"></span>
                </div>
                

           </form>
        </section>



    </div>
</div>

    

</body>
</html>