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

String.prototype.trim = function () {
    return this.replace(/^\s*/, "").replace(/\s*$/, "");
}

function validateSearchForm() {
    if($("#keyword").val().length < 1){
        //pas de recherche sur paramètre vide
        $("#searchbar").prop('title', 'Vous devez introduire un mot d\'au moins 2 lettres');
        return false;
    }
    else
        return true;
}