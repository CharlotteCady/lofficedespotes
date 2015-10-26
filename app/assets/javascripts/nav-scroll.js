  $(document).ready(function() {
    // navbar transition jQuery script

    $(window).scroll(function(e){
      if ($(this).scrollTop() > 50) {
        $(".navbar-wagon").css({
          "background" : "black",
          // "background": "rgba(0, 0, 0, 0.7)",
          // "box-shadow": "0 0 2px black"
        });
      }
      else {
        $(".navbar-wagon").css({
          "background": "transparent",
          // "box-shadow": "0 0 0px transparent"
        });
      }
    });
  });