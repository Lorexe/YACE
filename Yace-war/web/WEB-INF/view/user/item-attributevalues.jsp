<section id="main" class="whitebox"> <!-- main panel -->
<header>
    <h1>${pageHeaderTitle}</h1>
</header>
<section class="content">
    <aside id="toggletips"><strong>A I D E</strong></aside>
    
    <c:choose>
        <c:when test="${empty attributevalues}">
            <p class="search-header">Aucune valeur disponible</p>
        </c:when>
        <c:otherwise>
            <div>
                
            <p class="search-header">
                <a href="see?idCollection=${curItem.collection.idYCOLLECTION}"><label><strong> Collection : ${curItem.collection.theme}</strong></label></a><br/><br/>
                <a href="typedetails?type=${curItem.type.idYITEMTYPE}"><label ><strong>Type d'objet  : <b>${curItem.type.name}</b></strong></label></a><br/><br/>
                <label ><b>Propri&eacute;taire  : &nbsp; ${curItem.collection.owner.pseudo}</b></label><br/><br/>
                <c:choose>
                    <c:when test="${prevIt ne -1}">
                        <a href="details?item=${prevIt}"><img alt="Précédent" src="./theme/default/img/icon/prev_24.png" title="Précédent"/></a>
                    </c:when>
                    <c:otherwise>
                        <img alt="" src="./theme/default/img/icon/prev_24g.png"/>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${nextIt ne -1}">
                        <a href="details?item=${nextIt}"><img alt="Suivant" src="./theme/default/img/icon/next_24.png" title="Suivant"/></a>
                    </c:when>
                    <c:otherwise>
                        <img alt="" src="./theme/default/img/icon/next_24g.png"/>
                    </c:otherwise>
                </c:choose>
                <br/>
                </p>
                <h3>Les Caract&eacute;ristiques</h3><br/><br/>
                <table class="y-table">
                    <c:forEach var="attval" items="${attributevalues}" varStatus ="attrcount">
                        <tr <c:if test="${attrcount.count % 2 == 0}">class="odd"</c:if>>
                            <td>
                                <label ><b>${attval.attribute.name}</b></label>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${attval.attribute.type eq 'String'}">
                                        <label  class="attr-longtext" for="attrval${attval.idYATTRIBUTEVALUE}">${attval.valStr}</label>        
                                    </c:when>
                                    <c:when test="${attval.attribute.type eq 'Image'}">
                                        <%-- todo : afficher l'image   balise img    --%>
                                        <img for="attrval${attval.idYATTRIBUTEVALUE}" class="attr-cover" src="${attval.valStr}"/>
                                    </c:when>
                                    <c:when test="${attval.attribute.type eq 'URL'}">
                                        <%-- todo : creer l'url  balise a     --%>
                                        <a href="${attval.valStr}">${attval.valStr}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="">error! no value found</label>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            <br/>
            <c:if test="${canEdit eq true}">         
            <a class="y-button y-button-white" href="itemmgmt?coll=${curItem.collection.idYCOLLECTION}&type=${curItem.type.getIdYITEMTYPE()}&edit=${curItem.getIdYITEM()}">
            &Eacute;diter cet objet</a> 
            </c:if>
            <c:if test="${canDelete eq true}">
            <a class="y-button y-button-white" id="deleteItem" rel="#confirm">Supprimer cet objet</a>
            <form id="deleteitemform" action="itemmgmt" method="post">
                <input type="hidden" name="itemId" value="${curItem.idYITEM}"/>
                <input type="hidden" name="type" value="${curItem.type.idYITEMTYPE}"/>
                <input type="hidden" name="coll" value="${curItem.collection.idYCOLLECTION}"/>
                <input type="hidden" name="delete" value="delete"/>
            </form>
            </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>

<%-- Modal dialogs --%>
<%-- confirm dialog --%>
<div class="modal modal-info whitebox" id="confirm">
    <header>
        <h1><strong>Confirmation</strong> attendue</h1>
    </header>
    <p>
        Vous effectuez une <strong>action</strong> qui demande une <strong>confirmation</strong>. Si vous souhaitez continuer, <strong>l'objet sera d&eacute;finitivement supprim&eacute;</strong> !
    </p>
    
    <p>
        <button class="close y-button y-button-red confirm-yes"> oui </button>
        <button class="close y-button y-button-blue"> non </button>
    </p>
</div>

<script type="text/javascript">
$(document).ready(function(){

// trigger pour la suppression d'une collection
var trigger = $('#deleteItem').overlay({

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
            $("#deleteitemform").submit();
        }
});
});
</script>
