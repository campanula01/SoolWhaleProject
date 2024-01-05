<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />

<link rel="shortcut icon" href="/SoolWhale/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/SoolWhale/resources/image/icon.png" />

<link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/common/aside.css">
<link rel="stylesheet" href="/SoolWhale/resources/css/project/projectList.css">

<script type="text/javascript" src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
<script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>

<script src="/SoolWhale/resources/js/common/sidebutton.js"></script>
<title>Insert title here</title>
<script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
<script src="/SoolWhale/resources/js/project/projectList.js"></script>
</head>
<body data-login="${sessionScope.login}">
	<div id="wrap">
		<div data-include1="header" id="header"></div>
		<div class="wrap_center wrap_myinfo">
			<aside class="main_aside" id="wrap_aside">
				<div class="user_img"></div>
				<p class="user_id" id="user_id"><a>사용자 아이디 &gt;</a></p>

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
                    <li class="maker_li1 li_style" id="maker_li1"><a href="/SoolWhale/project/projectList">내 프로젝트</a></li>
                    <li class="maker_li2 li_style" id="maker_li2"><a href="/SoolWhale/project/projectSellingList">판매현황</a></li>
                </ul>
				</div>

			</aside>
			<section class="main_section">
				<div class="wrap_my_project">
					<h1 class="title"><span>내 프로젝트</span> <button type="button" id="newProjectInsert">프로젝트 만들기</button></h1>
					<br />
					<div class="project_status_select">
						<button type="button" class="project_status_all" value=''>전체</button>
						<button type="button" class="project_status_writing" value='작성중'>작성중</button>
						<button type="button" class="project_status_reviewing" value='심사중'>심사중</button>
						<button type="button" class="project_status_accept" value='승인'>승인</button>
						<button type="button" class="project_status_refuse" value='반려'>반려</button>
						<button type="button" class="project_status_openWaiting" value='공개예정'>공개예정</button>
						<button type="button" class="project_status_ongoing" value='진행중'>진행중</button>
						<button type="button" class="project_status_end" value='종료'>종료</button>
					</div>
					<div class="project_status">
						<p>
							프로젝트(<c:out value="${fn:length(projectList)}" /> 개)
						</p>
					</div>
					<c:choose>
						<c:when test="${not empty projectList}">
							<c:forEach var="project" items="${projectList}" varStatus="status">
								<c:if test="${not empty project}">
									<div class="wrap_project_list">
										<form id="projectForm_${project.projectNum}" name="projectForm" method="post">
                        					<input type="hidden" name="projectNum" value="${project.projectNum}">
                        					<input type="hidden" name="firstImgFilename" value="${project.firstImgFilename}">
                        					<input type="hidden" name="profilImgFilename" value="${project.profilImgFilename}">
                        					<input type="hidden" name="userNum" value="${project.userNum}">
                        					<input type="hidden" name="stsVal" value="${project.sts}">
                    					</form>
										<div class="thumbnail_image">
											<c:if test="${project.sts ne '진행중'}">
												<a href="/SoolWhale/project/preview?projectNum=${project.projectNum}">
													<c:if test="${not empty project.firstImgFilename}">
														<img src="/home/tomcat/file/project/${project.firstImgFilename}" class="project_thumbnail_image" />
													</c:if>
													<c:if test="${empty project.firstImgFilename}">
														<img src="/SoolWhale/resources/img/common/logo.png" />
													</c:if>
												</a>
											</c:if>
											<c:if test="${project.sts eq '진행중'}">
												<a href="/SoolWhale/project/fundingDetailView?projectNum=${project.projectNum}">
													<c:if test="${not empty project.firstImgFilename}">
														<img src="/home/tomcat/file/project/${project.firstImgFilename}" class="project_thumbnail_image" />
													</c:if>
													<c:if test="${empty project.firstImgFilename}">
														<img src="/SoolWhale/resources/img/common/logo.png" />
													</c:if>
												</a>
											</c:if>
										</div>
										<div class="project_package">
											<p class="project_thumbnail_status">
												<span>${project.sts}</span>
											</p>
											<c:if test="${project.sts ne '진행중'}">
												<a href="/SoolWhale/project/preview?projectNum=${project.projectNum}">
													<p class="project_thumbnail_title">${project.title}</p>
													<p class="project_thumbnail_content">${project.projectDesc}</p>
												</a>
											</c:if>
											<c:if test="${project.sts eq '진행중'}">
												<a href="/SoolWhale/project/fundingDetailView?projectNum=${project.projectNum}">
													<p class="project_thumbnail_title">${project.title}</p>
													<p class="project_thumbnail_content">${project.projectDesc}</p>
												</a>
											</c:if>
										</div>
										<div class="project_controll">
										<c:if test="${project.sts ne '진행중'}">
											<div class="projectUpdate">
												<button type="button" class="projectUpdateBtn" data-project-num="${project.projectNum}">수정</button>
											</div>
											<div class="projectDelete">
												<button type="button" class="projectDeleteBtn" data-project-num="${project.projectNum}">삭제</button>
											</div>
											</c:if>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
			</section>

		</div>
	</div>
</body>
</html>