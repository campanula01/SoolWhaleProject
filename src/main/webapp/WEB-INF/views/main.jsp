<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/common.jspf"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<script src="/SoolWhale/resources/js/main.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link rel="stylesheet" href="/SoolWhale/resources/css/main.css">
</head>
<body>
	<div id="wrap">
		<div data-include1="header" id="header"></div>
		<!--헤더 인클루드-->
		<div class="banner">
			<div>
				<img src="/SoolWhale/resources/img/common/banner.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner2.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner3.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner2.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner3.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner2.jpg" alt="">
			</div>
			<div>
				<img src="/SoolWhale/resources/img/common/banner3.jpg" alt="">
			</div>
		</div>

		<div id="boarder"></div>

		<div id="wrap_main">
			<main class="wrap_center_main">
				<div class="wrap_center">
					<a href="/SoolWhale/project/liquorList?liquorType=탁주"><p class="sinsin">탁주</p></a>
					<div class="slider">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="list" items="${list}" varStatus="status">
								<c:set var="price" value="${list.targetAmount}" />
									<c:if test="${not empty list}">
									
										<c:if test="${list.liquorType eq '탁주' and list.sts eq '진행중'}">
										<a href="/SoolWhale/project/fundingDetailView?projectNum=${list.projectNum}">
											<div class="slider_div project_slider">
												
												<img class="mainImage" src="/home/tomcat/file/project/${list.firstImgFilename}" alt="">
													<div class="product-title">${list.title}</div>
													<ul class="product-tage">
														<li>${list.projectDesc}</li>
													</ul>
													<div class="hr"></div><br/>
													<div class="product-price">목표금액: 
                    									<fmt:formatNumber type="number" pattern="#,##0" value="${price}" var="formattedPrice" />
                    										${formattedPrice}원
                									</div>
											</div>
											</a>
										</c:if>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
					
					<a href="/SoolWhale/project/liquorList?liquorType=증류주"><p class="sinsin">증류주</p></a>
					<div class="slider">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="list" items="${list}" varStatus="status">
								<c:set var="price" value="${list.targetAmount}" />
									<c:if test="${not empty list}">
										<c:if test="${list.liquorType eq '증류주' and list.sts eq '진행중'}">
											<div class="slider_div project_slider">
												
												<a href="/SoolWhale/project/fundingDetailView?projectNum=${list.projectNum}"> <img class="mainImage" src="/home/tomcat/file/project/${list.firstImgFilename}" alt="">
													<div class="product-title">${list.title}</div>
													<ul class="product-tage">
														<li>${list.projectDesc}</li>
													</ul>
													<div class="hr"></div><br/>
													<div class="product-price">목표금액: 
                    									<fmt:formatNumber type="number" pattern="#,##0" value="${price}" var="formattedPrice" />
                    										${formattedPrice}원
                									</div></a>
											</div>
										</c:if>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
					
					<a href="/SoolWhale/project/liquorList?liquorType=과실주"><p class="sinsin">과실주</p></a>
					<div class="slider">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="list" items="${list}" varStatus="status">
								<c:set var="price" value="${list.targetAmount}" />
									<c:if test="${not empty list}">
										<c:if test="${list.liquorType eq '과실주' and list.sts eq '진행중'}">
											<div class="slider_div project_slider">
												
												<a href="/SoolWhale/project/fundingDetailView?projectNum=${list.projectNum}"> <img class="mainImage" src="/home/tomcat/file/project/${list.firstImgFilename}" alt="">
													<div class="product-title">${list.title}</div>
													<ul class="product-tage">
														<li>${list.projectDesc}</li>
													</ul>
													<div class="hr"></div><br/>
													<div class="product-price">목표금액: 
                    									<fmt:formatNumber type="number" pattern="#,##0" value="${price}" var="formattedPrice" />
                    										${formattedPrice}원
                									</div></a>
											</div>
										</c:if>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
					
					<a href="/SoolWhale/project/liquorList?liquorType=약.청주"><p class="sinsin">약.청주</p></a>
					<div class="slider">
						<c:choose>
							<c:when test="${not empty list}">
								<c:forEach var="list" items="${list}" varStatus="status">
								<c:set var="price" value="${list.targetAmount}" />
									<c:if test="${not empty list}">
										<c:if test="${list.liquorType eq '약.청주' and list.sts eq '진행중'}">
											<div class="slider_div project_slider">
												
												<a href="/SoolWhale/project/fundingDetailView?projectNum=${list.projectNum}"> <img class="mainImage" src="/home/tomcat/file/project/${list.firstImgFilename}" alt="">
													<div class="product-title">${list.title}</div>
													<ul class="product-tage">
														<li>${list.projectDesc}</li>
													</ul>
													<div class="hr"></div><br/>
													<div class="product-price">목표금액: 
                    									<fmt:formatNumber type="number" pattern="#,##0" value="${price}" var="formattedPrice" />
                    										${formattedPrice}원
                									</div></a>
											</div>
										</c:if>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>
