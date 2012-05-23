<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>${pageTitle}</h1>
    </header>

    <section class="content"> <!-- contenu intÃ©ressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        <form name="editcollection" method="POST" action="#">
            <sql:query var="ycollections" dataSource="Yacedb">
                SELECT * FROM ycollection WHERE ycollection.owner = ?
                <sql:param value="${user.idYUSER}"/>
            </sql:query>
            <c:choose>
                <c:when test="">
                    
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>

            <h1>Choisissez une collection</h1>
            <c:choose>
                <c:when test="${!empty ycollections.rows}">
                    <%-- Si l'utilisateur possède déjà des collections --%>
                    <select name="collection">
                        <c:forEach var="ycollection" items="${ycollections.rows}">
                            <c:choose>
                                <c:when test="${ycollection.idYCOLLECTION == idCollection}">
                                    <%-- Pour présélectionner la collection --%>
                                    <option value="${ycollection.idYCOLLECTION}" selected="selected">
                                        ${ycollection.theme}
                                    </option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${ycollection.idYCOLLECTION}">
                                        ${ycollection.theme}
                                    </option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </c:when>
                <c:otherwise>
                    <%-- Si l'utilisateur ne possède encore aucune collection --%>
                    <label for="">Entrez la thématique de votre première collection</label> : <input type="text" name="theme"/>
                </c:otherwise>
            </c:choose>

            <h1>Types d'objet</h1>
            
            <input type="submit" class="y-button y-button-white" value="Je valide !"/>
        </form>
    </section>

</section>