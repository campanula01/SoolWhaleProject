$(function() {



	$(".goDetail").click(function() {
	
         var merchantUid = $(this).attr("data-order-num");
       var form = $("#detailForm_" + merchantUid);
        form.attr("action",  "/SoolWhale/payment/paymentListDes");
        form.submit();
		
		
		

	})

	$(".reprise_btn").click(function(e) {
		e.preventDefault();

		let paymentRow = $(this).closest('tr');
		let paymentNum = $(this).closest('tr').data('num');
		console.log(paymentNum);

		let merchantUid = $(this).closest('form').find('.merchantUid').val();
		console.log(merchantUid);

		const sts = $(this).closest("form").find(".sts").val();
		console.log(sts);

		if (sts == "종료") {

			Swal.fire({
				icon: 'error',
				text: '환불 가능한 기간이 지났습니다.',
				confirmButtonColor: '#00b7d4',
				cutomClass: {
					text: 'pay_purchase_alert',
					container: 'pay_purchase_alert'
				}
			});
		} else {

			var confirmed = confirm("정말 환불하시겠습니까?")

			if (confirmed) {
				$.ajax({
					type: "POST",
					url: "/SoolWhale/payment/cancel",
					data: JSON.stringify({ merchantUid: merchantUid }), // Convert the data object to a JSON string
					contentType: "application/json",  // Specify the type of data you're sending
					dataType: "json",  // Specify the type of data you're expecting in return
					success: function(response) {
						console.log("Success:", response);
						// Additional success logic here if needed
						paymentRow.remove();
					},
					error: function(error) {
						console.error("Error:", error);
						// Handle errors here
					}
				});
			}


		}


	});

});