/**
 * NOM: myModals v1.0
 * AUTEUR: MaBoy
 * DATE: 23/12/2011
 *
 * CHANGELOG
 * ---------
 * V1.0
 *	* First release
 */
$(document).ready(function(){

/**
 *
 */

// toggleSubscribe => fonction factice
function toggleSubscribe() {
	var isOff = $('.content > h1 > strong').css('color');
	isOff = (isOff == 'rgb(255, 0, 0)');

	if(isOff) {
		$('.content > h1 > strong')
			.html('activ&eacute;es')
			.css('color','green');
		$('#toggleSubscribe')
			.html('d&eacute;sactiver les inscriptions')
			.removeClass('y-button-blue')
			.addClass('y-button-red');
	}
	else {
		$('.content > h1 > strong')
			.css('color','red')
			.html('d&eacute;sactiv&eacute;es');
		$('#toggleSubscribe')
			.html('activer les inscriptions')
			.removeClass('y-button-red')
			.addClass('y-button-blue');
	}
}

// link le bouton pour afficher la modalbox
var trigger = $('#toggleSubscribe').overlay({

	mask: {
		color: '#000033',
		loadSpeed: 150,
		opacity: 0.5
	},

	closeOnClick: false

});

// link les boutons oui/non
var yesnobuttons = $('#confirm button').click(function(e){
	// récupère le bouton cliqué (le premier dans le flux)
	var yes = yesnobuttons.index(this) === 0;

	if(yes)
		// --> à changer lors du traitement jee
		toggleSubscribe();

});

// end of $(document).ready(function(){...
});