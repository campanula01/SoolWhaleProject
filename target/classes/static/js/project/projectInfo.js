$(function() {
	//저장후 다음 클릭했을때 처리
	$("#next_funding_plan_btn").click(function() {
		if (!chkData("#makerName", "메이커 이름을")) return;
		else if (!chkData("#makerDesc", "메이커 소개를")) return;
		else {
			if ($("#profilImg").val() != "") {
				if (!chkFile($("#profilImg"))) return;
			} $("#project_info_form").attr({
				method: "post",
				enctype: "multipart/form-data",
				action: "/SoolWhale/project/projectInfoUpdate"
			})
			$("#project_info_form").submit();

		}
	})

	$("#exit_button").click(function() {
		window.location.href = "/SoolWhale/project/projectList";
	});
	
	/*
	$("#prev_maker_info_btn").click(function() {
		$("#project_info_form").attr({
			method: "post",
			action: "/project/makerInfoUpdateBack"
		})
		$("#project_info_form").submit();
	});
*/

})