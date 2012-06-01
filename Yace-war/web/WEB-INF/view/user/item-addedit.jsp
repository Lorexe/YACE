<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>${pageHeaderTitle}</h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <sql:query var="attributes" dataSource="Yacedb">
            SELECT * FROM Yattribute WHERE itemtype = ?
            <sql:param value="${idType}"/>
        </sql:query>

        <form method="post" action="itemmgmt">
            <input type="hidden" name="coll" value="${idColl}"/>
            <input type="hidden" name="type" value="${idType}"/>
            <table class="y-table y-table-form y-table-center">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tfoot><tr><td rowspan="2"><input type="submit" name="button_add" value="Ajouter l'objet" class="y-button y-button-white" /></td></tr></tfoot>
                <tbody>
                    <c:forEach var="attr" items="${attributes.rows}" varStatus="counter">
                        <tr <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                            <td>${attr.name}</td>
                            <c:choose>
                                <c:when test="${attr.type=='String'}">
                                    <td><input type="text" name="attr_${attr.name}" size="30" required/></td>
                                </c:when>
                                <c:otherwise>
                                    <td><input type="text" name="attr_${attr.name}" size="30" required/></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </section>
</section>