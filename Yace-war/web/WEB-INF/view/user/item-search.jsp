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
    <h4>Page :  ${searchpagenumber}</h4>
    <br/>
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
    <br/><br/>
    <c:choose>
        <c:when test="${empty resultlist}">
            <p>Aucun objet trouvé</p>
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
                        <a href="details?item=${item.getIdYITEM()}">
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
                <c:when test="${((firstres-resultsnumber) > -1) or sizeres ne -1}">
                <form name="searchNav" action="search" method="post" title="Navigation dans les Résultats">
                    <c:choose>
                        <c:when test="${(firstres-resultsnumber) > -1}">
                            <input type="submit" name="searchprev" value="Page précedénte" class="y-button y-button-white" />
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${sizeres ne -1}">
                            <input type="submit" name="searchnext" value="Page suivante" class="y-button y-button-white" />
                        </c:when>
                    </c:choose>
                    <input type="hidden" name="searchword" value="${searched}"/>
                    <input type="hidden" name="searchdomain" value="${searchtype}"/>
                    <!-- navigation parmi les résultats -->
                    <input type="hidden" name="firstres" value="${firstres}"/>
                </form>
                </c:when>
            </c:choose>      
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>