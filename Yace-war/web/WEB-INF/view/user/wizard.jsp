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
    <%-- <button class="y-button y-button-white" onclick="valid()">Je valide !</button> --%>
    
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

<%-- SELECT ITEMTYPE PREDEFINIS --%>
<div id="choiceIT">
    <br/>
    <label for="selectIT"><strong>De quel type sera votre nouvel objet ?</strong></label>
    <br/><br/>
    <select id="selectIT" name="selectIT" style="height:29px;">
        <c:forEach var="it" items="${publicIT.rows}">
            <option value="${it.idYITEMTYPE}">${it.name}</option>
        </c:forEach>
    </select>
</div>

<%-- REMPLIR ITEMTYPE PREDEFINIS --%>
<c:forEach var="it" items="${publicIT.rows}">
    <div id="fillerIT${it.idYITEMTYPE}" class="wizardBox">
        <sql:query var="attributes" dataSource="Yacedb">
            SELECT * FROM yattribute yat
            WHERE yat.itemtype = ?
            ORDER BY yat.no_order ASC
            <sql:param value="${it.idYITEMTYPE}"/>
        </sql:query>
        <br/><strong>Remplissez les donn&eacute;es requises pour le type d'objet "${it.name}" ci-dessous</strong><br/><br/>
        <table class="y-table y-table-form y-table-center">
            <thead>
                <tr>
                    <th>Nom de l'attribut</th>
                    <th>Valeur de l'attribut</th>
                    <th></th>
                </tr>
            </thead>
            <tfoot>
                <tr <c:if test="${attributes.rowCount % 2 == 0}">class="odd"</c:if>>
                    <td collspan="3">
                        <button class="y-button y-button-white" onclick="verifNewItem(${it.idYITEMTYPE})">Je valide et je continue !</button>
                    </td>
                </tr>
            </tfoot>
            <tbody>
        <c:forEach var="attr" items="${attributes.rows}" varStatus="counter">
            <tr id="${it.idYITEMTYPE}-${attr.no_order}" <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                <td>${attr.name} (${attr.type})</td>
                <td>
                    <div id="attr-${it.idYITEMTYPE}-${attr.no_order}">
                    <c:choose>
                        <%-- Type Int ou Float --%>
                        <c:when test="${attr.type == 'Int' || attr.type == 'Float'}">
                            <input type="text" size="5" name="attr-${it.idYITEMTYPE}-${attr.no_order}"/>
                        </c:when>
                        <%-- Type Bool --%>
                        <c:when test="${attr.type == 'Bool'}">
                            <input type="checkbox" name="attr-${it.idYITEMTYPE}-${attr.no_order}"/>
                        </c:when>
                        <%-- Type String ou Date ou Image --%>
                        <c:otherwise>
                            <input type="text" size="20" name="attr-${it.idYITEMTYPE}-${attr.no_order}"/>
                        </c:otherwise>
                    </c:choose>
                    </div>
                </td>
                <td>
                    <c:if test="${attr.many}">
                        <img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="addAttr(${it.idYITEMTYPE},${attr.no_order},0)" style="margin-bottom: -4px;"/>
                        <input type="hidden" role="counter" value="0"/>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
            </tbody>
        </table>
    </div>
</c:forEach>

</div> 

<script type="text/javascript">
$(document).ready(function(){
    $("#isPrivate").click(function(){
        
    });
});
    
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
    var labelPrivate = document.createElement("label");
    var checkPrivate = document.createElement("input");

    $(continueButton)
        .attr("class","y-button y-button-white")
        .attr("onclick","collectionNameVerif()")
        .html("Je valide et je continue !");

    $(inputTheme)
        .attr("type","text")
        .attr("id","theme")
        .attr("name","theme")
        .attr("required","required");

    $(labelTheme)
        .attr("for","theme")
        .html("<strong>Quel sera le th&ecirc;me de votre nouvelle collection ?</strong>");
        
    $(checkPrivate)
        .attr("type","checkbox")
        .attr("id","isPrivate")
        .attr("name","isPrivate")
        .attr("checked","checked")
        .attr("title","Décochez pour montrer votre collection aux visiteurs du site");
        
    $(labelPrivate)
        .attr("for","isPrivate")
        .html("Collection privée ? ");

    $(newCollection)
        .attr("id","newCollection")
        .attr("class","wizardBox")
        .append("<br/>")
        .append(labelTheme)
        .append("<br/><br/>")
        .append(inputTheme)
        .append("<br/><br/>")
        .append(labelPrivate)
        .append(checkPrivate)
        .append("<br/><br/>")
        .append(continueButton);

    $("div#appender").append(newCollection);
});
}

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
            .attr("name","collectionName")
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
            .append(publicIndicator);

        $("section.content div#newCollection input").attr("disabled","disabled");
        $("section.content div#newCollection button").remove();
        //showNewOrPublic();
        showAddNewItem();
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

function showAddNewItem(){
$(document).ready(function(){
    if(!$("div#appender #newItem").length){
        var newItem = document.createElement("div");
        var continueButton = document.createElement("button");

        $(continueButton)
            .attr("class","y-button y-button-white")
            .attr("onclick","selectedIT()")
            .html("Je valide et je continue !");
        
        $(newItem)
            .attr("id","newItem")
            .attr("class","wizardBox")
            .append($("div#choiceIT").clone().append(continueButton))
            .append("<br/>");
            
        $("div#appender").append(newItem);
    }
});
}

function selectedIT(){
$(document).ready(function(){
    var choice = $("section.content div#newItem select").val();
    var itemtype = document.createElement("input");
    $(itemtype)
        .attr("type","hidden")
        .attr("name","chosenIT")
        .attr("value",choice);
    $("form[name='wizardcollection']").append(itemtype);

    $("section.content div#newItem select").attr("disabled","disabled");
    $("section.content div#newItem button").remove();
    
    $("div#appender").append($("div#dummy div#fillerIT"+choice).clone())
});
}

function verifNewItem(idIT) {
$(document).ready(function(){
    
});
}

function addAttr(idIT, attrOrder, nbAttr) {
$(document).ready(function(){
    var lastAttr;
    if(nbAttr > 0) {
        lastAttr = "#fillerIT"+idIT+" div#attr-"+idIT+"-"+attrOrder+"-"+nbAttr;
    } else {
        lastAttr = "#fillerIT"+idIT+" div#attr-"+idIT+"-"+attrOrder;
    }
    
    (nbAttr++);
    
    var remover = document.createElement("img");
    $(remover)
        .attr("class","deleteicon")
        .attr("src","./theme/default/img/img_trans.gif")
        .attr("alt","Enlever")
        .attr("title","Enlever")
        .attr("onclick","removeAttr("+idIT+","+attrOrder+","+nbAttr+")")
        .attr("style","margin-bottom: -4px;");
    
    var newInput = document.createElement("input");
    $(newInput).attr("type",$(lastAttr+" input").attr("type"));
    $(newInput).attr("name","attr-"+idIT+"-"+attrOrder+"-"+nbAttr);
        
    var newAttr = document.createElement("div");
    $(newAttr)
        .attr("id","attr-"+idIT+"-"+attrOrder+"-"+nbAttr)
        .append(newInput)
        .append(remover)
        .insertAfter(lastAttr);
        
    $("#fillerIT"+idIT+" tr#"+idIT+"-"+attrOrder+" img.moreicon")
        .attr("onclick","addAttr("+idIT+","+attrOrder+","+nbAttr+")");
        
    var test = parseInt($("#fillerIT"+idIT+" tr#"+idIT+"-"+attrOrder+" input[role='counter']").val());
    $("#fillerIT"+idIT+" tr#"+idIT+"-"+attrOrder+" input[role='counter']").attr("value",test++);

});
}

function removeAttr(idIT, attrOrder, nbAttr) {
$(document).ready(function(){
    $("#fillerIT"+idIT+" div#attr-"+idIT+"-"+attrOrder+"-"+nbAttr).remove();
    if(nbAttr > 1) {
        $("#fillerIT"+idIT+" tr#"+idIT+"-"+attrOrder+" img.moreicon")
        .attr("onclick","addAttr("+idIT+","+attrOrder+","+nbAttr+")")
    } else {
        $("#fillerIT"+idIT+" tr#"+idIT+"-"+attrOrder+" img.moreicon")
        .attr("onclick","addAttr("+idIT+","+attrOrder+","+nbAttr+")")
    }
});
}

</script>
<c:if test="${empty coll}">
    <script type="text/javascript">
        showNewCollection();
    </script>
</c:if>
