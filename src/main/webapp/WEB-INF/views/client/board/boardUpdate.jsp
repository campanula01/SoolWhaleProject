<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
</head><style type="text/css">
.panel, .panel-heading, .panel-body, .panel-h3, .panel-span, .btn {
	background-color: unset;
	border: none;
	box-shadow: none;
	margin: 0;
	padding: 0;
}

/* Basic Reset */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

/* 색상 팔레트 */
:root {
	--primary-color: #96dcf0;
	--secondary-color: #e0e0e0;
	--accent-color: #FFC107;
	--background-color: #f4f4f4;
	--font-color: #333;
	--btn-hover: #96dcf0;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	color: var(--font-color);
	background-color: #fff;
	font-size: 16px;
	line-height: 1.5;
}
div.contentTit{

	margin-top: 40px;

} 

.container {
	max-width: 1200px;
	margin: 20px auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

/* Typography */
h3 {
	font-size: 24px;
	color: var(--primary-color);
}

/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

thead th {
	background-color: var(--primary-color);
	color: #fff;
	padding: 10px;
	text-align: left;
}

.panel tbody td {
	padding: 10px;
	border-top: 1px solid var(--secondary-color);
	height: 120px;
}

/* Pagination Styling */
.pagination {
	list-style-type: none;
}

.pagination li {
	display: inline-block;
	margin: 0 5px;
}

.pagination a {
	padding: 5px 10px;
	background-color: var(--primary-color);
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
}

.pagination a:hover, .pagination .active a {
	background-color: var(--accent-color);
}

/* Textarea Styling */
textarea {
	resize: none;
	padding: 10px;
	border: 1px solid var(--secondary-color);
	border-radius: 4px;
}

/* Button Styling */
.btn {
	background-color: white;
	border: 2px solid var(--primary-color);
	color: var(--primary-color);
	cursor: pointer;
	transition: all 0.3s;
	width: 60px;
	border-radius: 4px;
}

.btn:hover {
	background-color: var(--btn-hover);
	color: #fff;
}

/* Additional Styling */
.required, .reply_count {
	font-weight: bold;
}

.required {
	color: aquamarine;
}

.reply_count {
	color: pink;
}

div.form-group {
	margin-bottom: 5px;
}

div.text-center {
	margin-bottom: 10px;
}

div.contentContainer {
	margin-top: 20px;
}

#replyInsertBtn {
	background-color: white;
	color: var(--primary-color);
	cursor: pointer;
	transition: all 0.3s;
	width: 100%;
	height: 100%;
}

#replyInsertBtn:hover {
	background-color: var(--btn-hover);
	color: #fff;
}

.panel:not(:first-child) {
	border-top: 1px solid var(--secondary-color);
	padding-bottom: 8px; /* 구분선과 내용 사이에 간격 추가 */
	margin-top: 8px; /* 구분선과 아래 내용 사이에 간격 추가 */
	margin-bottom: 8px; /* 구분선과 아래 내용 사이에 간격 추가 */
}

#reviewList .panel-heading {
	margin-top: 8px; /* 구분선과 아래 내용 사이에 간격 추가 */
	border-bottom: 1px solid #d3d3d3; /* panel-heading 아래에 구분선 추가 */
}

#reviewList .panel-title .name, #reviewList .panel-title .date {
	display: inline-block; /* name과 date를 inline-block으로 설정 */
	border-right: 1px solid #d3d3d3; /* name과 date 사이에 구분선 추가 */
	padding-right: 8px; /* name 오른쪽에 패딩 추가 */
	margin-right: 8px; /* name 오른쪽에 마진 추가 */
}

#reviewList .panel-title .date {
	border-right: none; /* date 오른쪽에는 구분선 없음 */
}

/* 기존 CSS는 유지하며, 추가적인 스타일을 아래에 적어줍니다. */

/* Form Styling */
.form-frizontal {
	max-width: 700px;
	margin: 0 auto;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.table {
	margin-bottom: 0; /* 테이블 아래 마진 제거 */
}

.table td {
	vertical-align: middle; /* 텍스트를 셀 중앙에 위치시킵니다. */
}

/* Input & Textarea Styling */
  td input[type=text], textarea {
	width: 100%;
	padding: 10px;
	margin-top: 5px;
	border: 1px solid #dcdcdc;
	border-radius: 4px;
	box-sizing: border-box;
	outline: none;
}

input[type=text]:focus, textarea:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 5px var(--primary-color);
}

/* Button Styling */
.text-right {
	margin-top: 20px;
}

.btn {
	width: 80px;
	padding: 10px;
	font-size: 16px;
	border-radius: 4px;
	transition: background-color 0.3s ease;
}

.btn-success {
	color: #fff;
	background-color: var(--primary-color);
	border: none;
}

.btn-success:hover {
	background-color: var(--btn-hover);
}
</style>
<script type="text/javascript">
	$(function() {
		$("#boardUpdateBtn").click(function() {
			//입력값 체크
			if (!chkData("#bTitle", "제목을")) return;
			else if (!chkData("#bContent", "작성할 내용을")) return;
		
			else {
				$("#f_updateForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/SoolWhale/board/update"
				});
				$("#f_updateForm").submit();
			}
		})
		
		/* 취소 버튼 클릭 시 처리 이벤트 */
		$("#boardCancelBtn").click(function() {
			$("#f_updateForm").each(function() {
				this.reset();
			})
		})
		/* 목록 버튼 클릭시 처리 이벤트*/
		$("#boardListBtn").click(function() {
			location.href = "/SoolWhale/board/list";
		})
	
	}); //$종료문
	

</script>

<body>
	<div class="contentContainer container">
		<%-- ================== 상세 정보 보여주기 시작 ====================== --%>
		<div class="contentTB text-center">
			<form id="f_updateForm" name="f_updateForm">
				<input type="hidden" id="bNum" name="bNum" value="${boardVO.getBNum()}" />
				
				<table class="table table-bordered">
					<tbody>
					<tr>
							<td class="col-md-3">글번호</td>
							<td class="text-left col-md-3">${boardVO.getBNum()}</td>
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${boardVO.getBDate()}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="3" class="text-left"><span class="name">${boardVO.user.userNickname}</span>
							  (조회수: ${boardVO.getReadcnt()})</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td colspan="3" class="col-md-8 text-left"><input
								type="text" name="bTitle" id="bTitle"
								value="${boardVO.getBTitle()}" class="form-control" /></td>
						</tr>
						<tr class="table-tr-height">
							<td class="col-md-4">글내용</td>
							<td colspan="3" class="col-md 8 text-left"><textarea
									name="bContent" id="bContent" class="form-control" rows="8">${boardVO.getBContent()}</textarea></td>
						</tr>

					
					</tbody>
				</table>
			</form>
		</div>

		<div class="contentBtn text-right">
			<input type="button" class="btn btn-success" value="수정"
				id="boardUpdateBtn" /> <input type="button"
				class="btn btn-success" value="취소" id="boardCancelBtn" /> <input
				type="button" class="btn btn-success" value="목록" id="boardListBtn" />
		</div>

	</div>


</body>
