
    // 슬라이드
    $(document).ready(function() {
		
	
        
      var $slider = $('.slider');
      var slickOptions = {
        autoplay: false,
        autoplaySpeed: 1000,
        slidesToShow: 4,
        slidesToScroll: 1,
        responsive: [
          {
            breakpoint: 768,
            settings: {
              slidesToShow: 4,
              arrows: false,
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 1,
              arrows: false,
            }
          }
        ]
      };
      
      $slider.slick(slickOptions);

      

      // 버튼 상태 업데이트 함수
      function updateButtonStates(currentSlide, slideCount) {
        if (currentSlide === 0) {
          $('.slick-prev').attr('disabled', true);
        } else {
          $('.slick-prev').attr('disabled', false);
        }

        if (currentSlide === slideCount - slickOptions.slidesToShow) {
          $('.slick-next').attr('disabled', true);
        } else {
          $('.slick-next').attr('disabled', false);
        }
      }

      $slider.on('afterChange', function(event, slick, currentSlide) {
        updateButtonStates(currentSlide, slick.slideCount);
      });

      $slider.on('init', function(event, slick) {
        updateButtonStates(0, slick.slideCount);
      });
    });
   

    // 베너
    $(document).ready(function() {
      var $banner = $('.banner');
      var slickOptions = {
        autoplay: true,
        autoplaySpeed: 1000,
        slidesToShow: 1,
        slidesToScroll: 1,
        responsive: [
          {
            breakpoint: 768,
            settings: {
              slidesToShow: 3,
              arrows: false,
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 1,
              arrows: false,
            }
          }
        ]
      };

      function updateButtonStates(currentSlide, slideCount) {
        if (currentSlide === 0) {
          $('.slick-prev').attr('disabled', true);
        } else {
          $('.slick-prev').attr('disabled', false);
        }

        if (currentSlide === slideCount - slickOptions.slidesToShow) {
          $('.slick-next').attr('disabled', true);
        } else {
          $('.slick-next').attr('disabled', false);
        }
      }
      
      $banner.slick(slickOptions);

    });





    $(function(){
      $(".fa-regular").click(function(){
        
        $(this).next(".fa-solid").show();
      })

      $(".fa-solid").click(function(){
        $(this).prev(".fa-regular").show();
        $(this).hide();
      })

    })
    
            $(document).ready(function() {
            // 각 하트 아이콘의 상태를 저장하는 객체
            var heartStates = {};

            // 하트 아이콘 초기 상태 설정 (빈 하트)
            $(".likeempty").each(function() {
                var id = $(this).data("id");
                heartStates[id] = false;
                $(this).find(".fa-regular").show();
                $(this).find(".fa-solid").hide();
            });

            // 하트 아이콘 클릭 이벤트 처리
            $(".likeempty").click(function() {
                var id = $(this).data("id");
                var $regularIcon = $(this).find(".fa-regular");
                var $solidIcon = $(this).find(".fa-solid");
                
                if (heartStates[id]) {
                    $regularIcon.show();
                    $solidIcon.hide();
                } else {
                    $regularIcon.hide();
                    $solidIcon.show();
                }

                // 상태 반전
                heartStates[id] = !heartStates[id];
            });
            
            checkAndExecuteDelayedPayment();
        });

