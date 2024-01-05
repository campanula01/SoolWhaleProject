



$(document).ready(function() {
	
	
	  var targetAmount = parseInt($("#targetAmount").text().replace(/,/g, ''));
    var totalAmount = parseInt($('.price').text().replace(/,/g, ''));
    console.log(targetAmount);
    console.log(totalAmount);

    // 퍼센티지 계산
   
    
    if(totalAmount==0||isNaN(totalAmount)){
      percentage = 0;
   }else{ 
      
      var percentage = (totalAmount / targetAmount) * 100;
         // 소수점 없이 반올림
       percentage = Math.round(percentage);
   }

 

    // 결과를 percent 요소에 출력
    $("#percent").text(percentage + "%");

    
    


	var isUserLoggedIn = true; // 로그인 상태를 저장하는 전역 변수    
	var heartStates = {};

	$.ajax({
		type: "POST",
		url: "/SoolWhale/supporter/likeStatus",
		data: $("#detailData").serialize(),
		success: function(response) {
			console.log("Response from likeStatus:", response);

			if (response === 3) {
				isUserLoggedIn = false; // 로그인하지 않은 상태
			}

			$(".likeempty").each(function() {
				var id = $(this).data("id");
				if (response === 1 && isUserLoggedIn) { // 관심 프로젝트에 추가됨
					heartStates[id] = true;
					$(this).find(".far").hide();
					$(this).find(".fas").show();
				} else {
					heartStates[id] = false;
					$(this).find(".fas").hide();
					$(this).find(".far").show();
				}
			});
			attachHeartClickEvent();
		},
		error: function(xhr, status, error) {
			console.error("AJAX Error:", status, error);
		}
	});

	function attachHeartClickEvent() {
		$(".likeempty").off("click").click(function(event) {
			event.preventDefault();

			if (!isUserLoggedIn) {
				alert("로그인이 필요합니다.");
				window.location.href = "/SoolWhale/member/login";
				return;
			}

			var id = $(this).data("id");
			var $regularIcon = $(this).find(".far");
			var $solidIcon = $(this).find(".fas");

			if (heartStates[id]) {
				$regularIcon.show();
				$solidIcon.hide();

				$.ajax({
					type: "POST",
					url: "/SoolWhale/supporter/likeDelete",
					data: $("#detailData").serialize(),
					success: function(response) {
						alert("관심프로젝트에서 삭제되었습니다!");
					},
					error: function(xhr, status, error) {
						console.error("AJAX Error:", status, error);
					}
				});
			} else {
				$regularIcon.hide();
				$solidIcon.show();

				$.ajax({
					type: "POST",
					url: "/SoolWhale/supporter/likeInsert",
					data: $("#detailData").serialize(),
					success: function(response) {
						alert("관심프로젝트에 추가되었습니다!");
					},
					error: function(xhr, status, error) {
						console.error("AJAX Error:", status, error);
					}
				});
			}

			heartStates[id] = !heartStates[id];
		});
	}






	$(".reward-option").click(function() {
		let rewardValue = $(this).attr("data-reward");
		const projectNum = $("#projectNum").val();
		console.log(projectNum);
		window.location.href = `/SoolWhale/reward/rewardList?rewardValue=${rewardValue}&projectNum=${projectNum}`;
	});
	const totalPrice = $(".price").text();
	console.log("totalPrice" + totalPrice);
	const formattedTotalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

	$(".price").text(formattedTotalPrice);



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

	// 새로운 값을 해당 배송기간 위치에 표시합니다.
	const deliveryText = `${year1}년 ${month1}월 `; // 이 부분에서 payment.endDate는 적절한 방법으로 가져와야 합니다.
	const deliveryText2 = `${year2}년 ${month2}월 `; // 이 부분에서 payment.endDate는 적절한 방법으로 가져와야 합니다.
	$(".deliveryDate").text(deliveryText);
	$("#deliveryDelayDate").text(deliveryText2);



	var endDateStr = $("#endDate").val(); // 이 부분을 실제로 사용하려면 ${projectDetail.endDate}로 변경해야 합니다.
	console.log(endDateStr);
	var year = parseInt(endDateStr.split("년")[0].trim(), 10);
	var month = parseInt(endDateStr.split("년")[1].split("월")[0].trim(), 10) - 1; // JavaScript의 month는 0부터 시작하므로 -1을 해줍니다.
	var day = parseInt(endDateStr.split("월")[1].split("일")[0].trim(), 10);

	var endDate = new Date(year, month, day);
	endDate.setDate(endDate.getDate() + 1); // 1일을 추가합니다.

	// 다시 "yyyy년 MM월 dd일" 형식의 문자열로 변환합니다.
	var newEndDate = endDate.getFullYear() + "년 " + (endDate.getMonth() + 1) + "월 " + endDate.getDate() + "일";
	var DateDay = endDate.getDate() + "일"
	console.log(newEndDate); // 새로운 날짜를 콘솔에 출력해봅니다.

	$("#payDate").text(newEndDate);
	$("#DateDay").text(DateDay);

	var period;
	if (day <= 10) {
		period = "초";
	} else if (day <= 20) {
		period = "중순";
	} else {
		period = "말";
	}

	$(".periodPlace").text(period);




	$(".purchase-button").click(function() {
		let rewardValue = $(this).attr("data-reward");
		const projectNum = $("#projectNum").val();
		if (rewardValue = null) {
			rewardValue = "null"
		}
		console.log(projectNum);
		console.log(newEndDate);
		window.location.href = `/SoolWhale/reward/rewardList?rewardValue=${rewardValue}&projectNum=${projectNum}`;
	})


});