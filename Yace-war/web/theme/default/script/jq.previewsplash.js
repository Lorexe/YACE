/**
 * NOM: PreviewSplash v1.0
 * AUTEUR: MaBoy
 * DATE: 21/12/2011
 *
 * CHANGELOG
 * ---------
 * V1.0
 *	* First release
 */
 $(document).ready(function(){

 	$('div[role="preview"]').hide()

	$('figure.cover > img, figure.cover > figcaption').click(function(){
		$('div[role="preview"]').fadeIn(150)
		/* Ajax etc */
	})

	$('div#foreground').click(function(){
		$('div[role="preview"]').hide()
	})

});