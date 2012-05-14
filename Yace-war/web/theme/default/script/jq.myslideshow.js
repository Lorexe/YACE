/**
 * NOM: SlideSHOW v1.0.1
 * AUTEUR: MaBoy
 * DATE: 19/11/2011
 *
 * S'utilise comme suit au niveau HTML:
 * <xxx id="slideshow">
 * 	<yyy class="slide">
 *		zzz
 *	</yyy>
 * </xxx>
 * .
 * .
 * .
 * <aaa id="prev" /> <aaa id="next" />
 * <aaa id="pause" /> <aaa id="play" />
 *
 * CHANGELOG
 * ---------
 * V1.0.1
 *	* Little bugfix
 * V1.0
 *	* First release
 */
$(document).ready(function(){
	$('#slideshow > *:gt(0)').hide() // cache tous les enfants de #slideshow sauf le premier

	/* Bouton SUIVANT */
	$('#next').click(function(){
		$('#pause').click()
		$('.slide:first').slideUp(500, function(){
			$(this).appendTo('#slideshow')
			$('.slide:first').slideDown(500)
		})
	})

	/* Bouton PRECEDENT */
	$('#prev').click(function(){
		$('#pause').click()
		$('.slide:first').slideUp(500, function(){
			$('.slide:last-child').slideDown(500, function(){
				$(this).prependTo('#slideshow')
			})
		})
	})

	/* Bouton PLAY */
	$('#play').click(function(){
		$(document).everyTime("7s", "diapo", function(){
			$('.slide:first').slideUp(500, function(){
			$(this).appendTo('#slideshow')
			$('.slide:first').slideDown(500)
			})
		})
		$('#play').hide();
		$('#pause').show();
	})

	/* Bouton PAUSE */
	$('#pause').click(function(){
		$(document).stopTime("diapo")
		$('#play').show();
		$('#pause').hide();
	})

	$('#play').show();
	$('#pause').hide();
	$('#play').click() // lance le diapo

});