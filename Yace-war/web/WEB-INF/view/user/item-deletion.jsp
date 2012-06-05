<%-- 
    Document   : item-deletion
    Created on : 5 juin 2012, 12:08:58
    Author     : Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
--%>

<section id="main" class="whitebox"> <!-- main panel -->
<header>
    <h1>${pageTitle}</h1>
</header>
<section class="content">
    <aside id="toggletips"><strong>A I D E</strong></aside>

    <c:choose>
        <c:when test="${empty collitem}">
            <p class="search-header">
                Objet inconnu. Pas de suppression.
            </p>
        </c:when>
        <c:otherwise>
            <h3>${ytypedet.name}</h3><br/>
            <p class="search-header">
                Vous avez supprimé un <b>objet</b> de collection <strong>${collitem.theme} avec Succès</strong>.
            </p>
            <a class="y-button y-button-white" href="see?idCollection=${collitem.idYCOLLECTION}"><label><strong> Collection ${collitem.theme}</strong></label></a><br/><br/>
        </c:otherwise>
    </c:choose>
    
</section>
    
</section>
    
<div id="foreground"></div>

