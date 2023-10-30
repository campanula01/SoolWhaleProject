<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/client/common/header.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		
		<title>Insert title here</title>
		
		<link rel="shortcut icon" href="/SoolWhale/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/SoolWhale/resources/image/icon.png" />
		
		<!--[if lt IE 9]>
		<script src="/SoolWhale/resources/js/html5shiv.js"></script>
		<![endif]-->

<script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
<script src="/SoolWhale/resources/js/common/jquery-1.12.4.min.js"></script>
  <link rel="stylesheet" href="/SoolWhale/resources/css/funding/fundingPayment.css">
  <script src="/SoolWhale/resources/js/funding/fundingPayment.js"></script>
  <script src="/SoolWhale/resources/js/common/common.js"></script>
  <script src="https://kit.fontawesome.com/312ff11b0d.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

 

    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

     <link rel="stylesheet" href="/SoolWhale/resources/css/common/common.css">
    <link rel="stylesheet" href="/SoolWhale/resources/css/common/header.css">
    <script src="/SoolWhale/resources/js/common/common.js"></script>
    <script src="/SoolWhale/resources/js/common/header.js"></script>
    

	</head>
	<body>
	<div id="wrap">

     <div data-include1="header" id="header"></div>
    <div class="wrap_center wrap_fundingPay">
    <div class="purchase_title">
    <c:forEach var="product" items="${selectedProducts}" varStatus="status">
    			<c:if test="${status.index == 0}">
        		<div>${product.rewardTitle}</div>
        		<input type="hidden" name="projectNum" class="projectNum" value="${product.projectNum }">

    		</c:if>
		</c:forEach>
    </div>
    <div id="purchase_wrap">

      <div class="container">
        <div class="circle_container">
          <div class="circle">
            <div class="word">리워드 선택</div>
          </div>
        </div>

        <div class="connector"></div>
        <div class="circle_container">
          <div class="circle_selected">
            <div class="word">결제 하기</div>
          </div>
        </div>

        <div class="circle_container">
          <div class="circle">
            <div class="word">결제 완료</div>
          </div>
        </div>

      </div>
    </div>


    <div id="form_all">
      <form name="purchase_form" id="purchase_form">

        <div class="purchase_order">
          <div class="order_list" data-choice-length="1">
          <c:choose>
    <c:when test="${not empty selectedProducts}">
        <c:forEach var="product" items="${selectedProducts}" varStatus="status">
 			<input type="hidden" name="rewardNum" class="rewardNum" value="${product.rewardNum }" >
            <input type="hidden" id="projectNum" value="${product.projectNum }">

            <ul>
              <li>
                <p class="title">
                  ${product.name}
                 
                </p>
                <p class="text">
                  ${product.rewardDesc }
                </p>
                <div class="info ">
                  <p class="sum ">
                    수량 : ${product.quantity }개  <span class="product-amount">${product.amount}</span>원
                  </p>
                </div>
              </li>
            </ul>
           </c:forEach>
    </c:when>
</c:choose>
            </div>
            <div class="orader_add_info">
            
                <div class="right_aligned">
                  <div>추가 후원금 </div>
                 
                   <c:forEach var="product" items="${selectedProducts}" varStatus="status">
    			<c:if test="${status.index == 0}">
        		<div>${product.additionalDonation}원</div>
    			</c:if>
    			</c:forEach>
                  
                </div>
                
                
              <div class="right_aligned">
                <div>배송비</div>
                <c:forEach var="product" items="${selectedProducts}" varStatus="status">
    			<c:if test="${status.index == 0}">
        		<div>${product.deliveryCharge}원</div>
    		</c:if>
		</c:forEach>
              </div>
              <div class="point">
                <div class="right_aligned">
                  <div>포인트 사용</div>
                  <div>
                    <label>
                      <input type="checkbox" id="point_all">
                      모두 사용(보유포인트<span id="usable_point">
                      
        					<!-- 첫 번째 요소의 title만 출력 -->
        					${pointSum.pointSum}
    					
                      </span>P)</label>
                    <input type="text" id="point_input" value=0 readonly>
                  </div>
                </div>
              </div>
            </div>
            <div id="reward_funding_price">
              <h3 class="base_title">결제예약 금액</h3>
              <div class="base_content">
                <div class="base_pricearea">
                  <div class="reward_value_container">
                    <div class="right_aligned">
                      <div>리워드 금액</div>
                      <div>
                        <span class="reward_value">
                          <em class="reward_value_amount">리워드 금액</em>
                          원
                        </span>
                      </div>
                    </div>
                  </div>
                  
                   <div class="reward_value_container">
                    <div class="right_aligned">
                  <div>추가 후원금 </div>
                  <span class="reward_value">
                       
                   <c:forEach var="product" items="${selectedProducts}" varStatus="status">
    			<c:if test="${status.index == 0}">
        		<span id="additional_donation">${product.additionalDonation} </span>원
    			</c:if>
    			</c:forEach>
                  </span>
                </div>
                </div>

                  <div class="reward_value_container">
                    <div class="right_aligned">
                      <div>배송비</div>
          
                        <span class="reward_value">
                       
                          <c:forEach var="product" items="${selectedProducts}" varStatus="status">
    					<c:if test="${status.index == 0}">
        				<span id="delivery_charge">${product.deliveryCharge}</span>
    					</c:if>
							</c:forEach>

                          원
                        </span>
               
                    </div>
                  </div>
                  
                  <div class="reward_value_container">
                    <div class="right_aligned value_divide">
                      <div>총 리워드 금액</div>
                      <div>
                        <span class="reward_value">
                          <em class="reward_value_amount1">리워드 금액</em>
                          원
                        </span>
                      </div>
                    </div>
                  </div>
                  
                   <div class="reward_value_container">
                    <div class="right_aligned">
                      <div>할인 포인트 금액</div>
                      <div>
                        <span class="reward_value">
                          <em class="reward_value_money"><span class="point_discount">0</span></em>
                          원
                        </span>
                      </div>
                    </div>
                  </div>
                  
                  
                  
                  
                   <div class="reward_value_container">
                    <div class="right_aligned">
                      <div>총 결제 금액</div>
                      <div>
                        <span class="reward_value">
                          <em class="reward_value_final_money">총 결제 금액</em>
                          원
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
	</div>

            <div class="delivery_wrap">
              <div class="supporter_info">
                <h3 id="supporter_title">서포터</h3>
                  <div id="supporter_name">
                    <div id="supporter_name_default">이름</div>
                    <div id="supporter_name_value">
                    
        					<!-- 첫 번째 요소의 title만 출력 -->
        					${userData.name}
    					
                    </div>
                  </div>
                  <div id="supporter_email">
                    <div id="supporter_email_default">이메일</div>
                    <div id="supporter_email_value" >
                     
        					<!-- 첫 번째 요소의 title만 출력 -->
        					${userData.email}
        					
    					
                    </div>
                  </div>
                  <div id="supporter_tel">
                    <div id="supporter_tel_default">휴대폰 번호</div>
                    <div id="supporter_tel_value">
                    	
        					<!-- 첫 번째 요소의 title만 출력 -->
        					${userData.phoneNumber}
    					
                    </div>
                  </div>
              </div>
              <div class="delivery">
                <label class="radio_option">
                  <input type="radio" name="address_option" value="option1"  > 기존 배송지
                </label>
                <label class="radio_option">
                  <input type="radio" name="address_option" value="option2" checked> 직접입력
                </label >

                <div class="first_radio">
                  <p>최근 배송 목록
                  </p>
                  <p2>사용할 주소를 클릭해 주세요. 죄대 5개까지 저장 가능합니다. </p2>
                <c:choose>
    				<c:when test="${not empty addressList}">
        			<!-- addressList가 비어 있지 않으면 이 블록 실행 -->
        				<c:forEach var="address" items="${addressList}" varStatus="status">
        			
            			<!-- addressList의 각 요소에 대해 반복 작업 -->
            			<label class="option_address">
            				<label class="option_address_choice">
                			<input type="radio" name="delivery_address_radio" value="${address.addrNum }" ${status.index == 0 ? 'checked' : ''} style="display:none;">
                			<div class="address-detail">
                			<div class="address_reciptient">${address.recipient}</div>
                			
    						<div class="address_tel">${address.tel}</div>
    						<span class="address_zipcode">${address.zipcode }</span>
    						<span class="address_addr">${address.addr}</span> &nbsp;<span class="address_addrDetail">${address.addrDetail}</span></div>
    						</label>
    						<div id="address_button">
                			<button type="button" class="address_delete">삭제</button>
                			<button type="button" class="address_update">수정</button>
                			</div>
                			<br />
                		</label>
            			

        				</c:forEach>
    				</c:when>
				</c:choose>

                </div>

                <div class="second_radio">
                  <h3 id="delievery_title">리워드 배송지</h3>
                  <input type="hidden" id="upadate_addrNum" name="upadate_addrNum">
                  <div id="delivery_name">
                    <div id="delivery_name_default">수령인</div>
                    <input type="text" id="delivery_name_value" name="recipient" placeholder="수령인을 입력해주세요">
                  </div>

                  <div id="delivery_tel">
                    <div id="delivery_tel_default">휴대폰 번호</div>
                    <input type="text" id="delivery_tel_value" name="tel" maxlength="13">
                  </div>

                  <div id="address_form">
                    <div id="delivery_address_default">주소</div>
                    <input type="text" id="address_number" name="zipcode" placeholder="우편번호">
                    <button type="button" id="delivery_address_search" onclick="execDaumPostcode()">주소찾기</button>
                    <br>
                    <input type="text" id="delivery_address_detail" name="addr" placeholder="주소">
                    <br>
                    <input type="text" id="delivery_address_value" name="addrDetail" placeholder="상세주소">
                  </div>

                  <div id="delivery_request">
                    <div id="delivery_request_default">배송시 요청사항</div>
                    <input type="text" id="delivery_request_value" name="req" placeholder="ex&#41부재시 경비실에 보관해주세요.">
                    <div id="delivery_request_plus">해당 요구사항은 배송에 관련된 내용만 적어주세요.</div>
                  </div>

				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="/SoolWhale/resources/js/common/address.js"></script>


                </div>
              </div>
            </div>


            <div class="pay_purchase">
              <div class="pay_purchase_title">예약 결제</div>

              <label>
                <input type="radio" name="option" class="paytime" value="danal_delay" checked> 다날 페이 예약 결제<br />
              </label>
              


              <div class="pay_purchase_title">바로 결제</div>
              <label>
                <input type="radio" name="option" class="paytime" value="danal_nodelay"> 다날 페이 결제<br />
              </label>


            </div>
  </form>
            <div class="purchase_caution">
              <div id="purchase_caution_title">
                결제 유의사항
              </div>
              <div id="purchase_caution_content">
                예약 결제의 경우 결제 실행일에 결제자 귀책사유(한도초과, 이용정지 등)로 인하여 결제가 실패할 수 있으니, 결제수단이 유효한지 확인해주세요. <br />
                예약 결제의 경우 1차 결제 실패 시 실패일로부터 3 영업일 동안 재 결제를 실행합니다.<br />
          
                지금 결제를 한 경우에도 프로젝트가 종료되기 전까지 언제든 결제를 취소할 수 있어요.<br />
              </div>
            </div>
         


            <div class="purchase_agree">
              <div class="purchase_agree_title">
                약관 동의
              </div>
              <div class="purchase_agree_content">
                <table>
                  <thead>
                    <tr>
                      <td>
                        <label>
                          <input type="checkbox" id="check_all" />결제 진행 필수 동의 (전체 동의)
                          
                        </label>
                      </td>
                    </tr>
                    
                  </thead>
                  <tbody>
                    <tr>


                      <td>
                        <label>
                          <input type="checkbox" name="check">
                          구매조건, 결제 진행 및 결제 대행 서비스 동의(필수)
                          <div id="check_content">
                            전자금융거래 이용약관 <br />
                            개인정보 수집 및 이용 및 제3자 제공의 대한 동의
                          </div>
                        </label>
                      </td>

                    </tr>
                    <tr>
                      <td>
                        <label>
                          <input type="checkbox" name="check">개인정보 제3자 제공 동의(필수)
                        </label>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <label>
                          <input type="checkbox" name="check">책임 규정에 대한 동의(필수)
                        </label>
                      </td>
                    </tr>

                  </tbody>
                </table>
              </div>
              <div class="center-container">
               <button type="button" id="pay_purchase_final">결제하기</button>
               
              </div>
            </div>
           </div>

        </div>
    </div>


	</body>
</html>