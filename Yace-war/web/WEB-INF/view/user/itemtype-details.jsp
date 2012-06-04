<%-- 
    Document   : itemtype-details
    Created on : 4 juin 2012, 19:29:31
    Author     : Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
--%>

<section id="main" class="whitebox"> <!-- main panel -->
<header>
    <h1>${pageTitle}</h1>
</header>
<section class="content">
    <aside id="toggletips"><strong>A I D E</strong></aside>
    
    <c:choose>
        <c:when test="empty ytypedet">
            <p class="search-header">Aucune valeur disponible<br/>
            Type d'objet inconnu.
            </p>
        </c:when>
        <c:otherwise>
            <h3>${ytypedet.name}</h3><br/>
            <p class="search-header">
                <c:choose>
                    <c:when test="${ytypedet.isPublic() eq true}">
                        Type d'objet  : <b>Public</b>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${ytypedet.collection.getIsPublic() eq true}">
                                <a href="see?idCollection=${ytypedet.collection.idYCOLLECTION}">
                                    <label><strong> Type d'objet de collection  : ${ytypedet.collection.theme}</strong></label>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <label><strong> Type d'objet de collection  : ${ytypedet.collection.theme}</strong></label>
                            </c:otherwise>
                        </c:choose>
                        <br/><br/><br/>
                    </c:otherwise>
                </c:choose>
                <br/>
                L'objet ${ytypedet.name} possede <b>${fn:length(ytypedet.yattributeCollection)}</b> attributs.
                <br/>
            </p>
            <h3>Les Attributs</h3>
            <table class="y-table">
                <thead>
                    <tr>
                        <th><strong>Nom</strong></th>
                        <th><strong>Type</strong></th>
                        <th><strong>Ordre</strong></th>
                    </tr>
                </thead>
            <c:forEach var="detattribute" items="${ytypedet.yattributeCollection}" varStatus ="attrcount">
                <tr <c:if test="${attrcount.count % 2 == 0}">class="odd"</c:if>>
                    <td>
                        <label><b>${detattribute.name}</b></label>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${detattribute.type eq 'String'}">
                                <label><b>Texte</b></label>
                            </c:when>
                            <c:when test="${detattribute.type eq 'Image'}">
                                <label><b>Image</b></label>
                            </c:when>
                            <c:when test="${detattribute.type eq 'URL'}">
                                <label><b>Lien</b></label>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <label><b>${detattribute.noOrder}</b></label>
                    </td>
                </tr>
            </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
    
    
</section>
    
</section>
    
<div id="foreground"></div>
