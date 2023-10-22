<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<!DOCTYPE html>
<html>
<style type="text/css">
/* 전체 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

table {
	width: 100%;
	border-collapse: collapse;
}

td {
	padding: 10px;
	border: 1px solid #ddd;
}

textarea {
	resize: none; /* 브라우저에서 텍스트 영역 크기 조절 방지 */
}

.panel {
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.panel-heading {
	background-color: #4caf50;
	color: white;
}

.panel-title {
	font-size: 1.2em;
}

.btn {
	padding: 5px 15px;
	margin-left: 5px;
	cursor: pointer;
}

.btn-success {
	background-color: #4caf50;
	color: white;
	border: none;
}

.btn-default {
	background-color: #ddd;
	color: black;
	border: none;
}

.gap {
	margin-right: 10px;
}

.btnArea {
	text-align: right;
}

.form-control {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
}

/* Hide item-template by default */
#item-template {
	display: none;
}

/* Reply name and date styling */
.name {
	font-weight: bold;
	margin-right: 5px;
}

.date {
	font-size: 0.9em;
	color: #888;
}
</style>
<script type="text/javascript">
	$(function() {
		// 수정 버튼 클릭 시 처리 이벤트
		$("#updateFormBtn").click(function() {

			var bNumValue = $("input[name='bNum']").val();
			location.href = "/board/update?bNum=" + bNumValue;
		});

		// 삭제 버튼 클릭시 처리 이벤트
		$("#boardDeleteBtn").click(function() {
			if (confirm("정말 삭제하시겠습니까?")) {
				var bNumValue = $("input[name='bNum']").val();
				location.href = "/board/delete?bNum=" + bNumValue;

			}
		});

		// 글쓰기 버튼 클릭시 처리 이벤트
		$("#insertFormBtn").click(function() {
			location.href = "/board/write";
		});

		// 목록버튼 클릭시
		$("#boardListBtn").click(function() {
			location.href = "/board/list";
		});

	}); //$종료문

	function boardAction(goUrl) {
		$("#f_data").attr({
			"method" : "post",
			"action" : goUrl
		});
		$("#f_data").submit();
	}
</script>

</head>
<body>
	<input type="hidden" name="bNum" value="${user.getBNum()}" />
	<div class="contentContainer container">
		<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 상세보기</h3></div> -->
		<form name="f_data" id="f_data" method="get">
			<input type="hidden" name="bNum" value="${user.getBNum()}" />
		</form>



		<%--============상세 정보 보여주기 시작======================= --%>
		<div class="contentTB text-center">
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${user.user.userNickname}(조회수:
							${user.getReadcnt() })</td>
						<td class="col-md-3">작성일</td>

						<td class="text-left"><fmt:formatDate
								value="${user.getBDate()}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<td class="col-md-4">글제목</td>
						<td colspan="3" class="col-md-8 text-left">${user.getBTitle() }</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-4">글내용</td>
						<td colspan="3" class="col-md-8 text-left">${user.getBContent() }</td>
					</tr>

				</tbody>
			</table>
		</div>
		<%-- ========================상세 정보 보여주기 종료 ========================= --%>
		<jsp:include page="reply.jsp" />
		<%--======비밀번호 확인 버튼 및 버튼 추가 시작======== --%>
		<%-- 비밀번호 확인 버튼 및 버튼 추가 시작 --%>
		<c:if test="${sessionScope.userNum == user.userNum}">
			<!-- 로그인한 사용자가 게시물 작성자일 경우, 수정/삭제 버튼 표시 -->
			<input type="button" value="글수정" id="updateFormBtn"
				class="btn btn-success" />
			<input type="button" value="글삭제" id="boardDeleteBtn"
				class="btn btn-success" />
		</c:if>

		<input type="button" value="목록" id="boardListBtn"
			class="btn btn-success" />
	</div>
</body>
</html>