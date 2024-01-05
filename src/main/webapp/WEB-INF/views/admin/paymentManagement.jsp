<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>결제 관리(수정 중)</title>

<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
<!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<!-- Add the slick-theme.css if you want default styling -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://kit.fontawesome.com/312ff11b0d.js"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="/SoolWhale/resources/css/admin/myInfoMain.css">




<script src="/SoolWhale/resources/js/member/myInfoMain.js"></script>
<script src="/SoolWhale/resources/js/common/common.js"></script>
<script src="/SoolWhale/resources/js/common/pop.js"></script>
<script src="/SoolWhale/resources/js/admin/color-modes.js"></script>
<script src="/SoolWhale/resources/js/admin/bootstrap.bundle.min.js"></script>
<script src="/SoolWhale/resources/js/admin/sidebars.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.115.4">
<title></title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/sidebars/">



<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

<link href="/SoolWhale/resources/css/admin/bootstrap.min.css" rel="stylesheet">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	width: 100%;
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.btn-bd-primary {
	--bd-violet-bg: #712cf9;
	--bd-violet-rgb: 112.520718, 44.062154, 249.437846;
	--bs-btn-font-weight: 600;
	--bs-btn-color: var(--bs-white);
	--bs-btn-bg: var(--bd-violet-bg);
	--bs-btn-border-color: var(--bd-violet-bg);
	--bs-btn-hover-color: var(--bs-white);
	--bs-btn-hover-bg: #6528e0;
	--bs-btn-hover-border-color: #6528e0;
	--bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
	--bs-btn-active-color: var(--bs-btn-hover-color);
	--bs-btn-active-bg: #5a23c8;
	--bs-btn-active-border-color: #5a23c8;
}

.bd-mode-toggle {
	z-index: 1500;
}

.firstImage {
	width: 100px;
	height: 100px;
}

table {
    width: 100%;
    border-collapse: collapse;
    border-spacing: 0;
}

/* 테이블 헤더 스타일 */
th {
    background-color: #f2f2f2; /* 헤더 배경색 지정 */
    font-weight: bold;
    padding: 10px;
    text-align: left;
    border: 1px solid #dddddd; /* 테두리 스타일 지정 */
}

/* 테이블 셀 스타일 */
td {
    padding: 10px;
    text-align: left;
    border: 1px solid #dddddd; /* 테두리 스타일 지정 */
}

/* 짝수 행 배경색 지정 */
tr:nth-child(even) {
    background-color: #f2f2f2;
}
</style>
<style type="text/css">
.wrap_myinfo{
	display: flex;
}
.main_section{
width: 90%}
</style>


<!-- Custom styles for this template -->
<link href="/SoolWhale/resources/css/admin/sidebars.css" rel="stylesheet">

<script type="text/javascript">
	$(function() {


		/* 기본정보 버튼 클릭 시 처리 이벤트 */
		$("#admin_main").click(function() {
			console.log("기본정보 페이지 호출")
			location.href = "/SoolWhale/admin/adminMain";
		});

		$("#maker_li2").click(function() {
			console.log("판매현황 페이지 호출")
			location.href = "/SoolWhale/project/projectSellingList";
		})

		$("#logout").click(function() {
			location.href = "/SoolWhale/admin/logout"
		});

	});
</script>
<script src="/SoolWhale/resources/js/common/delayPayment.js"></script>

</head>
<body>

	<div id="wrap">
		<div class="wrap_center wrap_myinfo">
			<div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark"
				style="width: 280px;">
				<a href="/"
					class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
					<img src="/SoolWhale/resources/img/common/user_img.png" style="width: 50px; height: 50px"> <span class="fs-4">술고래</span>
				</a>
				<hr>
				<ul class="nav nav-pills flex-column mb-auto">
					<li class="nav-item"><a href="/SoolWhale/admin/main" class="nav-link active"
						aria-current="page" id="adminMain"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#home" /></svg> Main
					</a></li>
					<li><a href="/SoolWhale/admin/userManagement" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#people-circle" /></svg> 회원관리
					</a></li>
					<li><a href="/SoolWhale/admin/paymentManagement" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#speedometer2" /></svg> 결제내역관리
					</a></li>
					<li><a href="/SoolWhale/admin/projectManagement"
						class="nav-link text-white"> <svg class="bi pe-none me-2"
								width="16" height="16">
								<use xlink:href="#table" /></svg> 판매자 프로젝트
					</a></li>
					<li><a href="/SoolWhale/admin/inquiryListManagement" class="nav-link text-white"> <svg
								class="bi pe-none me-2" width="16" height="16">
								<use xlink:href="#grid" /></svg> 문의 관리
					</a></li>
					<li><a href="#"
						class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
						data-bs-toggle="dropdown" aria-expanded="false">
						<button type="button" name="logout" class="logout" id="logout">
							<strong>logout</strong>
						</button>
					</a></li>

				</ul>
				<hr>
				<div class="dropdown">

				</div>
			</div>

			<section class="main_section">
                <div class="slider">
                    <table>
                        <tr>
                            <th>결제 번호</th>
                            <th>프로젝트 번호</th>
                            <th>프로젝트 이름</th>
                            <th>구매자 번호</th>
                            <th>구매자 이름</th>
                            <th>결제일</th>
                            <th colspan="2">관리</th>
                        </tr>
                        <c:choose>
                            <c:when test="${not empty paymentAllList}">
                                <c:forEach var="payment" items="${paymentAllList}" varStatus="status">
                                        <form id="${payment.paymentNum}_form">
                                            <input type="hidden" id="paymentNum" name="paymentNum" value="${payment.paymentNum}">
                                        </form>
                                        <tr>
                                            <td>${payment.paymentNum}</td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td><button type="button" class="acceptBtn" data-project-num="">환불</button></td>

                                        </tr>
                                </c:forEach>
                            </c:when>
                        </c:choose>
                    </table>
                </div>
            </section>

		</div>
	</div>

</body>
</html>