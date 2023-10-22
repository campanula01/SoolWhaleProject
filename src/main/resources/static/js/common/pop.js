$(function() {
    const openModalButton = $("#open_modal_button");
    const closeModalButton = $("#close_modal_button");
    const modal = $("#modal");
    const content = $("#content");
    let modalOpened = false; // 모달이 열려있는 상태인지 여부를 나타내는 변수
  
    function closeModal() {
      $(".modal").fadeOut();
      modal.removeClass("active");
    }

  
    openModalButton.click(function() {
      
        $(".modal").fadeIn();
        modal.addClass("active");
        modalOpened = true;
      
    });
  
    closeModalButton.click(function() {
      closeModal();
    });
  
    $(window).on("click", function(event) {
      if (event.target === modal[0]) {
        closeModal();
      }
    });
  
    $('.toggle_button').click(function() {
      $('.toggle_content').toggle();
    });
  
  
    const checkboxes2 = $('.check_next');
    const nextButton = $('#check_nextpage');
  
    let checkBoxesState = {}; // 체크 박스 상태를 저장할 객체
  
    function updateButtonState() {
      // every() 메서드를 사용하여 모든 체크 박스가 선택되었는지 확인합니다.
      const allChecked = checkboxes2.toArray().every(checkbox => checkbox.checked);
      
      if (allChecked) {
        // 버튼의 disabled 속성을 해제하고, 클래스를 추가하여 색상을 변경합니다.
        nextButton.prop('disabled', false).addClass('active');
      } else {
        // 버튼의 disabled 속성을 활성화하고, 클래스를 제거하여 색상을 원래대로 복원합니다.
        nextButton.prop('disabled', true).removeClass('active');
      }
    }
  // 체크 박스의 변경(체크 또는 언체크)이 일어날 때마다 updateButtonState 함수를 호출합니다.
    checkboxes2.on('change', function(){
      checkBoxesState[this.id] = this.checked;
      updateButtonState();
    });
    
    // 페이지가 로드될 때 최초로 한 번 updateButtonState 함수를 호출하여 초기 상태를 설정합니다.
    updateButtonState();
     
});

  