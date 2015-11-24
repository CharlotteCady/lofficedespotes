var isChrome = !!window.chrome;
var isIE = /*@cc_on!@*/false;

if( isChrome ) {
$("#dream-job-video").replaceWith($('<img id="dream-job-video" src="images/dream.jpg" class="bg" />'));
}

if( isIE ) {
$("#dream-job-video").replaceWith($('<img id="dream-job-video" src="images/dream.jpg" />'));
}