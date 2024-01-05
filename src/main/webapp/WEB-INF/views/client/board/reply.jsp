<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
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
</style>

<script type="text/javascript">
// JavaScript 코드 내에 댓글 데이터를 저장하는 배열 추가
let replyDataArray = [];

$(function() {
    // user.getBNum()은 서버에서 값을 가져온다고 가정합니다.
    // 서버에서 정확한 값을 받아오도록 수정이 필요합니다.
    let bNum = ${user.getBNum()};
    
    // 로그인한 사용자의 userNum을 가져옵니다.
    let loggedInUserNum = '${sessionScope.userNum}';
    
    console.log(bNum);
    listAll(bNum);

    $('#replyInsertBtn').on('click', function() {
        const rContent = $('#rContent').val().trim();
        const userNickname = '${sessionScope.userNickname}';
        const userNum = '${sessionScope.userNum}';
        console.log(userNum);
        
        // user.getBNum() 대신에 위에서 가져온 bNum을 사용합니다.
        const bNum = ${user.getBNum()};
        let insertUrl = "/SoolWhale/replies/replyInsert";

        if (!rContent) {
            alert('댓글 내용을 입력해주세요.');
            return;
        }

        const replyData = {
            bNum,
            userNum,
            rContent
        };

        $.ajax({
            url: insertUrl,
            type: "post",
            headers: { "Content-Type": "application/json" },
            dataType: "text",
            data: JSON.stringify(replyData),
            error: function(xhr, textStatus, errorThrown) {
                alert(textStatus + "(HTTP-" + xhr.status + " / " + errorThrown + ")");
            },
            success: function(result) {
                if (result === "SUCCESS") {
                    alert("댓글 등록 완료!");
                    dataReset();
                    listAll(bNum);
                }
            }
        });
    });

    $('#reviewList').on('click', '.btn-delete', function() {
        var rNum = $(this).attr('data-rnum'); // data-rnum 속성 값 가져오기
        console.log('Delete button clicked! rNum:', rNum);

        $.ajax({
            url: '/SoolWhale/replies/' + rNum,
            type: 'DELETE',
            success: function(result) {
                if (result == "SUCCESS") {
                    alert("댓글 삭제 완료!");
                    listAll(bNum);
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
            }
        });
    });

    function listAll(bNum) {
        console.log("listAll function bNum: " + bNum);
        // 해당 클래스가 있을 경우 삭제하고 다시 댓글 목록을 채우기 위해
        $(".reply").remove();
        let url = "/SoolWhale/replies/all/" + bNum;

        $.getJSON(url, function(data) {
            console.log(data);
            // 댓글 데이터를 JavaScript 배열에 저장
            replyDataArray = data;

            // JavaScript 배열에서 데이터를 가져와서 표시
            replyDataArray.forEach(function(reply) {
                renderReply(reply);
            });
        }).fail(function() {
            alert("댓글 불러오기 실패....");
        });
    }

    function renderReply(reply) {
        var $newReply = $('#item-template').clone().removeAttr('id').show();
        $newReply.addClass('reply'); // This will help us remove it later with $(".reply").remove();
        $newReply.find('.name').text(reply.user.userNickname);
          

                // Parse the date string
                let date = new Date(reply.rDate);

                // Format the date
                let formattedDate = new Intl.DateTimeFormat('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                }).format(date);

                // Set the formatted date
                $newReply.find('.date').text(formattedDate);

                $newReply.find('.panel-body').html(reply.rContent);

                if ('${not empty sessionScope.login}') {
                    var loggedInUserNum = '${sessionScope.userNum}';
                    var rUserNum = reply.user.userNum; // JavaScript 배열에서 댓글 작성자의 userNum을 가져옴

                    // 로그인한 사용자와 댓글 작성자가 같은 경우 또는 게시판 글을 쓴 사용자인 경우 삭제 버튼 생성
                    if (loggedInUserNum == rUserNum || loggedInUserNum == '${user.userNum}') {
                        var $deleteButton = $('<input type="button" data-rnum="' + reply.rNum + '" value="삭제" class="btn-delete btn btn-success" />');
                        $newReply.find('.panel-title').append($deleteButton);

                        // 삭제 버튼 클릭 시
                        $deleteButton.on('click', function() {
                            var rNum = $(this).attr('data-rnum'); // data-rnum 속성 값 가져오기
                            console.log('Delete button clicked! rNum:', rNum);

                            // JavaScript 배열에서 해당 댓글 데이터를 제거
                            replyDataArray = replyDataArray.filter(function(item) {
                                return item.rNum != rNum;
                            });

                            // 화면에서도 삭제
                            $(this).closest('.reply').remove();

                            $.ajax({
                                url: '/SoolWhale/replies/' + rNum,
                                type: 'DELETE',
                                success: function(result) {
                                    if (result == "SUCCESS") {
                                        alert("댓글 삭제 완료!");
                                    }
                                },
                                error: function(xhr, textStatus, errorThrown) {
                                    alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
                                }
                            });
                        });
                    }
                }

                $('#reviewList').prepend($newReply);
            }

            function dataReset() {
                $("#replyForm").each(function() {
                    this.reset();
                });

                $("#r_name").prop("readonly", false);
                $("#replyForm button[type='button']").removeAttr("data-rnum");
                $("#replyForm button[type='button']").attr("id", "replyInsertBtn");
                $("#replyForm button[type='button'].sendBtn").html("저장");
                $("#replyForm button[type='button'].resetBtn").detach();
                // 공백 체크
            }
        });
      
    </script>
</head>
<body>
	<c:choose>
		<c:when test="${not empty sessionScope.login}">
			<%-- 로그인 했을 때 댓글 입력 화면 --%>
			<form id="replyForm" name="replyForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left"><textarea
										class="form-control" rows="3" name="rContent" id="rContent"></textarea>
								</td>
								<td>
									<button type="button" id="replyInsertBtn" name=replyInsertBtn>댓글
										등록</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
		</c:when>
		<c:otherwise>
			<p>댓글을 작성하려면 로그인 해주세요.</p>
		</c:otherwise>
	</c:choose>

	<div id="reviewList">
		<!-- 템플릿 div. 실제로는 표시되지 않지만, renderReply에서 복사하여 사용됩니다. -->
		<div id="item-template" class="panel panel-success"
			style="display: none;">
			<div class="panel-heading">
				<h3 class="panel-title">
					<!-- 댓글 작성자 이름 -->
					<span class="name"></span>
					<!-- 댓글 작성 일시 -->
					<span class="date"></span>
					<!-- 삭제 버튼. 각 댓글 항목별로 rnum 데이터 속성을 설정하여 추후 삭제 기능에서 사용할 수 있습니다. -->
					<!-- 로그인한 사용자가 댓글 작성자일 경우, 수정 버튼 표시 -->
					<c:choose>
						<c:when test="${not empty sessionScope.login}">
							<c:if test="${sessionScope.userNum == '${reply.user.userNum}'}">
								<input type="button" data-rnum="${reply.rNum}" value="삭제"
									class="btn-delete btn btn-success" />
							</c:if>
						</c:when>
						<c:otherwise>
							<!-- 로그인하지 않은 사용자에게는 삭제 버튼을 표시하지 않습니다. -->
						</c:otherwise>
					</c:choose>

				</h3>
			</div>
			<!-- 댓글 내용 -->
			<div class="panel-body"></div>
			
		</div>
		
	</div>
</body>
</html>