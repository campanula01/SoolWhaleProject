<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<script src="/resources/js/liquor.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link rel="stylesheet" href="/resources/css/funding/liquorList.css">
</head>
<body>
	<div id="wrap">
		<div data-include1="header" id="header"></div>

		<div id="wrap_main">
			<main class="wrap_center_main">
				<div class="wrap_center">
					<p class="sinsin">
						<c:choose>
							<c:when test="${not empty list }">
								<c:out value="${list[0].liquorType }" />
							</c:when>
						</c:choose>
					</p>
					<div class="liquor">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="list" items="${list}" varStatus="status">
									<c:if test="${not empty list}">
										<div class="slider_div1">
											<a
												href="/project/fundingDetailView?projectNum=${list.projectNum}">
												<img class="mainImage"
												src="/resources/img/project/uploadStorage/project/${list.firstImgFilename}"
												alt="">
												<div class="product-title">${list.title}</div>
											</a>
											<div class="hr"></div>
											<ul class="product-tage">
												<li>${list.projectDesc}</li>

											</ul>
										</div>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>


				</div>
		</div>
		</main>
	</div>
	</div>
</body>
</html>