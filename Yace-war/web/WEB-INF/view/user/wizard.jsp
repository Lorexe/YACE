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
    
    <c:choose>
        <c:when test="${empty coll}">
            <label for="theme">Entrez la thématique de la nouvelle collection</label> : <input type="text" id="theme" name="theme"/>
        </c:when>
        <c:otherwise>
            <%-- TABLE D'AFFICHAGE DES ITEMTYPES DE LA COLLECTION --%>
            <sql:query var="itemtypes" dataSource="Yacedb">
                SELECT * FROM yitemtype JOIN yitem ON yitemtype.idYITEMTYPE = yitem.type
            </sql:query>
            <table id="itemtypes" class="y-table y-table-form y-table-center" style="display:none;">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Nb. objets</th>
                        <th>
                            <img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" />
                        </th>
                    </tr>
                </thead>
                <tfoot>
                    <tr id="itemtypenew" <c:if test="${itemtypes.rowCount % 2 == 0}">class="odd"</c:if>>
                        <td colspan="3">Ajouter un nouveau type d'objet <img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="newItemType()" style="margin-bottom: -4px;"/></td>
                    </tr>
                </tfoot>
                <tbody>
                <c:forEach var="itemtype" items="${itemtypes.rows}">
                    <tr id="itemtype${itemtype.idYITEMTYPE}" <c:if test="${itemtype.idYITEMTYPE % 2 != 0}">class="odd"</c:if>>
                        <td>${itemtype.name}</td>
                        <td>
                            <sql:query var="nbItem" dataSource="Yacedb">
                                SELECT DISTINCT yitem.idYITEM FROM yitem y WHERE y.type = ? AND y.collection = ?
                                <sql:param value="${itemtype.idYITEMTYPE}"/>
                                <sql:param value="${coll.rows[0].idYCOLLECTION}"/>
                            </sql:query>
                            ${nbItem.rowCount}
                        </td>
                        <td>
                            <div class="mgmtIcons">
                                <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("itemtype${itemtype.idYITEMTYPE}")' />
                                <%-- <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("rank${rank.idYRANK}")' /> --%>
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
        </c:otherwise>
    </c:choose>

    <div id="appender"></div>

    <form name="wizardcollection" method="POST" action="#"></form>
    <button class="y-button y-button-white" onclick="valid()">Je valide !</button>
    
</section>

</section>

<div id="dummy">
<%-- ECRAN CHOIX ITEMTYPE NOUVEAU OU EXISTANT --%>
    <div id="newOrExisting">
        <a onclick="showExistingItemTypes()">Ajouter un type d'objet existant</a><br/>
        <strong>OU</strong><br/>
        <a onclick="showItemTypeCreation()">Cr&eacute;er un nouveau type d'objet</a><br/>
    </div> 

<%-- ECRAN ITEMTYPE EXISTANT --%>
    <sql:query var="itemtypes" dataSource="Yacedb">
        SELECT * FROM yitemtype y WHERE y.is_public = 1
    </sql:query>
    <table id="itemtypes" class="y-table y-table-form y-table-center" style="display:none;">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Nb. objets</th>
                <th>
                    <img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" />
                </th>
            </tr>
        </thead>
        <tfoot>
            <tr id="itemtypenew" <c:if test="${itemtypes.rowCount % 2 == 0}">class="odd"</c:if>>
                <td colspan="3">Ajouter un nouveau type d'objet <img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="newItemType()" style="margin-bottom: -4px;"/></td>
            </tr>
        </tfoot>
        <tbody>
        <c:forEach var="itemtype" items="${itemtypes.rows}">
            <tr id="itemtype${itemtype.idYITEMTYPE}" <c:if test="${itemtype.idYITEMTYPE % 2 != 0}">class="odd"</c:if>>
                <td>${itemtype.name}</td>
                <td>
                    <c:choose>
                        <c:when test="${!empty coll}">
                            <sql:query var="nbItem" dataSource="Yacedb">
                                SELECT DISTINCT yitem.idYITEM FROM yitem y WHERE y.type = ? AND y.collection = ?
                                <sql:param value="${itemtype.idYITEMTYPE}"/>
                                <sql:param value="${coll.rows[0].idYCOLLECTION}"/>
                            </sql:query>
                            ${nbItem.rowCount}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <div class="mgmtIcons">
                        <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("itemtype${itemtype.idYITEMTYPE}")' />
                        <%-- <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("rank${rank.idYRANK}")' /> --%>
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

<%-- ECRAN CREATION ITEMTYPE --%>
    
</div> 

<script type="text/javascript">
function showItemTypes(){
$(document).ready(function(){
    $("div#appender").append($("div#dummy table#itemtypes").clone())
});
}

function newItemType(){
$(document).ready(function(){
    
});
}

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
</script>