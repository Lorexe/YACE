<section id="main" class="whitebox"> <!-- main panel -->

<header>
    <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
    <h1>${pageTitle}</h1>
</header>

<section class="content"> <!-- contenu intéressant -->
    <aside id="toggletips"><strong>A I D E</strong></aside>
    <form name="editcollection" method="POST" action="wizard">
        
        <c:choose>
            <c:when test="${empty param.u}">
                <h1>Choisissez parmi vos collections</h1>
            </c:when>
            <c:otherwise>
                <sql:query var="dbuser" dataSource="Yacedb">
                    SELECT * FROM yuser WHERE yuser.idYUSER = ?
                    <sql:param value="${param.u}"/>
                </sql:query>
                <h1>Choisissez parmi les collections de <strong>${dbuser.rows[0].pseudo}</strong></h1>
            </c:otherwise>
        </c:choose>

        <div class="radios">
            <c:forEach var="collection" items="${collections}">
                <input type="radio" name="collection" id="collection${collection.idYCOLLECTION}" value="${collection.idYCOLLECTION}" required="required"/>
                <label for="collection${collection.idYCOLLECTION}">${collection.theme}</label>
                <br/>
            </c:forEach>
        </div>

        <input type="submit" class="y-button y-button-white" value="J'ai choisi !"/>
    </form>
</section>

</section>
