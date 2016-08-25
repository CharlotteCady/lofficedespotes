// $(function() {
//   $('#little-screen').on('click','.navbar-menu', function ( e ) {
//     e.preventDefault();
//     $(this).parents('#little-screen').find('.active').removeClass('active').end().end().addClass('active');
//     $(activeTab).show();
//   });
// });

// $(document).ready(function(){
//   $("#menu_filter a").each(function(){
//     if($(this).attr("href")==window.location.pathname)
//       $("#menu_filter").addClass("active");
//   });
// });

$(function() {
  $('#tag-filter ul li a').each(function(){
      var path = window.location.href;
      var current = path.substring(path.lastIndexOf('/'));
      var url = $(this).attr('href');

      if(url == current){
          $(this).parent().addClass('active');
      };
    });
});