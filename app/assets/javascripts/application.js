// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require_tree  ./jquery
//= require_tree  ./layout
//= require_tree  ./shopping

$(document).ready(function(){
  $("a#cart").click(function(){
    $("img#bigpic2").animate({opacity: "0", height: "304", width: "304"}, 1)
                    .animate({opacity: "0.6"}, 'fast')
                    .animate({opacity: "0.4", left: "+=900", top: "-=195", height: "40", width: "40"}, 1200)
                    .animate({opacity: "0"}, "slow")
                    .animate({opacity: "0", left: "0", height: "304", width: "304"}, 'fast')
                    .animate({opacity: "0", top: "+=195"}, 'fast')
                    .animate({opacity: "0", height: "1", width: "1"}, 'fast')

    $.getScript('/assets/cart.js', function(){
      testAjax();
    });

    return false;
  });
});