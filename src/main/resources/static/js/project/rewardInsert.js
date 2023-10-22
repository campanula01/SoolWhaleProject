$(function() {
	//입력완료 클릭했을때 처리
	$("#project_complete_btn").click(function() {
		$("#reward_insert_form").attr({
			method: "post",
			action: "/reward/successInsert"
		})
		$("#reward_insert_form").submit();
	})
	// 리워드 삭제 버튼 클릭 시 해당 리워드 정보 삭제
	$(".delete_reward_btn").click(function() {
		var $clickedButton = $(this);
		var rewardId = $clickedButton.data("reward-id"); // 리워드 ID를 가져옵니다.

		// Ajax를 이용하여 리워드 삭제 요청을 서버에 보냅니다.
		$.ajax({
			type: "POST",
			url: "/reward/deleteReward",
			data: {
				rewardId: rewardId, // 리워드 ID를 전달합니다.
			},
			success: function(data) {
				if (data.success) {

					// 삭제가 성공한 경우, 화면에서 해당 리워드 정보를 삭제합니다.
					$clickedButton.closest(".wrap_reward_list").remove(); // 상위 요소 삭제
					alert(data.message);
				} else {
					alert(data.message);
				}
			},
			error: function() {
				alert("서버와 통신 중 오류가 발생했습니다.");
			},
		});
	});

	// 저장 클릭했을때 처리
	$("#reward_insert_btn").click(function() {
		var amountInput = $("#amount");
        var amountCheck = amountInput.val();
        
		if (!chkData("#rewardName", "리워드 이름을")) return;
		else if (!chkData("#rewardDesc", "리워드 소개를")) return;
		else if (!chkData("#amount", "리워드 금액을")) return;
		else if (!/^\d+$/.test(amountCheck)){
			 alert('숫자만 입력해주세요.');
		}
		else {
			$("#reward_list").css("display", "none");
			// 리워드 정보를 폼으로부터 가져옴
			var rewardName = $("#rewardName").val();
			var rewardDesc = $("#rewardDesc").val();
			var amount = $("#amount").val();
			var deliveryCharge = $("input[name=deliveryCharge]:checked").val(); // 선택된 라디오 버튼의 값을 가져옴
			var projectNum = $("#projectNum").val();

			// Ajax를 이용하여 리워드 정보를 서버에 전송
			$.ajax({
				type: "POST",
				url: "/reward/rewardInsert",
				data: {
					rewardName: rewardName,
					rewardDesc: rewardDesc,
					amount: amount,
					deliveryCharge: deliveryCharge,
					projectNum: projectNum,
				},
				success: function(data) {
					if (data) {
						// 기존 리워드 리스트 삭제
						$(".wrap_reward_list").remove();

						// 저장 성공한 경우, 리워드 정보를 화면에 추가
						var rewardView = $(".reward_view");

						for (var i = 0; i < data.length; i++) {
							var reward = data[i];
							var rewardItem = $("<div class='wrap_reward_list'>");
							rewardItem.append("<div>리워드 이름: " + reward.rewardName + "</div>");
							rewardItem.append("<div>리워드 소개: " + reward.rewardDesc + "</div>");
							rewardItem.append("<div>리워드 금액: " + reward.amount + "</div>");
							rewardItem.append("<div>배송비 유무: " + reward.deliveryCharge + "</div>");

							// 삭제 버튼 추가
							var deleteButton = $("<button class='delete_reward_btn' data-reward-id='" + reward.reward + "'>삭제</button>");
							rewardItem.append(deleteButton);



							rewardView.append(rewardItem); // 리워드 정보를 추가
						}

						// 입력 폼 초기화
						$("#rewardName").val("");
						$("#rewardDesc").val("");
						$("#amount").val("");

						// 리워드 삭제 버튼 클릭 시 해당 리워드 정보 삭제
						$(".delete_reward_btn").click(function() {
							var $clickedButton = $(this);
							var rewardId = $clickedButton.data("reward-id"); // 리워드 ID를 가져옵니다.

							// Ajax를 이용하여 리워드 삭제 요청을 서버에 보냅니다.
							$.ajax({
								type: "POST",
								url: "/reward/deleteReward",
								data: {
									rewardId: rewardId, // 리워드 ID를 전달합니다.
								},
								success: function(data) {
									if (data.success) {
										// 삭제가 성공한 경우, 화면에서 해당 리워드 정보를 삭제합니다.
										$clickedButton.closest(".wrap_reward_list").remove(); // 상위 요소 삭제
										alert(data.message);
									} else {
										alert(data.message);
									}
								},
								error: function() {
									alert("서버와 통신 중 오류가 발생했습니다.");
								},
							});
						});
					} else {
						alert("리워드 정보 저장에 실패했습니다.");
					}
				},
				error: function() {
					alert("서버와 통신 중 오류가 발생했습니다.");
				},
			});
		}
	});

	$("#exit_button").click(function() {
		window.location.href = "/project/projectList";
	});

	$("#prev_funding_plan_btn").click(function() {
		$("#reward_insert_form").attr({
			method: "post",
			action: "/project/fundingPlanUpdateBack"
		})
		$("#reward_insert_form").submit();
	});

})