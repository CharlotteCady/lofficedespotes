$(document).ready(function(){
  $('.owl-carousel').owlCarousel({
    // navigation : true,
    // slideSpeed : 300,
    // paginationSpeed : 400,
    // singleItem:true
    items : 3, //4 items above 1000px browser width
    itemsDesktop : [1000,3], //5 items between 1000px and 901px
    itemsDesktopSmall : [900,3], // betweem 900px and 601px
    itemsTablet: [600,1], //2 items between 600 and 0
    itemsMobile : false // itemsMobile disabled - inherit from itemsTablet option
  });
  $('.owl-carousel-big').owlCarousel({
    items : 1,
    nav : true, // Show next and prev buttons
    navText: ["<span class='glyphicon glyphicon-menu-left'></span>","<span class='glyphicon glyphicon-menu-right'></span>"],
    // loop: true,
    // autoplay:true,
    // autoplayTimeout:1000,
    // autoplayHoverPause:true
  });
  $('.owl-carousel-mobile').owlCarousel({
    items : 2,
  });

});