$(function() {

	

	let totalSum = 0;

	$('.price_details').each(function(index) {
		const quantityInput = $(this).find('.quantity_input');
		const totalPriceElement = $(this).find('.total_price');
		const pricePerUnit = parseInt($(this).attr('price-per-unit'));

		function updateTotalPrice() {
			const quantity = parseInt(quantityInput.val());
			const totalPrice = quantity * pricePerUnit;
			const formattedTotalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			totalPriceElement.text(formattedTotalPrice + " 원");
			console.log(totalPrice);
		}

		$(this).find('.quantity_button_decrease').click(function() {
			let currentValue = parseInt(quantityInput.val());
			if (currentValue > 1) {
				quantityInput.val(currentValue - 1);
				updateTotalPrice();
				updateTotalSum();

			}
		});

		$(this).find('.quantity_button_increase').click(function() {
			let currentValue = parseInt(quantityInput.val());
			if (currentValue < 500) {
				quantityInput.val(currentValue + 1);
				updateTotalPrice();
				updateTotalSum();

			}
		});

		quantityInput.change(function() {
			let currentValue = parseInt(quantityInput.val());
			if (isNaN(currentValue) || currentValue < 1) {
				Swal.fire({
					icon: 'info',
					text: '최소 구매 가능 수량은 1개입니다.',
					confirmButtonColor: '#00b7d4',
				});
				quantityInput.val(1);
			} else if (currentValue > 500) {
				Swal.fire({
					icon: 'info',
					text: '최대 구매 가능 수량은 500개입니다.',
					confirmButtonColor: '#00b7d4',
				});
				quantityInput.val(500);
			}
			updateTotalPrice();
			updateTotalSum();
		});

		updateTotalPrice();
		updateTotalSum();
	});


	$('#additional_donation').on('click', function() {
		if ($(this).val() === '0') {
			$(this).val('');
			updateTotalSum();
		}
	});

	//포커스를 잃으면
	$('#additional_donation').on('blur', function() {
		if ($(this).val().trim() === '') {
			$(this).val('0');
			updateTotalSum();
		}
	});

	// 값이 변경될 때마다
	$('#additional_donation').on('keyup', function() {
		// 입력된 값에서 숫자를 제외한 모든 문자 제거
		var value = $(this).val().replace(/[^0-9]/g, "");

		// 수정된 숫자만 포함된 값을 다시 설정
		$(this).val(value);

		updateTotalSum();
	});

	function updateTotalSum() {
		let totalSum = 0;

		$('.price_details').each(function(index) {
			const quantity = parseInt($(this).find('.quantity_input').val());
			const pricePerUnit = parseInt($(this).attr('price-per-unit'));
			totalSum += quantity * pricePerUnit;
		});

		// 후원금, ||0 논리연산자 or 반환값이 0이거나 빈값일 때 0
		const additionalDonation = parseInt($("#additional_donation").val() || 0);
		totalSum += additionalDonation;

		const formattedTotalSum = totalSum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$('#final_sum_price_detail').text(formattedTotalSum);
	}

	// 초기 전체 합계 업데이트
	updateTotalSum();

	$(".show_content_checkbox.product").each(function() {
		const checkbox = $(this);
		const rewardValue = checkbox.data("reward"); // 체크박스의 value 값 가져오기

		const targetId = checkbox.attr("data-target");
		const targetContent = $('#' + targetId);
		const quantityInput = targetContent.find('.quantity_input');
		const totalPriceElement = targetContent.find('.total_price');
		const pricePerUnit = parseInt(targetContent.attr('price-per-unit'));
		const productName = targetContent.find('.content_reward').text();
		const formattedPricePerUnit = pricePerUnit.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

		const selected = $("#selectedReward").val();

		console.log(rewardValue);
		console.log("selected" + selected);

		// 체크박스 상태가 변경될 때 실행되는 이벤트 핸들러 추가
		checkbox.on("change", function() {
			if ($(this).prop('checked')) {
				targetContent.css('display', 'block');
				quantityInput.val(1);

				totalPriceElement.text(formattedPricePerUnit + " 원");
				updateTotalSum();
				console.log(pricePerUnit);
				console.log(productName);

			} else {
				targetContent.css('display', 'none');
				quantityInput.val(0);
				totalPriceElement.text("0 원");
				updateTotalSum();
			}
		});

		// 체크박스의 값이 selectedReward와 같으면
		if (rewardValue == selected) {
			checkbox.prop('checked', true); // 체크박스를 체크
			checkbox.trigger('change'); // 체크 이벤트 트리거
		}
	});

	//x버튼
	$('.close_button_content1').click(function() {
		// 해당 버튼의 data-target 값을 가져옴
		var dataTarget = $(this).data('target');

		// data-target 값을 가진 체크박스를 찾아서 체크를 해제
		var checkbox = $('.show_content_checkbox[data-target="' + dataTarget + '"]');

		//선택된 요소가 존재할 때만 작동
		if (checkbox.length > 0) {
			checkbox.prop('checked', false);
			// 해당 요소의 상태를 업데이트
			var targetContent = $('#' + dataTarget);
			var quantityInput = targetContent.find('.quantity_input');
			var totalPriceElement = targetContent.find('.total_price');

			targetContent.css('display', 'none');
			quantityInput.val(0);
			totalPriceElement.text("0 원");

			// 전체 합계 업데이트
			updateTotalSum();
		}
	});


	const openModalButton = $("#open_modal_button");
	const closeModalButton = $("#close_modal_button");
	const modal = $("#modal");
	const content = $("#content");
	const checkboxes = $("#reward_content_box input[type='checkbox']");
	let modalOpened = false; // 모달이 열려있는 상태인지 여부를 나타내는 변수

	function closeModal() {
		$(".modal").fadeOut();
		modal.removeClass("active");

		// 모달을 닫을 때 체크 박스의 상태를 초기화합니다.
		if (modalOpened) {
			checkboxes2.prop("checked", false);
			// 모달을 닫을 때 checkBoxesState를 초기화합니다.
			checkBoxesState = {};
			// 체크 박스 상태 초기화 후 체크 박스 상태에 따라 버튼 상태를 업데이트합니다.
			checkboxes2.trigger("change");
		}
		modalOpened = false;
	}

	openModalButton.click(function() {
		const anyCheckboxChecked = checkboxes.is(":checked");

		if (!anyCheckboxChecked) {
			Swal.fire({
				icon: 'error',
				text: '리워드가 하나도 선택되어있지 않습니다.',
				confirmButtonColor: '#00b7d4',
			});
		} else {
			$(".modal").fadeIn();
			modal.addClass("active");
			modalOpened = true;
		}
	});

	closeModalButton.click(function() {
		closeModal();
	});

	$(window).on("click", function(event) {
		if (event.target === modal[0]) {
			closeModal();
		}
	});

	$('.toggle_button').click(function() {
		$('.toggle_content').toggle();
	});


	const checkboxes2 = $('.check_next');
	const nextButton = $('#check_nextpage');

	let checkBoxesState = {}; // 체크 박스 상태를 저장할 객체

	function updateButtonState() {
		// every() 메서드를 사용하여 모든 체크 박스가 선택되었는지 확인합니다.
		const allChecked = checkboxes2.toArray().every(checkbox => checkbox.checked);

		if (allChecked) {
			// 버튼의 disabled 속성을 해제하고, 클래스를 추가하여 색상을 변경합니다.
			nextButton.prop('disabled', false).addClass('active');
		} else {
			// 버튼의 disabled 속성을 활성화하고, 클래스를 제거하여 색상을 원래대로 복원합니다.
			nextButton.prop('disabled', true).removeClass('active');
		}
	}
	// 체크 박스의 변경(체크 또는 언체크)이 일어날 때마다 updateButtonState 함수를 호출합니다.
	checkboxes2.on('change', function() {
		checkBoxesState[this.id] = this.checked;
		updateButtonState();
	});

	// 페이지가 로드될 때 최초로 한 번 updateButtonState 함수를 호출하여 초기 상태를 설정합니다.
	updateButtonState();



	// "다음 페이지로 이동" 버튼 클릭 이벤트 처리
	$("#check_nextpage").click(function() {
		const selectedProducts = [];

		// 제품 정보 가져오기
		$('.show_content_checkbox:checked').each(function(index) {
			const targetId = $(this).attr('data-target');
			const targetContent = $('#' + targetId);
			const pricePerUnit = parseInt(targetContent.attr('price-per-unit'), 10);
			const productName = targetContent.find('.content_reward').text();
			const quantity = parseInt(targetContent.find('.quantity_input').val(), 10);
			const amount = pricePerUnit * quantity;
			const rewardNum = targetContent.find('#rewardNum').val();
			const projectNum = targetContent.find('#projectNum').val();
			const additionalDonation = parseInt($("#additional_donation").val() || 0);


			// rewardDesc 값을 가져오기
			const rewardDesc = $(this).parent().find('.reward_item_description').first().text().trim();

			// 배송비 가져오기
			const deliveryChargeElem = $(this).parent().find('.reward_delivery > span').text().trim();
			const deliveryCharge = deliveryChargeElem.includes('3,000원') ? 3000 : 0;

			// reward.title 값 가져오기
			const rewardTitle = $(".purchase_title > div").text();

			// final_sum_price_detail 값을 총합으로 계산
			let finalSumPriceDetail = $("#final_sum_price_detail").val();



			selectedProducts.push({
				name: productName,
				quantity: quantity,
				pricePerUnit: pricePerUnit,
				amount: amount,
				deliveryCharge: deliveryCharge,
				rewardTitle: rewardTitle,
				rewardDesc: rewardDesc, // 여기에 추가
				finalSumPriceDetail: finalSumPriceDetail,
				rewardNum: rewardNum,
				projectNum: projectNum,

				additionalDonation: additionalDonation
			});

			console.log(selectedProducts);

		});
		$.ajax({
			type: "POST",
			url: "/SoolWhale/payment/rewardArray",
			contentType: "application/json",
			data: JSON.stringify(selectedProducts),
			success: function(response) {
				let projectNum = $("#projectNum").val();

				console.log(projectNum);

				window.location.href = response + "?projectNum=" + projectNum;  // 응답받은 URL로 페이지 이동
			},
			error: function(xhr, status, error) {
				console.error("AJAX Error:", status, error);
			}
		});
	});


var endDateStr = $("#endDate").val();
	var day = parseInt(endDateStr.split("월")[1].split("일")[0].trim(), 10);

	let year1 = parseInt($("#yearInput").val(), 10);
	let year2 = parseInt($("#yearInput").val(), 10);
	let month1 = parseInt($("#monthInput").val(), 10);
	let month2 = parseInt($("#monthInput").val(), 10);

	// 월에 2를 더합니다.
	month1 += 1;
	month2 += 3;

	// 월이 12보다 크면 연도를 증가시키고 월을 1로 초기화합니다.
	if (month1 > 12) {
		year1 += 1;
		month1 -= 12;
	}

	if (month2 > 12) {
		year2 += 1;
		month2 -= 12;
	}

	const deliveryText = `${year1}년 ${month1}월 `; // 이 부분에서 payment.endDate는 적절한 방법으로 가져와야 합니다.
	const deliveryText2 = `${year2}년 ${month2}월 `; // 이 부분에서 payment.endDate는 적절한 방법으로 가져와야 합니다.
	$(".deliveryDate").text(deliveryText);
	$("#deliveryDelayDate").text(deliveryText2);


	var period;
	if (day <= 10) {
		period = "초";
	} else if (day <= 20) {
		period = "중순";
	} else {
		period = "말";
	}

	$(".periodPlace").text(period);





});
