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
    
    <h3>Les Résultats de recherche pour : <b>${searched}</b></h3>
    <br/>
    <strong>${searchtype}</strong>
    <br/><br/>
    <c:choose>
        <c:when test="${empty resultlist}">
            <p>Aucun objet trouvé</p>
        </c:when>
        <c:otherwise>            
            <c:forEach var="item" items="${resultlist}">   
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

                    <!-- POUR LE FIGCAPTION SUIVANT ==> PREVOIR TAILLE CONTENU MAXIMALE -->
                    <figcaption title="${item.yattributevalueCollection.get(1).valStr}">
                        ${item.yattributevalueCollection.get(1).valStr}
                    </figcaption>
                </figure>        
            </c:forEach>
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>