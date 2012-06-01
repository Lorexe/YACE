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
    <c:choose>
        <c:when test="${empty attributevalues}">
            <p>Aucune valeur disponible</p>
        </c:when>
        <c:otherwise>
            <div>
                <!-- 
                debut affichage attributevalues d'un item
                
                todo : affichage intelligent en fonction de attribute type
                
                - affichage sous forme de tableau? Espace plus grand pour description
                
                -only attribute valStr, URL et Image
                
                -navigation dans la liste des items publiques? de cette même colelction
                
                -->
            <c:forEach var="attval" items="${attributevalues}">
                <label >${attval.attribute.name}</label>&nbsp;&nbsp;
                <c:choose>
                    <c:when test="${attval.attribute.type eq 'String'}">
                        <label for="attrval${attval.idYATTRIBUTEVALUE}">${attval.valStr}</label>
                    </c:when>
                    <c:when test="${attval.attribute.type eq 'Image'}">
                        <!-- todo : afficher l'image   balise img    -->
                        <img for="attrval${attval.idYATTRIBUTEVALUE}" src="${attval.valStr}"></img>
                    </c:when>
                    <c:when test="${attval.attribute.type eq 'URL'}">
                        <!-- todo : creer l'url  balise a     -->
                        <a href="${attval.valStr}">Lien</a>
                    </c:when>
                    <c:otherwise>
                        <label for="">error! no value found</label>
                    </c:otherwise>
                </c:choose>
                <br/><br/>
            </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>
