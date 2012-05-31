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
                -->
            <c:forEach var="attval" items="${attributevalues}">
                <label for="attrval{attval.idYATTRIBUTEVALUE}">${attval.valStr}</label>
                <label >${attval.attribute.name}</label>
                <br/>
            </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</section>
    
</section>
    
<div id="foreground"></div>
