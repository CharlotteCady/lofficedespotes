// AFFICHER LA NL POUR LA 1ERE VISITE
$(document).ready(function() {
  if(localStorage.getItem('popState') != 'shown'){
    setTimeout(function() {
      $('#myModal').modal({show: true, keyboard: true});
      }, 6000); // milliseconds
    localStorage.setItem('popState','shown')
  }
});


// AFFICHER LA NL QUAND LA SOURIS SORT DE LA PAGE
// $(document).mouseleave(function() {
//   $('#myModal').modal({show: true, keyboard: true});
// });
