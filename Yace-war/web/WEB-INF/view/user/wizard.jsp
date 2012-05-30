<section id="main" class="whitebox"> <!-- main panel -->
    <c:if test="${!empty param.collection}">
        <sql:query var="coll" dataSource="Yacedb">
            SELECT * FROM ycollection WHERE ycollection.idYCOLLECTION = ? AND ycollection.owner = ?
            <sql:param value="${param.collection}"/>
            <sql:param value="${user.idYUSER}"/>
        </sql:query>
    </c:if>
    
<header onclick="test()">
    <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
    <c:choose>
        <c:when test="${!empty coll}">
            <h1>Modification de <strong>${coll.rows[0].theme}</strong></h1>
        </c:when>
        <c:otherwise>
            <h1>${pageTitle}</h1>
        </c:otherwise>
    </c:choose>
</header>

<section class="content"> <!-- contenu intÃ©ressant -->
    <aside id="toggletips"><strong>A I D E</strong></aside>

    <div id="appender"></div>

    <form name="wizardcollection" method="POST" action="#"></form>
    <button class="y-button y-button-white" onclick="valid()">Je valide !</button>
    
</section>

</section>

<div id="dummy">
<%-- TABLE D'AFFICHAGE DES ITEMTYPES DE LA COLLECTION --%>
    <sql:query var="itemtypes" dataSource="Yacedb">
        SELECT DISTINCT idYITEMTYPE, name FROM yitemtype yit JOIN yitem y ON yit.idYITEMTYPE = y.type
    </sql:query>
    <table id="itemtypes" class="y-table y-table-form y-table-center">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Nb. objets</th>
                <th><img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" /></th>
            </tr>
        </thead>
        <tfoot>
            <tr <c:if test="${itemtypes.rowCount % 2 == 0}">class="odd"</c:if>>
                <td colspan="3">Ajouter un nouveau type d'objet <img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="newItemType()" style="margin-bottom: -4px;"/></td>
            </tr>
        </tfoot>
        <tbody>
        <c:forEach var="itemtype" items="${itemtypes.rows}" varStatus="counter">
            <tr <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                <td>${itemtype.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty coll}">0</c:when>
                        <c:otherwise>
                            <sql:query var="nbItem" dataSource="Yacedb">
                                SELECT DISTINCT idYITEM FROM yitem y WHERE y.type = ? AND y.collection = ?
                                <sql:param value="${itemtype.idYITEMTYPE}"/>
                                <sql:param value="${coll.rows[0].idYCOLLECTION}"/>
                            </sql:query>
                            ${nbItem.rowCount}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <div class="mgmtIcons">
                        <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("itemtype${itemtype.idYITEMTYPE}")' />
                        <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("rank${rank.idYRANK}")' />
                    </div>
                    <div class="mgmtIcons">
                        <img class='undoicon' src='./theme/default/img/img_trans.gif' alt='Annuler' title='Annuler' onclick='undo("itemtype${itemtype.idYITEMTYPE}")' style='display: none;' />
                        <img class='validicon' src='./theme/default/img/img_trans.gif' alt='Valider' title='Valider' onclick='send("itemtype${itemtype.idYITEMTYPE}")' style='display: none;' />
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

<%-- ECRAN ITEMTYPE PREDEFINI --%>
    <sql:query var="publicIT" dataSource="Yacedb">
        <%-- Changer la requête pour ne pas prendre en compte les itemtypes déjà dans la collection --%>
        SELECT * FROM yitemtype yit WHERE yit.is_public = 1
    </sql:query>
    <table id="publicIT" class="y-table y-table-form y-table-center">
        <thead>
            <tr>
                <th></th>
                <th>Nom</th>
                <%-- <th><img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" /></th> --%>
            </tr>
        </thead>
        <tfoot>
            <tr <c:if test="${publicIT.rowCount % 2 == 0}">class="odd"</c:if>>
                <%-- <td colspan="3"> --%>
                <td colspan="2">
                    <button class="y-button y-button-white" onclick="valid()">J'ai choisi !</button>
                </td>
            </tr>
        </tfoot>
        <tbody>
        <c:forEach var="it" items="${publicIT.rows}" varStatus="counter">
            <tr id="itemtype${it.idYITEMTYPE}" <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                <td><input type="radio" name="itPublic" id="itPublic${it.idYITEMTYPE}" value="${it.idYITEMTYPE}"/></td>
                <td><label for="itPublic${it.idYITEMTYPE}">${it.name}</label></td>
                <%-- <td><img class='eyeicon' src='./theme/default/img/img_trans.gif' alt='Voir' title='Voir les d&eacute;tails' onclick='see("itemtype${it.idYITEMTYPE}")' /></td> --%>
            </tr>
        </c:forEach>
        </tbody>
    </table>

<%-- ECRAN CREATION ITEMTYPE --%>
<table id="createIT" class="y-table y-table-form y-table-center">
    <thead>
        <tr>
            <th>Ordre</th>
            <th>Nom de l'attribut</th>
            <th>Type d'attribut</th>
            <th>Multiple ?</th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <td colspan="4">
                <button class="y-button y-button-white" onclick="addNewAttribute()">J'ajoute un nouvel attribut !</button>
            </td>
        </tr>
    </tfoot>
    <tbody></tbody>
</table>
</div> 

<script type="text/javascript">
function valid() {
$(document).ready(function(){
    var saveButton = document.createElement("button");
    $(saveButton)
        .attr("class", "y-button y-button-green")
        .attr("onclick", "save()")
        .html("J'enregistre les modifications !");
        
    $("section.content").append(saveButton);
});
}

function showNewCollection() {
$(document).ready(function(){
    var newCollection = document.createElement("div");
    var labelTheme = document.createElement("label");
    var inputTheme = document.createElement("input");
    var continueButton = document.createElement("button");

    $(continueButton)
        .attr("class","y-button y-button-white")
        .attr("onclick","collectionNameVerif()")
        .html("Je continue !");

    $(inputTheme)
        .attr("type","text")
        .attr("id","theme")
        .attr("name","theme")
        .attr("required","required");

    $(labelTheme)
        .attr("for","theme")
        .html("Entrez la th&eacute;matique de la nouvelle collection : ");

    $(newCollection)
        .attr("id","newCollection")
        .attr("class","wizardBox")
        .append(labelTheme)
        .append(inputTheme)
        .append(continueButton);

    $("div#appender").append(newCollection);
});
}

function collectionNameVerif(){
$(document).ready(function(){
    var theme = $("#theme").val();
    
    theme = theme.trim();
    
    if(!theme || theme.length === 0 || (/^\s*$/).test(theme)) {
        alert("Oh noooon !");
    } else {
        var collectionName = document.createElement("input");
        $(collectionName)
            .attr("type","hidden")
            .attr("name","collectionName")
            .attr("value",theme);
        $("form[name='wizardcollection']").append(collectionName);

        $("section.content div#newCollection").remove();
        showNewOrPublic();
    }
});
}

function showNewOrPublic(){
$(document).ready(function(){
    var newOrPublic = document.createElement("div");
    var aPublic = document.createElement("a");
    var aNew = document.createElement("a");
    var strongOr = document.createElement("strong");

    $(aPublic)
        .attr("onclick","showPublicItemTypes()")
        .html("Ajouter un type d'objet pr&eacute;d&eacute;fini");

    $(strongOr).html("<br/>OU<br/>");

    $(aNew)
        .attr("onclick","showItemTypeCreation()")
        .html("Cr&eacute;er un nouveau type d'objet");

    $(newOrPublic)
        .attr("id","newOrPublic")
        .attr("class","wizardBox")
        .append(aPublic)
        .append(strongOr)
        .append(aNew);

    $("div#appender").append(newOrPublic);
});
}

function showItemTypes(){
$(document).ready(function(){
    if(!$("div#appender table#itemtypes").length) {
        $("div#appender").append($("div#dummy table#itemtypes").clone())
    }
});
}

function showPublicItemTypes(){
$(document).ready(function(){
    if(!$("div#appender table#publicIT").length){
        $("div#appender").append($("div#dummy table#publicIT").clone())
    }
});
}

function showItemTypeCreation(){
$(document).ready(function(){
    if(!$("div#appender table#createIT").length){
        var newItemType = document.createElement("div");
        var labelTheme = document.createElement("label");
        var inputTheme = document.createElement("input");
        var continueButton = document.createElement("button");

        $(continueButton)
            .attr("class","y-button y-button-white")
            .attr("onclick","itemtypeNameVerif()")
            .html("Je continue !");

        $(inputTheme)
            .attr("type","text")
            .attr("id","name")
            .attr("name","name")
            .attr("required","required");

        $(labelTheme)
            .attr("for","theme")
            .html("Entrez le nom du nouveau <strong>type d'objets</strong> : ");

        $(newItemType)
            .attr("id","newItemType")
            .attr("class","wizardBox")
            .append(labelTheme)
            .append(inputTheme)
            .append(continueButton)
            .append($("div#dummy table#createIT").clone());
            
        $("div#appender").append(newItemType);
    }
});
}
</script>
<c:if test="${empty coll}">
    <script type="text/javascript">
        showNewCollection();
    </script>
</c:if>