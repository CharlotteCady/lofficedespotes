$(document).ready(function() {
  if ($('body').is('#ressources_show')) {
    var linkNumber = $('div.content-text a').length
    for (var i = 1; i < linkNumber + 1; i++) {
      var compteur = i;
      $('div.content-text a:eq(' + (i - 1) + ')').attr('id', 'ressource-content-website' + [i]);
    }
  }
})

$(document).ready(function() {
  if ($('body').is('#articles_show')) {
    var linkNumber = $('div.content-text a').length
    for (var i = 1; i < linkNumber + 1; i++) {
      var compteur = i;
      $('div.content-text a:eq(' + (i - 1) + ')').attr('id', 'article-content-website' + [i]);
    }
  }
})
