function chkData(item, msg) {
	if ($(item).val().replace(/\s/g, "") == "") {
		alert(msg + " 입력해 주세요.");
		$(item).val("");
		$(item).focus();
		return false
	} else {
		return true;
	}
}
//formCheck
function checkPassword(){	
	var idx = $('input[name=idx]').val();
	var password = $('input[name=password]').val();

	$.ajax({
		type: 'GET',
		url: '/SoolWhale/board/delete/getPassword',
		data : {idx,password},
		success: function(result) {
			if(result.password == password){
				$('#submiBtn').attr('disabled',false);
			}
			else{
				alert("비밀번호가 일치하지않습니다");
			}
		}
		,
		error: function(result) {
		},
		complete: function() {
		}

	})
}

/**함수명: chkFile(파일명 객체)
 * 설명: 이미지 파일 여부를 확인하기 위해 확장자 확인 함수.
 * if(!chkFile($("#file"))) return;
 */
function chkFile(item){
	/**참고 사항 
	 * jQuery.inArray(찾을 값, 검색 대상의 배열): 배열내의 값을 찾아서 인덱스를 반환(요소가 없을 경우-1반환)
	 * 타입 비교해야 한다. excel을 jpg로 고치면 넣어 가기 때문에**/

	 let ext = item.val().split('.').pop().toLowerCase();
	 if(jQuery.inArray(ext, ['gif', 'png', 'jpg'])==-1){
		 alert('gif, png, jpg 파일만 업로드 할 수 있습니다.');
		 item.val("");
		 return false;
	 }else {
		 return true;
	 }
}