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

// trigger pour les inscriptions
var trigger = $('#toggleSubscribe').overlay({

	mask: {
		color: '#000033',
		loadSpeed: 150,
		opacity: 0.5
	},

	closeOnClick: false

});

// trigger pour la suppression d'une collection
var trigger = $('#deleteCollection').overlay({

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
	if(yes) {
            var form = document.createElement('form');
            form.setAttribute("action", "#");
            form.setAttribute("method", "POST");
            form.submit();
        }
});

// end of $(document).ready(function(){...
});