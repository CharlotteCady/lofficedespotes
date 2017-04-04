  $(document).ready(function() {
    // navbar transition jQuery script
    if ((location.href == "http://www.workuper.com/") || 
      (location.href == "https://www.workuper.com/") || 
      (location.href == "http://localhost:3000/")) {
      $(window).scroll(function(e){
        if ($(this).scrollTop() > 100) {
          $(".navbar-wagon").css({
            "background" : "black",
          });
          $("#home-bar-newsletter").css({
            "background" : "white",
          });
          $("#facebook a, #twitter a, #linkedin a").css({
            "color": "#1ECBCA",
          });
        }
        else {
          $(".navbar-wagon").css({
            "background": "transparent",
          });
          $("#home-bar-newsletter").css({
            "background": "rgba(0,0,0,0.4)",
          });
          $("#facebook a, #twitter a, #linkedin a").css({
            "color": "white",
          });
        }
      });
    }
  });