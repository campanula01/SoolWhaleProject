<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/funding/fundingList.css">
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />

    <script src="/resources/js/common/delayPayment.js"></script>
</head>
<body>
	<div id="wrap">
	   <div id="wrap_main">
	   <main class="wrap_center_list">
	    	<div class="wrap_center">
				<div class="middle"></div><br>
				<div class="main-content">
					<!-- Add this class -->
					<div class="search">
						<ul class="product-list">
							<!-- Add this class -->
							<c:forEach var="project" items="${project}">
								<li class="product-item">
									<!-- Add this class --> <img
									src="${project.firstImgFilename != null ? project.firstImgFilename : '/resources/image/default.png'}"
									alt="Product Image" class="product-image">
									<div class="product-info">
										<!-- Add this class -->
										<p class="product-title">${project.title != null ? project.title : 'N/A'}
										<p>
										<p>
											<strong>targetAmount: </strong> ${project.targetAmount != null ? project.targetAmount : 'N/A'}
										</p>
										<!-- ... -->
									</div>
									<div class="likeempty""></div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</main>
		</div>
	</div>
</body>

</html>