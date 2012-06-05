<%-- 
    Document   : collection
    Created on : 31 mai 2012, 19:43:57
    Author     : Pegazz <la101576 at student.helha.be>
--%>

<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>
            Consultation de <strong>${collection.getTheme()}</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intÃ©ressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        
        <c:if test="${!empty user && user eq collection.owner}">
            <a class="y-button y-button-green" href="itemtypemgmt?coll=${collection.getIdYCOLLECTION()}">J'ajoute un type d'objet</a>
            <br/><br/>
        </c:if>
            
        <c:if test="${empty user || user != collection.owner}">
            <p>Cette collection appartient à <strong>${collection.owner.pseudo}</strong></p>
        </c:if>
        
        <%-- Ajout d'objet de typeitem public --%>
        <c:if test="${!empty user && user eq collection.owner && !empty itemtypesPublic && itemtypesPublic!=null}">
            <form id="form_itemtype_public" action="itemmgmt" method="get">
                <input type="hidden" name="coll" value="${collection.getIdYCOLLECTION()}"/>
                <select name="type">
                    <c:forEach var="type" items="${itemtypesPublic}" varStatus="counter">
                        <option value="${type.getIdYITEMTYPE()}">${type.getName()}</option>
                    </c:forEach>
                </select>
                <input type="submit" class="y-button y-button-white" value="Ajouter un objet"/>
            </form>
            <br/><br/>
        </c:if>
        
        <c:forEach var="itemtype" items="${withoutItem}" varStatus="idit">
            <h1>${itemtype.getName()}</h1>
            <c:choose>
                <c:when test="${!empty user && user eq collection.owner}">
                    Vous n'avez pas encore d'objets de ce type ? Cliquez ici pour <a class="y-button y-button-blue" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}">ajouter le premier</a> .<br/>
                    Vous pouvez aussi <button class="y-button y-button-blue" id="deleteType" rel="#confirmType" onclick="delItemtype(${itemtype.getIdYITEMTYPE()})">supprimer ce type</button> d'objet si vous n'en avez pas l'utilité.
                </c:when>
                <c:otherwise>Aucun objet dans ce type</c:otherwise>
            </c:choose>
            <br/><br/>
        </c:forEach>
            
            
        <c:forEach var="itemtype" items="${itemtypes}" varStatus="idit">

            <h1>${itemtype.getName()}
                <c:if test="${!empty user && user eq collection.owner}">
                    <a class="y-button y-button-blue" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}">
                        J'ajoute un objet de ce type
                    </a>
                    
                    <c:if test="${!itemtype.isPublic()}">
                        <button class="y-button y-button-blue" id="deleteType" rel="#confirmType" onclick="delItemtype(${itemtype.getIdYITEMTYPE()})">Je supprime ce type</button>
                    </c:if>
                </c:if>
            </h1>

            <c:forEach var="item" items="${values.get(idit.count - 1)}" varStatus="idi">

                <figure class="cover" id="item-${idit.count}-${idi.count}">
                    <aside class="item-details">
                        <a href="details?item=${items.get(idit.count-1).get(idi.count-1).getIdYITEM()}">
                            <strong>D&eacute;tails</strong>
                        </a>
                    </aside>

                    <c:choose>
                        <c:when test="${empty values.get(idit.count - 1).get(idi.count-1).get(0).valStr}">
                            <img alt="" src="./theme/default/img/icon/image_128.png"/>
                        </c:when>
                        <c:otherwise>
                            <img alt="" src="${values.get(idit.count - 1).get(idi.count-1).get(0).valStr}"/>
                        </c:otherwise>
                    </c:choose>

                    <figcaption title="${values.get(idit.count-1).get(idi.count-1).get(1).valStr}">
                        ${values.get(idit.count-1).get(idi.count-1).get(1).valStr}
                    </figcaption>
                </figure>

            </c:forEach>
        </c:forEach>

    </section>

</section>

<div id="foreground"></div>

<c:forEach var="itemtype" items="${itemtypes}" varStatus="idit">
    <c:forEach var="item" items="${values.get(idit.count - 1)}" varStatus="idi">
        <div role="preview" id="prev-item-${idit.count}-${idi.count}" style="display: none; ">
            <section class="splash whitebox">
                <header>
                    <h1>Détails de l'élément</h1>
                </header>
                <section class="content">
                    <h1>${values.get(idit.count-1).get(idi.count-1).get(1).valStr}</h1>
                    <table class="y-table">
                        <c:forEach var="attribut" items="${attributes.get(idit.count-1)}" varStatus="attrcount">
                            <tr <c:if test="${attrcount.count % 2 == 0}">class="odd"</c:if>>
                                    <td>
                                    ${values.get(idit.count-1).get(idi.count-1).get(attrcount.count-1).attribute.name}
                                </td>
                                <c:choose>
                                    <c:when test="${values.get(idit.count-1).get(idi.count-1).get(attrcount.count-1).attribute.type == 'Image'}">
                                        <td>
                                            <img class="imgfix" src="${values.get(idit.count-1).get(idi.count-1).get(attrcount.count-1).valStr}"/>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            ${values.get(idit.count-1).get(idi.count-1).get(attrcount.count-1).valStr}
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${!empty user && user eq collection.owner}">
                        <a class="y-button y-button-white" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}&edit=${items.get(idit.count-1).get(idi.count-1).getIdYITEM()}">
                            Éditer cet objet
                        </a> 
                        <button class="y-button y-button-white" id="deleteItem" rel="#confirmItem" onclick="delItem(${items.get(idit.count-1).get(idi.count-1).getIdYITEM()}, ${itemtype.getIdYITEMTYPE()})">Supprimer cette objet</button>
                    </c:if>
                </section>
            </section>
        </div>
    </c:forEach>
</c:forEach>

<!-- Modal dialogs -->
<!-- confirm dialog -->
<div class="modal modal-info whitebox" id="confirmType">
    <header>
        <h1><strong>Confirmation</strong> attendue</h1>
    </header>
    <p>
        Vous effectuez une <strong>action</strong> qui demande une <strong>confirmation</strong>. Si vous souhaitez continuer, <strong>tous les objets de ce type seront perdus</strong> !
    </p>
    
    <p>
        <button class="close y-button y-button-red confirm-yes"> oui </button>
        <button class="close y-button y-button-blue"> non </button>
    </p>
</div>

<div class="modal modal-info whitebox" id="confirmItem">
    <header>
        <h1><strong>Confirmation</strong> attendue</h1>
    </header>
    <p>
        Vous effectuez une <strong>action</strong> qui demande une <strong>confirmation</strong>. Si vous souhaitez continuer, <strong>l'objet sera définitivement supprimé</strong> !
    </p>
    
    <p>
        <button class="close y-button y-button-red confirm-yes"> oui </button>
        <button class="close y-button y-button-blue"> non </button>
    </p>
</div>

<form name="deleteType" action="itemtypemgmt" method="post">
    <input type="hidden" id="itemtypeId" name="itemtypeId" value="" />
    <input type="hidden" name="coll" value="${collection.getIdYCOLLECTION()}" />
</form>

<form name="deleteItem" action="itemmgmt" method="post">
    <input type="hidden" id="itemId" name="itemId" value="" />
    <input type="hidden" id="del_itemTypeId" name="type" value="" />
    <input type="hidden" name="coll" value="${collection.getIdYCOLLECTION()}" />
</form>

<script type="text/javascript">
$(document).ready(function(){
    var yesnobuttonsType = $('#confirmType button').click(function(e){
            // récupère le bouton cliqué (le premier dans le flux)
            var yes = yesnobuttonsType.index(this) === 0;
            if(yes) {
                var deletionIndicator = document.createElement("input");
                $(deletionIndicator)
                    .attr("type","hidden")
                    .attr("name","delete")
                    .attr("value","delete");


                $("form[name='deleteType']")
                    .append(deletionIndicator)
                    .submit();
            }
    });
    
    var yesnobuttonsItem = $('#confirmItem button').click(function(e){
            // récupère le bouton cliqué (le premier dans le flux)
            var yes = yesnobuttonsItem.index(this) === 0;
            if(yes) {
                var deletionIndicator = document.createElement("input");
                $(deletionIndicator)
                    .attr("type","hidden")
                    .attr("name","delete")
                    .attr("value","delete");


                $("form[name='deleteItem']")
                    .append(deletionIndicator)
                    .submit();
            }
    });
    
    var trigger = $('#deleteType').overlay({
        mask: {
            color: '#000033',
            loadSpeed: 150,
            opacity: 0.5
	},
	closeOnClick: false});
    
    var triggers = $('#deleteItem').overlay({
        mask: {
            color: '#000033',
            loadSpeed: 150,
            opacity: 0.5
	},
	closeOnClick: false});
});

function delItemtype(id) {
    $("#itemtypeId").val(id);
}

function delItem(idItem, idItemtype) {
    $("#itemId").val(idItem);
    $("#del_itemTypeId").val(idItemtype);
    
   console.log(idItem + " " + idItemtype);
}
</script>