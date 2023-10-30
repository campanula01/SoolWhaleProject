$(function() {
	updateRadio();


	var phoneNumber = $('#supporter_tel_value').text().trim();

	if (phoneNumber.length == 11) {
		var formattedNumber = phoneNumber.substring(0, 3) + "-" + phoneNumber.substring(3, 7) + "-" + phoneNumber.substring(7, 11);
		$('#supporter_tel_value').text(formattedNumber);
	}



	function calculateTotalAmount() {
		let totalAmount = 0;

		// 각 제품의 금액을 합산합니다.
		$('.product-amount').each(function() {
			totalAmount += parseInt($(this).text(), 10);
		});


		$('.reward_value_amount').text(totalAmount);



		// 배송비를 totalAmount에 추가합니다.
		let additionalDonation = parseInt($("#additional_donation").text(), 10);
		let deliveryCharge = parseInt($('#delivery_charge').text(), 10);

		console.log("additionalDonation" + additionalDonation);
		totalAmount += deliveryCharge + additionalDonation;

		$('.reward_value_amount1').text(totalAmount);
		// 포인트 할인 금액을 totalAmount에서 뺍니다.

		let pointDiscount = parseInt($('.point_discount').text(), 10);
		totalAmount -= pointDiscount;

		return totalAmount;
	}

	$('#point_all').change(function() {
		let pointDiscount;

		if ($(this).prop('checked')) {
			const usablePoint = parseInt($('#usable_point').text());
			let totalAmount = calculateTotalAmount();

			// usablePoint와 totalAmount 중 더 작은 값을 선택
			pointDiscount = Math.min(usablePoint, totalAmount);

			$('#point_input').val(pointDiscount);
			$('.point_discount').text(pointDiscount);
			totalAmount -= pointDiscount;
			console.log(totalAmount);
		} else {
			$('#point_input').val('0');
			$('.point_discount').text('0');
		}

		// 체크박스 상태가 변경될 때마다 총 결제 금액을 갱신합니다.
		const updatedTotalAmount = calculateTotalAmount();
		$('.reward_value_final_money').text(updatedTotalAmount);

	});

	// 페이지 로딩 시 총액을 즉시 계산하여 "총 결제 금액" 부분에 출력합니다.
	const currentTotalAmount = calculateTotalAmount();
	$('.reward_value_final_money').text(currentTotalAmount);


	$(document).on('click', '.address_update, .option_address_choice', function() {


		var selectedAddress = $(this).closest('.option_address');

		$('input[name="address_option"][value="option2"]').prop('checked', true).trigger('change');

		var recipient = selectedAddress.find('.address-detail .address_reciptient').text();
		var tel = selectedAddress.find('.address-detail .address_tel').text();
		var addr = selectedAddress.find('.address-detail .address_addr').text();
		var addrDetail = selectedAddress.find('.address-detail .address_addrDetail').text();
		var zipcode = selectedAddress.find('.address-detail .address_zipcode').text();
		var addrNum = selectedAddress.find('input[name="delivery_address_radio"]').val();

		$('#delivery_name_value').val(recipient);
		$('#delivery_tel_value').val(tel);
		$('#delivery_address_detail').val(addr);
		$('#delivery_address_value').val(addrDetail);
		$('#address_number').val(zipcode);

		$('#upadate_addrNum').val(addrNum);

		updateRadio();
	});




	$(document).on('click', '.address_delete', function() {
		var addrNum = $(this).closest('label.option_address').find('input[name="delivery_address_radio"]').val();
		var addressLabel = $(this).closest('label.option_address');

		$.ajax({
			url: "/SoolWhale/address/" + addrNum,
			type: "DELETE",
			success: function(response) {
				if (response === "SUCCESS") {
					addressLabel.remove();
				} else {
					alert("주소를 삭제하는데 실패했습니다.");
				}
			},
			error: function() {
				alert("서버와의 통신 중 오류가 발생했습니다.");
			}
		});
	});



	// 라디오 버튼의 상태에 따라 label의 클래스를 변경하는 함수
	function updateLabelStyle() {
		$(".radio_option").removeClass("checked-label");
		$(".radio_option input[type='radio']:checked").closest(".radio_option").addClass("checked-label");
	}

	$(".radio_option input[type='radio']").on('change', updateLabelStyle);
	updateLabelStyle();

	$('input[name=address_option]').on('change', updateRadio);

	function updateRadio() {
		if ($('input[name=address_option]:checked').val() === 'option1') {
			$(".second_radio input[type='text']").val("");  // 모든 텍스트 입력 필드 초기화
			$('.first_radio').show();
			$('.second_radio').hide();
		} else {

			$('.first_radio').hide();
			$('.second_radio').show();
		}
	}
	//prop메서드는 요소의 속성값을 가져오거자 설정하는데 사용 요소의 property값을 조작하거나 검사할 때 사용. 
	//체크박스의 체크여부, 라디오 버튼의 선택여부, 입력필드의 비활성화 등.
	// "전체 동의" 체크박스의 상태가 변경될 때
	$("#check_all").click(function() {
		// "전체 동의" 체크박스의 상태에 따라 개별 동의 체크박스들의 상태를 설정
		$("input[name=check]").prop("checked", $(this).is(":checked"));
		updatePayButtonState();
	});

	// 개별 동의 체크박스들의 상태가 변경될 때
	$("input[name=check]").click(function() {
		updatePayButtonState();
	});

	// "결제하기" 버튼 상태를 업데이트하는 함수
	function updatePayButtonState() {
		var total = $("input[name=check]").length;
		var checked = $("input[name=check]:checked").length;

		// 모든 개별 동의 체크박스가 선택되었을 때 "결제하기" 버튼을 활성화
		if (total === checked) {

			$("#check_all").prop("checked", true);
		} else {

			$("#check_all").prop("checked", false);

		}
	}

	// 초기 페이지 로드시 "결제하기" 버튼 상태를 업데이트
	updatePayButtonState();

	$("#delivery_tel_value").on("input", function(e) {
		var nonDigits = /\D/g;
		$(this).val($(this).val().replace(nonDigits, ''));
	});
	$("#delivery_tel_value").on("keyup", function() {
		var value = $(this).val();

		value = value.replace(/-/g, ''); // 기존의 '-'를 모두 제거
		if (value.length > 4 && value.length < 8) {
			value = value.slice(0, 3) + '-' + value.slice(3);
		} else if (value.length >= 8) {
			value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
		}
		$(this).val(value);
	});

	function updateOrInsertAddress(callback) {
		var addrNum = $('#upadate_addrNum').val();
		var recipient = $('#delivery_name_value').val();
		var tel = $('#delivery_tel_value').val();
		var zipcode = $('#address_number').val();
		var addr = $('#delivery_address_detail').val();
		var addrDetail = $('#delivery_address_value').val();
		var req = $('#delivery_request_value').val();

		var requestURL = addrNum ? "/SoolWhale/address/addressUpdate" : "/SoolWhale/address/addressInsert";

		console.log(addrNum);
		$.ajax({
			type: "POST",
			url: requestURL,
			data: {
				addrNum: addrNum,
				recipient: recipient,
				tel: tel,
				zipcode: zipcode,
				addr: addr,
				addrDetail: addrDetail,
				req: req
			},
			success: function(response) {
				if (addrNum) {
					alert("주소가 성공적으로 수정되었습니다!");
				} else {
					alert("주소가 성공적으로 추가되었습니다!");
					// addrNum 값 업데이트
					addrNum = response.addrNum;
				}

				// 콜백 호출
				if (callback) {
					callback(addrNum);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log('Status:', textStatus);
				console.log('Error:', errorThrown);
				console.log('Response:', jqXHR.responseText);
				if (addrNum) {
					alert("주소 수정 중 오류가 발생했습니다.");
					console.log('Status:', textStatus);
					console.log('Error:', errorThrown);
					console.log('Response:', jqXHR.responseText);
				} else {
					alert("주소 추가 중 오류가 발생했습니다.");
					console.log('Status:', textStatus);
					console.log('Error:', errorThrown);
					console.log('Response:', jqXHR.responseText);
				}
			}
		});
	}


	$("#pay_purchase_final").click(function(e) {
		if ($("input[name='address_option']:checked").val() == "option1") {
			Swal.fire({
				icon: 'info',
				text: '사용할 주소를 클릭해주세요.',
				confirmButtonColor: '#00b7d4',
				cutomClass: {
					text: 'pay_purchase_alert',
					container: 'pay_purchase_alert'
				}
			});

		}
		else if ($("input[name='address_option']:checked").val() == "option2") {
			if (!chkData("#delivery_name_value", "수령인 이름을")) {
				e.preventDefault();
				return;

			}
			else if (!chkData("#delivery_tel_value", "휴대폰 번호를")) {
				e.preventDefault();
				return;

			}
			else if (!chkData("#address_number", "우편번호를")) {
				e.preventDefault();
				return;

			}
			else if (!chkData("#delivery_address_detail", "주소를")) {
				e.preventDefault();
				return;

			}
			else if (!chkData("#delivery_address_value", "상세 주소를")) {
				e.preventDefault();
				return;

			}
			else {

				if (!$("#check_all").is(":checked")) {
					e.preventDefault(); // 약관에 동의하지 않은 경우 클릭 이벤트 막기

					Swal.fire({
						icon: 'error',
						text: '약관 동의를 진행해 주세요.',
						confirmButtonColor: '#00b7d4',
						cutomClass: {
							text: 'pay_purchase_alert',
							container: 'pay_purchase_alert'
						}
					});



				} else {

					console.log("requestPay()함수 실행전");
					requestPay();




				}

			}

		}
	});


	var globalBillingKey = "";
	var globalMerchantUid = "";
	let projectNum = $("#projectNum").val();
	console.log("projectNum:" + projectNum);



	function requestPay() {
		alert("1.함수 시작");
		var IMP = window.IMP;
		IMP.init("imp57500886");

		var buyerEmail = $("#supporter_email_value").text().trim();
		var buyerName = $("#supporter_name_value").text().trim();
		var buyerTel = $("#supporter_tel_value").text().trim();
		var consumPrice = $(".reward_value_final_money").text().trim();
		let merchant_uid = 'merchant_' + new Date().getTime();
		let customer_uid = 'customer_' + new Date().getTime();


		let paytime = $("input[name='option']:checked").val();
		console.log(paytime);




		alert("2.설정");
		IMP.request_pay({
			pg: 'danal_tpay.9810030929',
			pay_method: 'card',
			merchant_uid: merchant_uid,
			name: '최초 인증 결제',
			amount: 0,
			customer_uid: customer_uid,
			buyer_email: buyerEmail,
			buyer_name: buyerEmail,
			buyer_tel: buyerTel,

		},function(rsp) {
			alert("3.설정");
			if (rsp.success) {
				console.log("merchant_uid:", rsp.merchant_uid);

				globalBillingKey = rsp.customer_uid;
				globalMerchantUid = rsp.merchant_uid;

				console.log(globalBillingKey);
				console.log(globalMerchantUid);
				
				submitForm();
				
				
				console.log(consumPrice);
				if (paytime == "danal_delay") {

					console.log("danal_delay:" + paytime);
					saveScheduledPayment(rsp.customer_uid, parseInt(consumPrice), rsp.merchant_uid, projectNum);
				} else if (paytime == "danal_nodelay") {
					console.log("danal_nodelay:" + paytime);

					billByKey(rsp.customer_uid, parseInt(consumPrice), rsp.merchant_uid);
				}
			} else {
				alert('빌링키 발급 실패: ' + rsp.error_msg);
			}
		});
	}



	function submitForm() {
		updateOrInsertAddress(function(addrNumFromUpdateOrInsert) {
			let rewards = $(".rewardNum").map(function() {
				return $(this).val();
			}).get();

			let usePoint = $(".point_discount").text();
			let purchaseData = {
				usePoint: usePoint,
				deliveryCharge: $("#delivery_charge").text(),
				addrNum: addrNumFromUpdateOrInsert, // 여기에서 수정된 addrNum 값을 사용
				payAmount: $(".reward_value_final_money").text(),
				reward: rewards,
				addPoint: ($(".reward_value_final_money").text() * 1) / 100,
				additionalDonation: $("#additional_donation").text(),
				billingKey: globalBillingKey,
				merchantUid: globalMerchantUid
			};

			console.log("purchaseData:" + purchaseData);

			let usablePoint = parseInt($("#usable_point").text().replace(/\D/g, ""), 10);
			let pointDiscount = parseInt($(".point_discount").text(), 10);
			let pointPlus = ($(".reward_value_final_money").text() * 1) / 100;

			let pointPlusData = {
				pointSum: usablePoint + pointPlus
			}

			let pointMinusData = {
				pointSum: usablePoint - pointDiscount
			}



			$.ajax({
				url: "/SoolWhale/payment/paymentInsert?projectNum=" + projectNum,
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify(purchaseData),
				success: function(response) {
					alert(response);
					let pointData = usePoint == "0" ? pointPlusData : pointMinusData;

					$.ajax({
						url: "/SoolWhale/payment/pointInsert",
						type: "POST",
						contentType: "application/json",
						data: JSON.stringify(pointData),
						success: function(pointResponse) {
							alert(pointResponse);


							$.ajax({
								url: "/SoolWhale/payment/fundingPayComplete?projectNum=" + projectNum,
								type: "POST",
								contentType: "application/json",
								data: JSON.stringify(purchaseData),
								success: function(redirectUrl) {
									window.location.href = redirectUrl;
								},
								error: function(jqXHR, textStatus, errorThrown) {

									alert("fundingPayComplete Error occurred! Status: " + textStatus + ", Error: " + errorThrown);
								}

							})
						}
					});
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert("Error occurred! Status: " + textStatus + ", Error: " + errorThrown);
				}
			});











		});
	}












	function saveScheduledPayment(customer_uid, amount, merchant_uid, projectNum) {
		$.ajax({
			
			type: "POST",
			url: "/SoolWhale/payment/saveScheduledPayment",
			contentType: "application/json",
			data: JSON.stringify({
				"customer_uid": customer_uid,
				"amount": amount,
				"merchant_uid": merchant_uid,
				"projectNum":projectNum
			}),
			success: function(response) {
				alert("결제 예약 성공");
			},
			error: function(err) {
				alert('결제 예약 중 오류: ' + err.responseText);
			}
		});
	}




	function billByKey(customer_uid, amount, merchant_uid) {
		console.log("Entering billByKey function");
		$.ajax({
			type: "POST",
			url: "/SoolWhale/payment/billByKey",
			contentType: "application/json",
			data: JSON.stringify({
				"customer_uid": customer_uid,
				"amount": amount,
				"merchant_uid": merchant_uid
			}),
			success: function(response) {
				alert("정기결제 성공");


				let returnedMerchantUid = response.merchant_uid;
				console.log("Returned merchant_uid:", returnedMerchantUid);

			},
			error: function(err) {
				alert('Error during billing: ' + err.responseText);
			}
		});
	}








});


