
function billByKey(customer_uid, amount, merchant_uid) {
    console.log("Entering billByKey function");
    $.ajax({
        type: "POST",
        url: "/payment/billByKey",
        contentType: "application/json",
        data: JSON.stringify({
            "customer_uid": customer_uid,
            "amount": amount,
            "merchant_uid": merchant_uid
        }),
        success: function(response) {
            alert("정기결제 성공");
        },
        error: function(err) {
            alert('Error during billing: ' + err.responseText);
        }
    });
}

function checkAndExecuteDelayedPayment() {
    var data = JSON.parse(localStorage.getItem('delayedPaymentData'));

    if (data && new Date().getTime() >= data.timestamp) {
        billByKey(data.customer_uid, data.amount, data.merchant_uid);
        localStorage.removeItem('delayedPaymentData');  // 결제 후 데이터 삭제
    }
}

// 페이지 로딩 시 지연된 결제가 있는지 확인
checkAndExecuteDelayedPayment();
