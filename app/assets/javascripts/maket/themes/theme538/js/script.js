
$(function(){
$('#setCurrency').jqTransform({imgPath:'jqtransformplugin/img/'});
});

	jQuery(document).ready(function(){
		jQuery('#tmspecials').css({visibility:'visible',display:'block'});
	// hide #back_top first
	jQuery("#back_top").hide();
	// fade in #back_top
	jQuery(function () {
		jQuery(window).scroll(function () {
			if (jQuery(this).scrollTop() > 100) {
				jQuery('#back_top').fadeIn();
			} else {
				jQuery('#back_top').fadeOut();
			}
		});

		// scroll body to 0px on click
		jQuery('#back_top a').click(function () {
			jQuery('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});
	});

});