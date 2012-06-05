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

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        
        <c:if test="${!empty user && user eq collection.owner}">
            <a class="y-button y-button-green" href="itemtypemgmt?coll=${collection.getIdYCOLLECTION()}">J'ajoute un type d'objet</a>
            <br/><br/>
        </c:if>
            
        <c:if test="${empty user || user != collection.owner}">
            <p>Cette collection appartient � <strong>${collection.owner.pseudo}</strong></p>
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
        
        <c:if test="${!empty user && user eq collection.owner}">
            <c:forEach var="itemtype" items="${withoutItem}" varStatus="idit">
                <h1>${itemtype.getName()}
                    <a class="y-button y-button-blue" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}">
                        J'ajoute un objet de ce type
                    </a>
                </h1>

                <p>
                    Vous n'avez pas encore d'objet de ce type ? <img class="upicon" src="./theme/default/img/img_trans.gif" /> Cliquez ci-dessus pour en ajouter un !
                </p>
            </c:forEach>
        </c:if>
            
        <c:forEach var="itemtype" items="${itemtypes}" varStatus="idit">

            <h1>${itemtype.getName()}
                <c:if test="${!empty user && user eq collection.owner}">
                    <a class="y-button y-button-blue" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}">
                        J'ajoute un objet de ce type
                    </a>
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
                    <h1>D�tails de l'�l�ment</h1>
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
                            �diter cet objet
                        </a>
                    </c:if>
                </section>
            </section>
        </div>
    </c:forEach>
</c:forEach>
