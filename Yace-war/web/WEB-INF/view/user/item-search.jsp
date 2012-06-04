<%-- 
    Document   : item-search
    Created on : 2 juin 2012, 15:54:57
    Author     : Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
--%>

<section id="main" class="whitebox"> <!-- main panel -->
<header>
    <h1>${pageTitle}</h1>
</header>
<section class="content">
    <aside id="toggletips"><strong>A I D E</strong></aside>
    
    <h3>Les Résultats de recherche pour : "<b>${searched}</b>"</h3>
    <c:if test="${totalsize eq 0}"><c:set var="totalsize" value="1"/></c:if>
    <h4>Page :  ${searchpagenumber} sur ${totalsize} page(s)</h4>
    <p class="search-header">
    <c:choose>
        <c:when test="${searchtype eq 'mycolls'}">
            <strong>Mes collections</strong>
        </c:when>
        <c:when test="${searchtype eq 'all'}">
            <strong>Collections publiques</strong>
        </c:when>
        <c:when test="${searchtype eq 'thiscoll'}">
            <strong>Collection ${resultlist.get(0).collection.theme}</strong>
        </c:when>
    </c:choose>
    </p>
    <br/>
    <c:choose>
        <c:when test="${empty resultlist}">
            <p><strong>Aucun objet trouvé. </strong><br/>
               Saisissez un autre mot clé et rélancez la recherche.
            </p>
        </c:when>
        <c:otherwise>
            <c:set var="colId" value="${resultlist.get(0).collection.getIdYCOLLECTION()}"/>
            <a href="see?idCollection=${resultlist.get(0).collection.idYCOLLECTION}"><label><strong>${resultlist.get(0).collection.theme}</strong></label></a>
            <br/><br/>
            <c:forEach var="item" items="${resultlist}">   
                <c:choose>
                    <c:when test="${colId ne item.collection.getIdYCOLLECTION()}">
                        <c:set var="colId" value="${item.collection.getIdYCOLLECTION()}"/>
                        <br/>
                        <a href="see?idCollection=${item.collection.idYCOLLECTION}"><label><strong>${item.collection.theme}</strong></label></a>
                        <br/><br/>
                    </c:when>
                </c:choose>
                
                
                <figure class="cover" id="item-${item.type.getIdYITEMTYPE()}-${item.getIdYITEM()}">
                    <aside class="item-details">
                        <a href="details?item=${item.getIdYITEM()}&clr=${searched}">
                            <strong>Détails</strong>
                        </a>
                    </aside>
                    <c:choose>
                        <c:when test="${empty item.yattributevalueCollection.get(0).valStr}">
                            <img alt="" src="./theme/default/img/icon/image_128.png"/>
                        </c:when>
                        <c:otherwise>
                            <img alt="" src="${item.yattributevalueCollection.get(0).valStr}"/>
                        </c:otherwise>
                    </c:choose>
                    <figcaption title="${item.yattributevalueCollection.get(1).valStr}">
                        ${item.yattributevalueCollection.get(1).valStr}
                    </figcaption>
                </figure>        
            </c:forEach>
            <br/><br/>
            <c:choose>
                <c:when test="${totalsize > 1}">
                <form name="searchNav" action="search" method="get" title="Navigation dans les Résultats">
                    <c:choose>
                        <c:when test="${searchpagenumber > 1}">
                            <input type="submit" name="searchprev" value="Page précedénte" class="y-button y-button-white" />
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${searchpagenumber < totalsize}">
                            <input type="submit" name="searchnext" value="Page suivante" class="y-button y-button-white" />
                        </c:when>
                    </c:choose>
                    <input type="hidden" name="searchword" value="${searched}"/>
                    <input type="hidden" name="searchdomain" value="${searchtype}"/>
                    <!-- navigation parmi les résultats -->
                    <input type="hidden" name="firstres" value="${firstres}"/>
                    <input type="hidden" name="totalsize" value="${totalsize}"/>
                    <c:choose>
                        <c:when test="${searchtype eq 'thiscoll'}">
                            <input type="hidden" name="searchcoll" value="${searchcoll}"/>
                        </c:when>
                    </c:choose>
                    
                </form>
                </c:when>
            </c:choose>      
        </c:otherwise>
    </c:choose>
</section>
   
</section>
    
<div id="foreground"></div>

    <c:forEach var="item" items="${resultlist}" varStatus="idi">
        <div role="preview" id="prev-item-${item.type.getIdYITEMTYPE()}-${item.getIdYITEM()}"  style="display: none; ">
            <section class="splash whitebox">
                <header>
                    <h1>Aperçu de l'élément</h1>
                </header>
                <section class="content">
                    <table class="y-table">
                        <!-- 
                            pour l'aperçu, je limite le nombre des attributs à afficher à max 5
                            au cas où l'itemtype a trop d'attributs et ça rique de deborder
                            pour voir l'ensemble des attributs consulter page details
                        -->
                        <c:choose>
                            <c:when test="${fn:length(item.yattributevalueCollection) < 6}">
                                <c:set var="maxloop" value="${fn:length(item.yattributevalueCollection)}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="maxloop" value="${5}"/>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="i" begin="0" end="${maxloop}" step="1" varStatus ="attrcount">
                            <tr <c:if test="${attrcount.count % 2 == 0}">class="odd"</c:if>>
                                <td>
                                    ${item.yattributevalueCollection.get(i).attribute.name}
                                </td>
                                <c:choose>
                                    <c:when test="${item.yattributevalueCollection.get(i).attribute.type == 'Image'}">
                                        <td>
                                            <img class="imgfix" src="${item.yattributevalueCollection.get(i).valStr}"/>
                                        </td>
                                    </c:when>
                                    <c:when test="${item.yattributevalueCollection.get(i).attribute.type == 'URL'}">
                                        <td>
                                            <a href="${item.yattributevalueCollection.get(i).valStr}">Link</a>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            <!-- couper un string trop long, max x caracteres -->
                                            <c:set var="maxstrlen" value="250"/>
                                            <c:set var="valStrcut" value="${item.yattributevalueCollection.get(i).valStr}"/>
                                            <c:if test="${fn:length(valStrcut) > maxstrlen}">
                                                <c:set var="valStrcut" value="${fn:substring(item.yattributevalueCollection.get(i).valStr,0,maxstrlen)} ..."/>
                                            </c:if>
                                            ${valStrcut}
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                        </c:forEach>
                    </table>
                    <a class="y-button y-button-white" href="details?item=${item.getIdYITEM()}&clr=${searched}">
                        <strong>Tous les Details de l'Objet</strong>
                    </a>
                </section>
            </section>
        </div>
    </c:forEach>