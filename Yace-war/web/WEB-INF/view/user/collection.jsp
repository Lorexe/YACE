<%-- 
    Document   : collection
    Created on : 31 mai 2012, 19:43:57
    Author     : Pegazz <la101576 at student.helha.be>
--%>

<section id="main" class="whitebox"> <!-- main panel -->

    <sql:query var="collname" dataSource="Yacedb">
        SELECT * FROM Ycollection WHERE ycollection.idYCOLLECTION = ?
        <sql:param value="${collection.getIdYCOLLECTION()}"/>
    </sql:query>

    <sql:query var="itemtypes" dataSource="Yacedb">
        SELECT DISTINCT idYITEMTYPE, name FROM yitemtype yit
        JOIN yitem y ON yit.idYITEMTYPE = y.type
        WHERE y.collection = ?
        <sql:param value="${collection.getIdYCOLLECTION()}"/>
    </sql:query>


    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>
            Consultation de <strong>${collname.rows[0].theme}</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intÃ©ressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <c:forEach var="itemtype" items="${itemtypes.rows}">

            <h1>${itemtype.name}</h1>         
            <%-- Faut chopper les attributs pour l'itemtype et commencer le tableau --%>
            <sql:query var="tabheaders" dataSource="Yacedb">
                SELECT * FROM yattribute yat WHERE yat.itemtype = ? ORDER BY no_order ASC
                <sql:param value="${itemtype.idYITEMTYPE}"/>
            </sql:query>

            <table class="y-table">
                <tr>
                    <c:forEach var="tabheader" items="${tabheaders.rows}">
                        <td>${tabheader.name}</td>
                    </c:forEach> 
                </tr>

                <%-- Ensuite on chope tous les items de la collection et de ce type là --%>
                
                <sql:query var="objects" dataSource="Yacedb">
                    SELECT * FROM yitem yit WHERE collection = ? AND type = ?
                    <sql:param value="${collection.getIdYCOLLECTION()}"/>
                    <sql:param value="${itemtype.idYITEMTYPE}"/>
                </sql:query>

                <c:forEach var="item" items="${objects.rows}">
                    <tr>
                        <sql:query var="attrvals" dataSource="Yacedb">
                            SELECT yatv.val_str FROM yattributevalue yatv WHERE yatv.attribute IN (
                                SELECT idYATTRIBUTE FROM yattribute yat WHERE itemtype = ? ORDER BY no_order ASC
                            ) AND yatv.idYATTRIBUTEVALUE IN (
                                SELECT lnk.value FROM link_attr_item lnk WHERE lnk.item = ?
                            )
                            <sql:param value="${itemtype.idYITEMTYPE}"/>
                            <sql:param value="${item.idYITEM}"/>
                        </sql:query>
                            <c:forEach var="val" items="${attrvals.rows}">
                                <td>
                                    ${val.val_str}
                                </td>
                            </c:forEach>
                    </tr>                    
                </c:forEach>

            </table>
        </c:forEach>

    </section>

</section>

<div id="foreground"></div>
