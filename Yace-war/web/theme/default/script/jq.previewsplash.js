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

        $('div#foreground').hide()
 	$('div[role="preview"]').hide()

	$('figure.cover > img, figure.cover > figcaption').click(function(){
                var id = this.parentNode.id;
                $('div#foreground').fadeIn(150)
                $('div[role="preview"]#prev-'+id).fadeIn(150)
		/* Ajax etc */
	})

	$('div#foreground').click(function(){
		$(this).hide()
                $('div[role="preview"]').hide()
	})

});