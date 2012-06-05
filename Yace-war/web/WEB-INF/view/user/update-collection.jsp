<section id="main" class="whitebox"> <!-- main panel -->
    <c:if test="${!empty param.idCollection}">
        <sql:query var="coll" dataSource="Yacedb">
            SELECT * FROM ycollection WHERE ycollection.idYCOLLECTION = ? AND ycollection.owner = ?
            <sql:param value="${param.idCollection}"/>
            <sql:param value="${user.idYUSER}"/>
        </sql:query>
    </c:if>
    
<header>
    <c:choose>
        <c:when test="${!empty coll}">
            <% if (request.getAttribute("deletionOK") == null) {%>
                <h1>Modification de <strong>${coll.rows[0].theme}</strong></h1>
            <% } else { %>
                <h1>Suppression <strong>effectu&eacute;e</strong></h1>
            <% } %>
        </c:when>
        <c:otherwise>
            <h1>${pageTitle}</h1>
        </c:otherwise>
    </c:choose>
</header>

<section class="content"> <!-- contenu intÃ©ressant -->
    <aside id="toggletips"><strong>A I D E</strong></aside>
<% if (request.getAttribute("deletionOK") == null) {%>
    <div class="wizardBox">
        <c:choose>
            <c:when test="${!empty coll}">
                <br><label for="theme">Thème actuel: <strong>${coll.rows[0].theme}</strong>. Le changer ?</label>
            </c:when>
            <c:otherwise>
                <br><label for="theme"><strong>Quel sera le thême de votre nouvelle collection ?</strong></label>
            </c:otherwise>
        </c:choose>
        <br><br><input type="text" id="theme" name="theme" <c:if test="${!empty coll}">value="${coll.rows[0].theme}"</c:if> required="required">
        <br><br><label for="isPrivate">Collection priv&eacute;e ?</label> <input type="checkbox" id="isPrivate" name="isPrivate" <c:if test="${!empty coll && !coll.rows[0].is_public}">checked="checked"</c:if> title="Décochez pour montrer votre collection aux visiteurs du site">
        <br><br><button class="y-button y-button-white" onclick="collectionNameVerif()">Je valide et j'enregistre !</button>
        <c:if test="${!empty coll}">
            <br><br><button class="y-button y-button-red" id="deleteCollection" rel="#confirm">Supprimer d&eacute;finitivement</button>
        </c:if>
    </div>

    <form name="wizardcollection" method="POST" action="#">
        <c:if test="${!empty coll}">
            <input type="hidden" name="idCollection" value="${coll.rows[0].idYCOLLECTION}"/>
        </c:if>
    </form>
    <%-- <button class="y-button y-button-white" onclick="valid()">Je valide !</button> --%>
<% } else { %>
    <p>${deletionOK}</p>
<% } %>
</section>

</section>

<script type="text/javascript">
function collectionNameVerif(){
$(document).ready(function(){
    var theme = $("#theme").val();
    
    theme = theme.trim();
    
    if(!theme || theme.length === 0 || (/^\s*$/).test(theme)) {
        alert("Veuillez entrer un thème pour la collection");
    } else {
        var collectionName = document.createElement("input");
        $(collectionName)
            .attr("type","hidden")
            .attr("name","name")
            .attr("value",theme);
        
        var publicIndicator = document.createElement("input");
        $(publicIndicator)
            .attr("type","hidden")
            .attr("name","isPublic")
            .attr(
                "value",
                ($("#isPrivate").attr("checked") != 'checked')?"true":"false"
            );
        
        $("form[name='wizardcollection']")
            .append(collectionName)
            .append(publicIndicator)
            .submit();
    }
});
}

</script>

<!-- Modal dialogs -->
<!-- confirm dialog -->
<div class="modal modal-info whitebox" id="confirm">
    <header>
        <h1><strong>Confirmation</strong> attendue</h1>
    </header>
    <p>
        Vous effectuez une <strong>action</strong> qui demande une <strong>confirmation</strong>. Si vous souhaitez continuer, <strong>tous les objets de la collection seront perdus</strong> !
    </p>
    
    <p>
        <button class="close y-button y-button-red confirm-yes"> oui </button>
        <button class="close y-button y-button-blue"> non </button>
    </p>
</div>

<script type="text/javascript">
$(document).ready(function(){

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
            var deletionIndicator = document.createElement("input");
            $(deletionIndicator)
                .attr("type","hidden")
                .attr("name","delete")
                .attr("value","delete");
            $("form[name='wizardcollection']")
                .append(deletionIndicator)
                .submit();
        }
});

// end of $(document).ready(function(){...
});
</script>