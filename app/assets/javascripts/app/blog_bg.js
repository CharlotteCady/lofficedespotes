$(document).ready(function() {
  // if ($('body').is('#articles_index')) {
    $('div.content-banner').hover(function () {

      $(this).addClass("hover_article");
      }, function(){
      $(this).removeClass("hover_article");
    });
  // }
});
