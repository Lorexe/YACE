/**
 * NOM: ToggleTips v1.0
 * AUTEUR: MaBoy
 * DATE: 13/12/2011
 *
 * CHANGELOG
 * ---------
 * V1.0
 *	* First release
 */
$(document).ready(function(){
	$('#toggletips').click(function() {
		if($('#guide').hasClass('none')) {
			$('#main').animate({marginRight: '230px'}, 250,
				function() {
			  	$('#guide').fadeIn(150);
					$('#guide').removeClass('none');
			  });
		}
		else {
			$('#guide').fadeOut(150, function() {
				$('#main').animate({marginRight: '0'}, 250,
					function() {
						$('#guide').addClass('none');
					});
			});
		}
	})
});