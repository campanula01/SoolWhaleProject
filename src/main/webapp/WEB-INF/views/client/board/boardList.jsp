<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<style type="text/css">
.required{color: aquamarine;}
textarea{resize: none;}
.replyCount{color:pink};

/* Basic Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {

    font-family: 'Arial', sans-serif;
  
    color: #333;
    font-size: 16px;
    line-height: 1.5;
    
}

div.contentContainer{

	margin-top: 20px;

} 
.container {

    max-width: 1200px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   
}

/* Typography */
h3 {
    margin-bottom: 20px;
    font-size: 24px;
}

/* Table Styling */
table {
		
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

thead th {
    background-color: #96dcf0;
    color: #fff;
    padding: 10px;
    text-align: left;
}

tbody td {
    padding: 10px;
    border-top: 1px solid #e0e0e0;
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
    background-color: #333;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
}

.pagination a:hover, .pagination .active a {
    background-color: #96dcf0;
}

/* Existing Inline Styles Enhancement */
.required {
    color: #00b7d4;
    font-weight: bold; /* added for emphasis */
}

textarea {
    resize: none;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.replyCount {
    color: pink;
    font-weight: bold; /* added for emphasis */
}


.btn {

	background-color: white;
	border: 2px solid ;
	width: 60px;
	 border-radius: 4px;
		 
	
}


div.form-group{
    margin-bottom: 5px;
}
div.text-center{
 margin-bottom: 10px;
}
</style>

<script type="text/javascript">
	$(function() {
		/*검색 후 검색 대상과 검색 단어 출력*/
		let word = "<c:out value='${boardVO.keyword}'/>";
		let value = "";
		if (word != "") {
			$("#keyword").val("<c:out value='${boardVO.keyword}' />");
			$("#search").val("<c:out value='${boardVO.search}' />");

			if ($("#search").val() != 'bContent') {
				//:contains()는 특정 텍스트를 포함한 요소 반환
				if ($("#search").val() == 'bTitle')
					value = "#list tr td.goDetail";
				else if ($("#search").val() == 'userNickname')
					value = "#list tr td.userNickname";
				console.log($(value + ":contains('" + word + "')").html());

				//$("#list tr td.goDetail:contains('노력')").html()=><span class='required'>노력</span>에 대한 명언
				$(value + ":contains('" + word + "')").each(
						function() {
							let regex = new RegExp(word, 'gi');
							$(this).html(
									$(this).html().replace(
											regex,
											"<span class='required'>" + word
													+ "</span>"));
						});
			}
		}

		

		/*검색 대상이 변경될 때마다 처리 이벤트 placeholder 가 아니라 value 일때*/
		$("#search").change(function() {
			if ($("#search").val() == "all") {
				$("#keyword").val("전체 목록 조회합니다.");
			} else if ($("#search").val() != "all") {
				$("#keyword").val("");
				$("#keyword").focus();
			}
		})
		

		/*검색 버튼 클릭 시 처리 이벤트*/
		$("#searchData").click(function() {
			if ($("#search").val() != "all") {//제목/내용/작성자 선택시 검색어 유효성 체크
				if (!chkData("#keyword", "검색어를"))
					return;
			}
			$("#pageNum").val(1); //검색 후결과가 1페이지로 다시 가야함.
			goPage();
		});

		
		$("#boardInsertBtn").click(function() {
		    // 사용자 번호의 유무로 로그인 여부 판단
		    var userNum = $('body').data('login');

		    console.log("User number: ", userNum); // 값 확인

		    if (!userNum) {  // userNum이 없는 경우 로그인이 되어있지 않다고 판단
		        alert("로그인이 필요한 서비스입니다.");
		        location.href = "/SoolWhale/member/login";
		        return;
		    }
		    
		    // 로그인한 경우 글쓰기 페이지로 이동
		    location.href = "/SoolWhale/board/write";
		});
		
	// 제목 클릭 시 상세 페이지로 이동하기 위한 이벤트 핸들러.
	$(".goDetail").on("click", function() {
	    // 부모 row에서 bNum 속성 값을 가져옵니다.
	    let bNum = $(this).closest("tr").data("num"); 
	    
	    console.log("글 번호: " + bNum);
	    
	    // 가져온 bNum 값을 숨겨진 입력란에 설정합니다.
	    $("#bNum").val(bNum);
	
	    // 상세 페이지로 이동하기 위해 폼을 제출합니다.
	    $("#detailForm").attr({
	        "method": "get",
	        "action": "/SoolWhale/board/detail"
	    }).submit();
	
	    // 또는 window.location을 직접 사용하여 이동할 수도 있습니다.
	    // window.location.href = "/board/boardDetail?bNum=" + bNum;
	});

		$(".paginate_button a").click(
				function(e) {
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val(
							$(this).attr("href"));
					goPage();
				});

	})
	//검색을 위한 실질적인 처리 함수
	function goPage() {
		if ($("#search").val() == "all") {
			$("#keyword").val("");
		}

		$("#f_search").attr({
			"method" : "get",
			"action" : "/SoolWhale/board/list"
		})
		$("#f_search").submit();
	}
</script>


</head>

<body data-login="${sessionScope.login}">
	<div class="contentContainer container">
		<div class="page-header">
			<!-- <h3 class="text-center">게시판 리스트</h3> -->
		</div>

		<form id="detailForm">
			<input type="hidden" id="bNum" name="bNum" />
		</form>

		<%--=============검색기능 시작=============== --%>
		<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<%--페이징 처리를 위한 파라미터 --%>
				<input type="hidden" name="pageNum" id="pageNum"
					value="${pageMaker.cvo.pageNum }"> <input type="hidden"
					name="amount" id="amount" value="${pageMaker.cvo.amount }">
				<div class="form-group">
					<label>검색조건</label> <select id="search" name="search"
						class="form-control">
						<option value="all">전체</option>
						<option value="bTitle">제목</option>
						<option value="bContent">내용</option>
						<option value="userNickname">작성자</option>
					</select> <input type="text" name="keyword" id="keyword" value="검색어를 입력하세요"
						class="form-control" />
					<button type="button" id="searchData" class="btn btn-success">검색</button>
				</div>

			</form>
		</div>
		<%--검색기능 종료 --%>
		<form id="f_writeForm">
			<%-- ============== 리스트 시작 ======================== --%>
			<div id="boardList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="b-num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="bDate" class="order col-md-1">작성일</th>
							<th class="text-center col-md-1">조회수</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!--  데이터 출력 -->
						<c:choose>
							<c:when test="${not empty boardList}">
								<c:forEach var="board" items="${boardList}" varStatus="status">
								<tr class="text-center" data-num="${board.getBNum()}">
											<td>${board.getBNum()}</td>
											<td class="goDetail text-left"  data-bnum="${board.getBNum()}" >${board.getBTitle()}
											<c:if
												test="${board.rcnt > 0}">
											<span class="replyCount">[${board.rcnt}]</span>
											</c:if>
											</td>
											
											<td class="userNickname" >${board.user.userNickname}
										
											</td>
											
											<td class="text-left">
											    <fmt:formatDate value="${board.getBDate()}" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
											
											<td class="text-center">${board.getReadcnt()}</td>
										
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="tac text-center">등록된 게시글이 존재하지
										않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<%-- ==================================== 리스트 종료 ======================= --%>
			<%--=============페이징 출력 시작======================== --%>
			<div class="text-center">
				<ul class="pagination">
					<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
					<c:if test="${pageMaker.prev }">
						<li class="paginate_button previous"><a
							href="${pageMaker.startPage -1 }">Previous</a></li>
					</c:if>

					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<li
							class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':'' }">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>

					<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
					<c:if test="${pageMaker.next }">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage +1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
			<%--=============페이징 출력 끝======================== --%>

			<%-- ==================================== 글쓰기 버튼 출력 시작 ======================= --%>
			<div class="contentBtn text-right">
				<input type="button" value="글쓰기" id="boardInsertBtn"class="btn btn-success"></input>
			</div>
			<%-- ==================================== 글쓰기 버튼 출력 종료 ======================= --%>
	</div>
</body>
</html>