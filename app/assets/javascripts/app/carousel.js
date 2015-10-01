$(document).ready(function(){
  $('.owl-carousel').owlCarousel({
    // navigation : true,
    // slideSpeed : 300,
    // paginationSpeed : 400,
    // singleItem:true
    items: 4,
    // Navigation
    navigation : true,
    navigationText : ["Précédent","Suivant"],
    rewindNav : true,
    scrollPerPage : false,
  });
});