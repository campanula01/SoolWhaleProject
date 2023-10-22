
  
      $(function(){
        $(".fa-regular").click(function(){
          
          $(this).next(".fa-solid").show();
        })
  
        $(".fa-solid").click(function(){
          $(this).prev(".fa-regular").show();
          $(this).hide();
          
        })
  
      })
  
  
      $(document).ready(function(){
        $('.gauge').each(function(){
          //let per_value = $(this).attr(".per");
          //$(this).attr("style","wirth:"+per_value+"%");

          let per_value = $(this).attr("aria-valuenow");
          $(this).attr("style","width:"+per_value+"%");

          // var $this = $(this);
          // var per = $this.attr('per');
          // $this.css('width', per + "%");
        })
      })
