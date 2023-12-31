<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insert title here</title>
     <script src="/SoolWhale/resources/js/common/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>


	
    <script src="/SoolWhale/resources/js/common/delayPayment.js"></script>
</head>
<body>
  <script type="text/javascript">
 $(function() {
	    var naverLogin = new naver.LoginWithNaverId({
	        clientId: "hunJ26EH0p6NJfI8aHRJ",
	        callbackUrl: "http://localhost:8080/member/callback",
	        isPopup: false,
	        callbackHandle: true
	    });
	    naverLogin.init();
	 
	    naverLogin.getLoginStatus(function (status) {
	        if (status) {
	            var email = naverLogin.user.getEmail();
	            var gender = naverLogin.user.getGender();
	            var name = naverLogin.user.getName();
	            var nickName = naverLogin.user.getNickName();
	 
	            $.ajax({
	                type: 'post',
	                url: 'naverSave',
	                data: { 'n_email': email, 'n_gender': gender, 'n_name': name, 'n_nickName': nickName },
	                dataType: 'text',
	                success: function(result) {
	                    if(result == 'ok') {
	                        console.log('성공')
	                        location.replace("http://localhost:8080") 
	                    } else if(result == 'no') {
	                        console.log('실패')
	                        location.replace("http://localhost:8080/member/login")
	                    }
	                },
	                error: function(result) {
	                    console.log('오류 발생')
	                }
	            })
	        } else {
	            console.log("callback 처리에 실패하였습니다.");
	        }
	    });
	});
</script>

</body>
</html>
