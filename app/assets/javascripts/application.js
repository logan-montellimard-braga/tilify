// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require masonry/jquery.masonry
//= masonry/modernizr-transitions
//= require_tree .

$(function($){

  $(document).ready(function() {
    $('.blankPage').fadeOut('slow');

    $(document).foundation();
    $('.joyRideButton').click(function() {
      var target = $('#searchTuiles');
      $('html, body').animate({ scrollTop: $(target).offset().top }, 1200);
      setTimeout(function() {
        $(document).foundation('joyride', 'start');
      }, 1000);
    })

    $('.goToTop').click(function(e) {
      e.preventDefault();
      $('html, body').animate({ scrollTop: 0 }, 600);
    })
  });

  $('#masonry-container').masonry({
    itemSelector: '.myMasonry',
    isAnimated: !Modernizr.csstransitions,
  });
}(jQuery));
