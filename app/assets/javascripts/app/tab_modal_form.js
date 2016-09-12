$(document).ready(function() {
  $('#tab_form a').click(function (event) {
      // alert('Vous devez être connecté pour liker cette initiative :)');
      event.preventDefault(); // Prevent link from following its href
      $(this).tab('show');
    });
});