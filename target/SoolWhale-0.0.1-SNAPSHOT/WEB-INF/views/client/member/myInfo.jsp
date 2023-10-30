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
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/member/myInfo.css">
  	
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		
  		<script src="/SoolWhale/resources/js/member/myInfo.js"></script>
  		<script src="/SoolWhale/resources/js/common/common.js"></script>
  		<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
  		<script src="/SoolWhale/resources/js/common/pop.js"></script>
 		
 		<script type="text/javascript">
 		$(function(){
 			
 			
 			
 			
 			$("#cancle_btn").click(function(){
 				if(confirm("탈퇴하시겠습니까?")){
 					console.log("user");
 					
 					$("#f_data").attr({
 						"method" : "post",
 						"action" : "/member/userDelete"
 						
 					});
 					
 					$("#f_data").submit();
 					
 				}
 			})
 			
 			
 			$("#re_btn").click(function(){
  				console.log("비밀번호 체크--------------------- ");
				rePwdConfirm();
			})
 			
 			
 		});  // function 종료
 		
 		//비밀번호 확인 버튼 클릭시 실질적인 처리 함수
		function rePwdConfirm(){
  			
			 if(!chkData("#ex_pwd", "현재 비밀번호")) return;
				$.ajax({
					url : "/member/upPwdConfirm",
					type : "post",
					data : $("#re_pwd_form").serialize(),
					dataType : "text",
					error : function(){
						alert('시스템 오류입니다. 관리자에게 문의하세요');
					},
					success : function(resultData){
						console.log(resultData)
						let goUrl = "";
						if(resultData=="실패"){	
							alert("작성시 입력한 비밀번호가 일치하지 않습니다.  메롱");
							$("#re_pwd").focus();
							/* return "/member/pwConfirm"; */
						}else if(resultData=="성공"){
								
							 if(!chkData("#re_pwd", "비밀번호")) return;
							 else if($("#re_pwd").val() == $("#re_pwd_con").val()){
								 console.log("비밀번호 성공 및 일치--------------------- ");
								 // 두 비밀번호가 일치
								 //actionProcess("post", "/member/myInfoUpdate");
									
									$("#re_pwd_form").attr({
										"method": "post",
										"action": "/member/myInfoUpdate"
									});
									$("#re_pwd_form").submit();
								 
							 }else{
								 alert("비밀번호가 일치하지 않습니다.");
							 }
							
							}
						}
					
				})
			}
		
  	/* 	
  		function actionProcess(method, goUrl){
			
			//form 만 메서드 정의하면 보내는 방식 제어 가능
			$("#re_pwd_form").attr({
				"method": method,
				"action": goUrl
			});
			$("#re_pwd_form").submit();
			
		} */
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
                <span class="basic_info info_box" id="basic_info"><a>기본정보</a></span>
                <span class="point_info info_box" id="point_info"><a>포인트 내역</a></span>
            </div>

            <h1 class="info_text">내 정보 관리</h1>
            <form name="f_data" id="f_data">
            		<input type="hidden" name="email" value="${email}" />
            </form>
            
            
            	<form class="my_info_f" id="my_info_f">
                <table class="my_info_table" id="my_info_table">
                    <tr>
                        <td class="td_mid-title">아이디</td>
                        <td>${userData.id}<span>본인인증 완료</span></td>
                    </tr>
                    <tr>
                    	<td class="td_mid-title"> 이메일 </td>
                    	<td>${userData.email}</td>
                    <tr >
                        <td class="td_mid-title">이름</td>
                        <td>${userData.name}</td>
                    </tr>
                    <tr>
                        <td class="td_mid-title">별칭</td>
                        <td>${userData.userNickname}</td>
                    </tr>
                   <tr >
                        <td class="td_mid-title">핸드폰</td>
                        <td>${userData.phoneNumber}</td>
                    </tr>
            	</form>        
                    <tr >
                        <td class="td_mid-title">비밀번호</td>
                        <td class="pass_wrap">
                            <span>비밀번호 변경</span> <br>
 					<form id="re_pwd_form" class="re_pwd_form" >
 							<input type="hidden" name="email" value="${email}" />
                          	<input type="password" name="ex_pwd" id="ex_pwd" class="ex_pwd" placeholder="현재 비밀번호"/><br />
                            
                            <input type="password" name="re_pwd" id="re_pwd" class="re_pwd" placeholder="새 비밀번호"/> <br />
                            <input type="password" name="re_pwd_con" id="re_pwd_con" class="re_pwd_con" placeholder="새 비밀번호 확인"/> 
                            <input type="button" class="re_btn" id="re_btn" name="re_btn" value="비밀번호 수정">
                     </form>
                        </td>
                    </tr>
 
                </table>
                <div class="btn_cl">
                    <input type="button" class="pre_btn" id="pre_btn" name="pre_btn" value="이전"  >
                    <input type="button" class="cancle_btn" id="cancle_btn" name="cancle_btn" value="회원탈퇴"> 
                </div>
            
        </section>



    </div>
</div>

</body>
</html>