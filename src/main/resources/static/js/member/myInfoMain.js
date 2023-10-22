
  
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
           let per_value = $(this).attr("aria-valuenow");
          $(this).attr("style","width:"+per_value+"%");
  
        })
      })