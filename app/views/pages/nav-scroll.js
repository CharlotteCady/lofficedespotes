  $(document).ready(function() {
    // navbar transition jQuery script
    $(window).scroll(function(e){
      if ($(this).scrollTop() > 50) {
        $(".navbar-wagon").css({
          "background" : "black",
        });
      }
        $(".navbar-wagon").css({
          "background": "transparent",
        });
      }
    });
  });