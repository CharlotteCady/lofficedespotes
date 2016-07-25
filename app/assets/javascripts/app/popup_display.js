$(document).ready(function() {
  if(localStorage.getItem('popState') != 'shown'){
    setTimeout(function() {
      $('#myModal').modal({show: true, keyboard: true});
      }, 6000); // milliseconds
    localStorage.setItem('popState','shown')
  }
});