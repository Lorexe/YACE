<section id="main" class="whitebox"> <!-- main panel -->

<header>
    <h1>${pageTitle}</h1>
</header>

<section class="content"> <!-- contenu intéressant -->
    <aside id="toggletips"><strong>A I D E</strong></aside>

    <c:choose>
        <c:when test="${empty param.u}">
    <form name="editcollection" method="GET" action="wizard">
            <h1>Choisissez parmi vos collections</h1>
        </c:when>
        <c:otherwise>
            <sql:query var="dbuser" dataSource="Yacedb">
                SELECT * FROM yuser WHERE yuser.idYUSER = ?
                <sql:param value="${param.u}"/>
            </sql:query>
    <form name="seecollection" method="GET" action="see">
            <h1>Choisissez parmi les collections publiques de <strong>${dbuser.rows[0].pseudo}</strong></h1>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${empty collections}">
            <p>Aucune collection disponible</p>
        </c:when>
        <c:otherwise>
            <div class="radios">
            <c:forEach var="collection" items="${collections}">
                <input type="radio" name="idCollection" id="collection${collection.idYCOLLECTION}" value="${collection.idYCOLLECTION}" required="required"/>
                <label for="collection${collection.idYCOLLECTION}">${collection.theme}</label>
                <br/>
            </c:forEach>
            </div>

            <input type="submit" class="y-button y-button-white" value="J'ai choisi !"/>
        </c:otherwise>
    </c:choose>

    </form>
</section>

</section>
