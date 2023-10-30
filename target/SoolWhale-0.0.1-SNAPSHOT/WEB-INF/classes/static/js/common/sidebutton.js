
$(function(){


			$("#user_id").click(function(){
  				console.log("비밀번호 확인 페이지 호출");
  				location.href = "/SoolWhale/member/pwConfirm";
  			});
 			
 			
 			/* 기본정보 버튼 클릭 시 처리 이벤트 */
 			$("#basic_info").click(function(){
 				console.log("기본정보 페이지 호출")
 				location.href="/SoolWhale/member/myInfo"
 			});
 			
 				/* 포인트 내역 버튼 클릭 시 처리 이벤트 */
 			$("#point_info").click(function(){
 				console.log("술포인트 페이지 호출")
 				location.href="/SoolWhale/member/pointCheckList"
 			});
 		
 			$("#user_id").click(function(){
 				console.log("비밀번호 재확인 페이지 호출")
 				location.href="/SoolWhale/member/pwConfirm"
 			})
 			
 			$("#question").click(function(){
 				console.log("문의 내역 페이지 호출")
 				location.href="/SoolWhale/member/questionList"
 			})
 			$("#support_li1").click(function(){
 				console.log("주문내역 페이지 호출")
 				location.href="/SoolWhale/payment/paymentList"
 			})
 			$("#support_li2").click(function(){
 				console.log("관심 프로젝트 페이지 호출")
 				location.href="/SoolWhale/supporter/likeAllList"
 			})
 			$("#likeAll").click(function(){
 				console.log("전체 프로젝트 리스트 ")
 				location.href="/SoolWhale/supporter/likeAllList"
 			})
 			
 			$("#likeBefore").click(function(){
 				console.log("진행예정 프로젝트 리스트 ")
 				location.href="/SoolWhale/supporter/likeBefore"
 			})
 			
 			$("#likeAfter").click(function(){
 				console.log("진행종료 프로젝트 리스트 ")
 				location.href="/SoolWhale/supporter/likeAfter"
 			})
 			$("#likeIng").click(function(){
 				console.log("진행중 프로젝트 리스트 ")
 				location.href="/SoolWhale/supporter/likeIng"
 			})
 			
 			
 			$("#maker_li1").click(function(){
 				console.log("내 프로젝트 페이지 호출")
 				location.href="/SoolWhale/project/projectList"
 			})
 			$("#maker_li2").click(function(){
 				console.log("판매현황 페이지 호출")
 				location.href="/SoolWhale/project/projectSellingList"
 			})
 			
 			
 			
 			$("#pre_btn").click(function(){
 				console.log("이전 페이지 호출 - myInfoMain로")
 				location.href="/SoolWhale/member/myInfoMain"
 			})
 			
 			
 			$("#my_que").click(function(){
 				console.log("내 문의내역 페이지 호출")
 				location.href="/SoolWhale/member/questionList";
 			})
 			$("#try_que").click(function(){
 				console.log("문의 하기 페이지 호출")
 				location.href="/SoolWhale/member/questionForm";
 			})
 			
 			
 			
 })