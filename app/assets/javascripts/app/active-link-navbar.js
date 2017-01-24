// Onglet des menus avec une barre lorsque l'on est sur la bonne url
$(document).ready(function(){
  if (location.pathname !== '/') {
    $('#bs-example-navbar-collapse-1 > ul > li:nth-child(-n+3) > a[href^="/' + location.pathname.split("/")[1] + '"]').addClass('changed');
  }
});

$(document).ready(function(){
  if ((location.pathname == '/comment-cela-marche') || (location.pathname == '/a-propos') || (location.pathname ==  '/pro')
    || (location.pathname == '/manifeste') || (location.pathname == '/contact')) {
    $('ul > li > a.active-about').addClass('changed');
  }
});

$(document).ready(function(){
  if ((location.pathname == '/ressources') || (location.pathname == '/categorie')) {
    $('ul > li > a.active-solutions').addClass('changed');
  }
});

// Ajoute la classe changed (barre sous le menu actif) quand on clique dessus mais s'en va au reload
// $(document).ready(function(){
//   $('#bs-example-navbar-collapse-1 > ul > li:nth-child(-n+3) > a').click(function(){
//     $('ul > li:nth-child(-n+3) > a').removeClass('changed');
//     $(this).addClass('changed');
//   });
// });

