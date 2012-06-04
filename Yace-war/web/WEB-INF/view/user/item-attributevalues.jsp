<%-- 
    Document   : item-attributevalues
    Created on : 31 mai 2012, 22:27:31
    Author     : Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
--%>

<section id="main" class="whitebox"> <!-- main panel -->
<header>
    <h1>${pageTitle}</h1>
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
                <label ><strong>Type d'objet  : ${curItem.type.name}</strong></label><br/>
                <label ><strong>Propri&eacute;taire  : ${curItem.collection.owner.pseudo}</strong></label><br/><br/>
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
                                        <!-- todo : afficher l'image   balise img    -->
                                        <img for="attrval${attval.idYATTRIBUTEVALUE}" class="attr-cover" src="${attval.valStr}"/>
                                    </c:when>
                                    <c:when test="${attval.attribute.type eq 'URL'}">
                                        <!-- todo : creer l'url  balise a     -->
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
            
            <c:if test="${canEdit eq true}">         
            <a class="y-button y-button-white" href="itemmgmt?coll=${curItem.collection.idYCOLLECTION}&type=${curItem.type.getIdYITEMTYPE()}&edit=${curItem.getIdYITEM()}">
            &Eacute;diter cet objet</a>
            </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>
