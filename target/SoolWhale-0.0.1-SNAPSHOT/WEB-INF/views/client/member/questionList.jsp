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
  		
  		<link rel="stylesheet" href="/SoolWhale/resources/css/member/questionList.css">
  	
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
  		<link rel="stylesheet" href="/SoolWhale/resources/css/common/pop.css">
  		
  		<script src="/SoolWhale/resources/js/member/questionList.js"></script>
  		<script src="/SoolWhale/resources/js/common/common.js"></script>
  		<script src="/SoolWhale/resources/js/common/pop.js"></script>
  			<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
		<script type="text/javascript">
 		$(function(){
 			
	
 			//제목 클릭시 상세 페이지 이동을 위한 처리 이벤트
 			$(".goDetail").click(function(){
 				
 				let question = $(this).parents("tr").attr("data-num");
 				$("#inquiryNum").val(question);
 				console.log("글 번호: "+question);
 				let selectedValue = $("#yourSelectElement").val()
 				
 				//상세 페이지로 이동하기 위해 form추가 id: detailForm
 			/* $("#inquiryForm").attr({
 					"method":"get",
 					"action":"/member/questionDetail"
 				});
 				
 				
 				
 				$("#inquiryForm").submit();   */
 				
 				
 				location.href = "/SoolWhale/member/questionDetail?inquiryNum="+question
 			});
 			
 			
 	
 		});
 		
 	
 	
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
            <form id="inquiryForm" >
            	<input type="hidden" id="inquiryNum" name="inquiryNum" "/>
            
            </form>
            
            <div class="my_btn_list">
                <span class="my_que que_box" id="my_que"><a>내 문의 내역</a></span>
                <span class="try_que que_box" id="try_que"><a>문의 하기</a></span>
            </div>
            
            
            <h1 class="que_text">내 문의 내역</h1>

            <div class="que_back" id="que_back">

                    <table summary = "문의 게시판" class="order list_table">
                        <thead class="list_table_h">
                            <tr>
                                <th data-value="inquiry_num" class="text_center or_md_1">No</th>
                                <th class="or_md_1">카테고리</th>
                                <th class="or_md_2">제목</th>
                                <th class="or_md_0">작성시간</th>
                           
                         
                            </tr>
                        </thead>
                   <tbody>
                           <c:choose>
                                <c:when test="${not empty inquiryList}">
                            	 <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
    							<tr class="text-center" data-num="${inquiry.inquiryNum}">
    						
        						<td class="table_td1">${inquiry.inquiryNum}</td>
      							 <td class="table_td4">${inquiry.cat}</td>
       							 <td class="name table_td3  goDetail">${inquiry.inquiryTitle}</td>
       							 <td class="table_td2">${inquiry.inquiryDate}</td>
   									
   							 </tr>
								</c:forEach>
                                </c:when>
                                <c:otherwise>
                                	<td colspan="4" >등록된 문의글이 존재하지 않습니다.</td>
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