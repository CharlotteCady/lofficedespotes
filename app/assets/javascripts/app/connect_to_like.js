$(document).ready(function(){
  $('.connect_to_like').click(function (event) {
      // alert('Vous devez être connecté pour liker cette initiative :)');
      event.preventDefault(); // Prevent link from following its href
      $('.alert_connect_to_like').toggle();
    });

});