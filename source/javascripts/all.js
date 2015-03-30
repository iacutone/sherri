//= require 'jquery-1.11.2.min.js'

$(document).ready(function(){

  $('a[href^="#"]').on('click',function(e){
    e.preventDefault();
    var target = this.hash,
    $target = $(target);
    
    if (typeof(jQuery($target).offset()) !== 'undefined') {
    
      $('html,body').stop().animate({
        'scrollTop': $target.offset().top - 50
      }, 800, 'swing', function(){
        window.location.hash = target;
      });
      
    }
  });

});

$(window).scroll(function () {
  if ( $(this).scrollTop() > 450 && !$('header').hasClass('fixed') ) {
    $('header').addClass('fixed');
  } else if ( $(this).scrollTop() <= 450 ) {
    $('header').removeClass('fixed');
  }
});