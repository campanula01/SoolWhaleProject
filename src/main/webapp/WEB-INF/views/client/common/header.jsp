<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
<script src="/SoolWhale/resources/js/common/common.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/312ff11b0d.js"
   crossorigin="anonymous"></script>
<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
<title>Document</title>
<script type="text/javascript">
   $(function() {
      $("#loginFormBtn").click(function() {
         location.href = "/SoolWhale/member/login"
      });
      $("#logOutBtn").click(function() {
    	    // 세션을 무효화하고 로그아웃 처리
    	    $.get("/SoolWhale/member/logout", function() {
    	        // 로그아웃 후 페이지를 새로고침
    	        location.href = "/SoolWhale";
    	    });
    	});

      $("#btn_search").click(function() {      
          if (!chkData("#search_text", "검색어를")) {
              $("#btn_search").focus();
              return;  // 이 부분을 중괄호 안으로 이동합니다.
          }  else {
              $("#seach_form").attr({
                  "method" : "get",
                  "action" : "/SoolWhale/project/search"
              });
              $("#seach_form").submit();
          }
      });
      
   });
</script>
</head>
<body>
   <div id="wrap_header">
      <header class="flex_wrap wrap_center">

         <h1 id="logo">
            <a href="/SoolWhale"><img src="/SoolWhale/resources/img/common/user_img.png" /><span
               id="logo_txt">술고래</span></a>
         </h1>
         <div id="wrap_nav">
            <nav>
               <ul>
                  <li><a href="/SoolWhale/project/liquorList?liquorType=탁주">탁주</a></li>
                  <li><a href="/SoolWhale/project/liquorList?liquorType=증류주">증류주</a></li>
                  <li><a href="/SoolWhale/project/liquorList?liquorType=과실주">과실주</a></li>
                  <li><a href="/SoolWhale/project/liquorList?liquorType=약.청주">약.청주</a></li>
                  <li><a href="/SoolWhale/board/list">게시판</a></li>
               </ul>
            </nav>
         </div>

         <div id="wrap_header_right">
            <div class="search_box">
               <form id="seach_form">
                  <input type="text" placeholder="새로운 일상이 필요하신가요?" id="search_text"
                     name="search_text" /> <a href="#" id="btn_search"><i
                     class="fa fa-search"><span class="hidden_text">검색하기</span></i></a>
               </form>
            </div>

            <div id="header_bnts">
               <!--로그인 전-->
               <c:choose>
                  <c:when test="${not empty login}">
                     <button id="logOutBtn" name="logOutBtn" class="log">로그아웃</button>
                     <a href="/SoolWhale/supporter/likeAllList"><i class="fa-regular fa-heart"></i></a>
                     <a href="/SoolWhale/member/myInfoMain"><i class="fa-regular fa-circle-user"></i></a>
                  </c:when>
                     
                  <c:otherwise>
                     <button id="loginFormBtn" class="log">로그인/회원가입</button>
                  </c:otherwise>
               </c:choose>

            </div>
         </div>

         <div id="wrap_mypage"></div>
      </header>

   </div>


</body>
</html>