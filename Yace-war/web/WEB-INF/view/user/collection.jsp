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

        <a class="y-button y-button-blue" href="itemtypemgmt?coll=${collection.getIdYCOLLECTION()}">J'ajoute un type d'objet</a><br/><br/>

        <c:forEach var="itemtype" items="${itemtypes}" varStatus="idit">

            <h1>${itemtype.getName()} 
                <a class="y-button y-button-green" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}">
                    Nouvel objet 
                </a></h1>

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

                    <!-- POUR LE FIGCAPTION SUIVANT ==> PREVOIR TAILLE CONTENU MAXIMALE -->
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
        <div role="preview" id="prev-item-${idit.count}-${idi.count}">
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

                    <a class="y-button y-button-white" href="itemmgmt?coll=${collection.getIdYCOLLECTION()}&type=${itemtype.getIdYITEMTYPE()}&edit=${items.get(idit.count-1).get(idi.count-1).getIdYITEM()}">
                        Éditer cet objet
                    </a>

                </section>
            </section>
        </div>
    </c:forEach>
</c:forEach>
