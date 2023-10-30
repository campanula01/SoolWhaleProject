$(function() {

	//저장후 다음 클릭했을때 처리
	$("#next_reward_insert_btn").click(function() {
		if (!chkData("#targetAmount", "목표금액을")) return;
		else if ($("#startDate").val() === "") {
			alert("시작날짜를 입력해주세요.");
		} else if ($("#endDate").val() === "") {
			alert("종료날짜를 입력해주세요.");
		} else {
			// 시작 날짜와 종료 날짜를 Date 객체로 변환
			var startDate = new Date($("#startDate").val());
			var endDate = new Date($("#endDate").val());

			// 현재 날짜를 가져오기
			var currentDate = new Date();

			// 날짜가 지났는지 비교
			if (startDate <= currentDate || endDate <= currentDate) {
				alert("시작 날짜 또는 종료 날짜가 이미 지났습니다.");
			} else {
				$("#funding_plan_form").attr({
					method: "post",
					action: "/SoolWhale/project/fundingPlanUpdate"
				});
				$("#funding_plan_form").submit();
			}
		}
	})




	// 시작 날짜, 종료 날짜, 시작 시간을 가져와서 처리
	$('#startDate, #endDate, #start_time').on('change', function() {
		var startDate = new Date($('#startDate').val());
		var endDate = new Date($('#endDate').val());


		// 날짜 차이 계산
		var timeDiff = endDate - startDate;
		var daysDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24));

		// 결과를 .funding_period 요소에 표시
		if (daysDiff > 0) {
			$('.funding_period').text(daysDiff + '일');
		} else { $('.funding_period').text("") }
	});

	// 금액 입력란 변경 이벤트 처리
	$('.funding_target_amount_input').on('input', function() {
		var inputAmount = parseFloat($(this).val());

		if (!isNaN(inputAmount)) {
			// 입력된 금액에서 3% 제외한 금액 계산
			var realAmount = inputAmount * 0.97;
			$('.funding_real_amount').text(realAmount); // 소수점 두 자리까지 표시

			// 3% 수수료 계산
			var paymentFee = inputAmount * 0.03;
			$('.funding_payment_fee').text(paymentFee); // 소수점 두 자리까지 표시
		} else {
			// 잘못된 입력 또는 빈 입력인 경우 요소를 비웁니다.
			$('.funding_real_amount, .funding_payment_fee').text('');
		}
	});

	$("#exit_button").click(function() {
		window.location.href = "/SoolWhale/project/projectList";
	});
	
	$("#prev_project_info_btn").click(function() {
		$("#funding_plan_form").attr({
			method: "post",
			action: "/SoolWhale/project/projectInfoUpdateBack"
		})
		$("#funding_plan_form").submit();
	});

})