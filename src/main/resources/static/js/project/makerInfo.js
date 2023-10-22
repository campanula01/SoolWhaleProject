$(function(){
     
     /* 첨부파일추가 버튼 클릭 시 처리 이벤트 */
	$(document).on("click", "#addFile", function(){ 
    var fileIndex = $('input[type="file"]').length-2; 
                
    var addData = '<div class="row">' ;

    addData += '        <input type="file" name="images[0].files['+ fileIndex +']"/>';
    addData += '        <span class="closeBtn">&times;</span></div>'

    $('.table tr:nth-child(1) td:eq(0)').attr("rowspan",fileIndex+1)
    $('.table tr:nth-child(1) td:eq(1)').append(addData);
});
				
	$(document).on("click", ".closeBtn", function(){
		var fileIndex = $('input[type="file"]').length; 
		$('.table tr:nth-child(1) td:eq(0)').attr("rowspan",1);
		$(this).parents("div.row").remove();
		$("div.row .col-md-11 input[type='file']").each(function(index){
			console.log(fileIndex + " / " + index);
			$(this).attr("name", "images[0].files["+ index +"]");
		})
	});	
     
     
     //저장후 다음 클릭했을때 처리
     $("#next_project_info_btn").click(function(){
		 if(!chkData("#title", "프로젝트 제목을")) return;
		 else if(!chkData("#projectDesc", "프로젝트 요약을")) return;
		 else {
			 if($("#firstImg").val()!=""){
				 if(!chkFile($("#firstImg"))) return;
			 }$("#maker_info_form").attr({
				 method:"post",
				 enctype:"multipart/form-data",
				 action:"/project/makerInfoUpdate"
			 })
			 $("#maker_info_form").submit();
			 
		 }
	 })
	 
	 $("#exit_button").click(function() {
            window.location.href = "/project/projectList";
        });
	 
})