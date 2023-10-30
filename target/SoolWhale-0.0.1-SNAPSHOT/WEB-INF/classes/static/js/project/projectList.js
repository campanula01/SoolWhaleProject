$(function() {
	
	$("#newProjectInsert").click(function() {
        window.location.href = "/SoolWhale/project/newProjectInsertView";
    });
	
	$(".projectUpdateBtn").click(function() {
		var projectNum = $(this).data("project-num");
		var form = $("#projectForm_" + projectNum);
		var projectStatus = form.find("input[name='stsVal']").val();
		
		if (projectStatus == '진행중') {
        	alert("펀딩 진행 중에는 수정이 불가능합니다.");
    	} else if(projectStatus =='종료'){
			alert("종료된 프로젝트는 수정이 불가능합니다.");
		} else {
        	form.attr("action", "/SoolWhale/project/projectUpdate");
        	form.submit();
    	}
	});

	$(".projectDeleteBtn").click(function() {
		var confirmation = confirm("삭제하시겠습니까?");

		if (confirmation) {
			var projectNum = $(this).data("project-num");
			var form = $("#projectForm_" + projectNum);
			var projectStatus = form.find("input[name='stsVal']").val();
			
			if (projectStatus == '진행중') {
            	alert("펀딩 진행 중에는 삭제가 불가능합니다.");
        	}else if(projectStatus =='종료'){
				alert("종료된 프로젝트는 삭제가 불가능합니다.");
			} else {
            	form.attr("action", "/SoolWhale/project/projectDelete");
            	form.submit();
        	}
		} else {
		}
	});

	$(".project_status_all").click(function() {
		window.location.href = "/SoolWhale/project/projectList";
	})

	$(".project_status_writing, .project_status_reviewing, .project_status_accept, .project_status_refuse, .project_status_openWaiting, .project_status_ongoing, .project_status_end").on("click", function() {
		var sts = $(this).val();
		window.location.href = "/SoolWhale/project/projectList?sts=" + sts;
	});
	
	
	var stsValue = getUrlParameter("sts");
    // sts 값이 존재하는 경우 해당 버튼에 클래스 추가
    if (stsValue === '') {
        $(".project_status_all").addClass("project_status_button_active");
    } else if (stsValue === '작성중') {
        $(".project_status_writing").addClass("project_status_button_active");
    } else if (stsValue === '심사중') {
        $(".project_status_reviewing").addClass("project_status_button_active");
    } else if (stsValue === '승인') {
        $(".project_status_accept").addClass("project_status_button_active");
    } else if (stsValue === '반려') {
        $(".project_status_refuse").addClass("project_status_button_active");
    } else if (stsValue === '공개예정') {
        $(".project_status_openWaiting").addClass("project_status_button_active");
    } else if (stsValue === '진행중') {
        $(".project_status_ongoing").addClass("project_status_button_active");
    } else if (stsValue === '종료') {
        $(".project_status_end").addClass("project_status_button_active");
    }

    // URL에서 쿼리 매개변수 값을 가져오는 함수
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }


})