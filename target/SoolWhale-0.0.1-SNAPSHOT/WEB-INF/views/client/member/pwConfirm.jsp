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
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/member/pwConfirm.css">
  	
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		<script src="/SoolWhale/resources/js/common/common.js"></script>
  		<script src="/SoolWhale/resources/js/common/pop.js"></script>
  		<script src="/SoolWhale/resources/js/member/pwConfirm.js"></script>
  		<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
  		<script type="text/javascript">
  		$(function(){
  		
  		
  			$("#re_pwd").bind("keydown",function(event){	
				if(event.keyCode===13){
					event.preventDefault();
				}
			});
  		
  			$("#re_pwd_btn").click(function(){
  				console.log("비밀번호 체크--------------------- ");
				rePwdConfirm();
			})
			
  		
  		}) // function()
  		
  			
		//비밀번호 확인 버튼 클릭시 실질적인 처리 함수
		function rePwdConfirm(){
  			
  			
				$.ajax({
					url : "/member/rePwConfirm",
					type : "post",
					data : $("#re_pwd_form").serialize(),
					dataType : "text",
					error : function(){
						alert('시스템 오류입니다. 관리자에게 문의하세요');
					},
					success : function(resultData){
						let goUrl = "";
						if(resultData=="실패"){	
							alert("작성시 입력한 비밀번호가 일치하지 않습니다.  메롱");
							$("#re_pwd").focus();
							/* return "/member/pwConfirm"; */
						}else if(resultData=="성공"){	
						
							actionProcess("post", "/member/myInfo");
								
							}
						}
					
				})
			}
		
  		
  		function actionProcess(method, goUrl){
			
			//form 만 메서드 정의하면 보내는 방식 제어 가능
			$("#re_pwd_form").attr({
				"method": method,
				"action": goUrl
			});
			$("#re_pwd_form").submit();
		}
  		
  		
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
           
            <h1 class="re_pass">비밀번호 재확인</h1>
            <h3 class="re_p_text">보안을 위해 비밀번호를 한번 더 입력해 주세요.</h3>

            <form id="re_pwd_form" class="re_pwd_form" >
           		 <input type="hidden" name="email" id="email" value="${user.email }"/>
                <input type="password" name="password" id="re_pwd" class="re_pwd" placeholder="비밀번호를 입력해 주세요." autofocus> 
                <button name="re_pwd_btn" id="re_pwd_btn" class="re_pwd_btn" type="button"> 확인 </button>
            </form>

    <!-- 버튼 폼 안으로 넣기 -->
            <h3 class="re_p_btext">비밀번호가 기억나지 않으세요? <a href="#" class="re_p_p"> &nbsp;&nbsp;&nbsp;비밀번호 재설정</a></h3>


        </section>



    </div>
</div>
    

</body>
</html>