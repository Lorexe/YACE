/**
 * Test zone
 */

function redirection(page) {
    window.open(page, '_self');
}

$(document).ready(function() {

    $('#editicon').click(function(){
        redirection('./user-profil.html');
    });
    
});

/**
 *
 */
function setInfo(idWhere, msg) {
    $(document).ready(function() {
        $(idWhere).removeClass()
        .addClass('info output')
        .empty()
        .append(msg)
    });
}
function setWarning(idWhere, msg) {
    $(document).ready(function() {
        $(idWhere).removeClass()
        .addClass('warning output')
        .empty()
        .append(msg)
    });
}

function setFatal(idWhere, msg) {
    $(document).ready(function() {
        $(idWhere).removeClass()
        .addClass('fatal output')
        .empty()
        .append(msg)
    });
}