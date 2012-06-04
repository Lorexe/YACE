<%-- 
    Document   : item-addedit
    Created on : 01 juin 2012
    Author     : Scohy Jérôme <scohy.jerome@gmail.com>
--%>

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
        
        <aside id="search_result"> </aside>
            
        <form method="post" action="itemmgmt">
            <input type="hidden" name="coll" value="${idColl}"/>
            <input type="hidden" name="type" value="${idType}"/>
            <c:if test="${!empty edit}">
                <input type="hidden" name="edit" value="${edit}"/>
            </c:if>
            <table class="y-table y-table-form y-table-center">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <td colspan="3">
                            <c:choose>
                                <c:when test="${empty edit}">
                                    <input type="submit" name="button_add" value="Ajouter l'objet" class="y-button y-button-white" />
                                </c:when>
                                <c:otherwise>
                                    <input type="submit" name="button_edit" value="Editer l'objet" class="y-button y-button-white" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tfoot>
                <tbody>
                    <c:forEach var="attr" items="${attributes.rows}" varStatus="counter">
                        <tr <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                            <td>${attr.name}</td>
                            <c:choose>
                                <c:when test="${attr.type=='String'}">
                                    <td><input type="text" id="attr_${attrsName.get(counter.count-1)}" name="attr_${attrsName.get(counter.count-1)}" size="30" required <c:if test="${!empty edit}">value="${itemValues.get(counter.count-1).getValStr()}"</c:if> /></td>
                                </c:when>
                                <c:otherwise>
                                    <td><input type="text" id="attr_${attrsName.get(counter.count-1)}" name="attr_${attrsName.get(counter.count-1)}" size="30" required <c:if test="${!empty edit}">value="${itemValues.get(counter.count-1).getValStr()}"</c:if> /></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
           
        <c:if test="${!empty autocomplete}">
            <div id="search_form">
                Recherche <input type="text" name="search_input" id="search_input" />
                <c:choose>
                    <c:when test="${autocomplete=='film'}">
                        <button type="button" onclick='getMovies("attr_")' class="y-button y-button-white">Rechercher</button>
                    </c:when>
                    <c:when test="${autocomplete=='music'}">
                        <button type="button" onclick='getAlbums("attr_")' class="y-button y-button-white">Rechercher</button>
                    </c:when>
                    <c:when test="${autocomplete=='book'}">
                        <br/>
                        <button type="button" onclick='getBooks("attr_", "fr")' class="y-button y-button-white">Rechercher en Francais</button>
                        <button type="button" onclick='getBooks("attr_", "en")' class="y-button y-button-white">Rechercher en Anglais</button>
                    </c:when>
                </c:choose>
                <span id="searching">&nbsp;</span>
            </div>
        </c:if>
    </section>
</section>
<c:if test="${!empty autocomplete}">
    <script type="application/javascript" src="./theme/default/script/Autocomplete/ac-${autocomplete}.js"></script>
</c:if>