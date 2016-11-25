$(document).ready(function() {
  if ($('body').is('#ressources_show')) {
    $("div.content-text").find("a").each(function(){
      // this.setAttribute("rel", "external");
      this.removeAttribute("rel");
    });
  }
});

$(document).ready(function() {
  if ($('body').is('#articles_show')) {
    $("div.content-text").find("a").each(function(){
      // this.setAttribute("rel", "external");
      this.removeAttribute("rel");
    });
  }
});