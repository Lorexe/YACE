<%-- 
    Document   : collection
    Created on : 31 mai 2012, 19:43:57
    Author     : Pegazz <la101576 at student.helha.be>
--%>

<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>
            Consultation de <strong>${collection.getTheme()}</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <c:forEach var="itemtype" items="${itemtypes}" varStatus="idit">

            <h1>${itemtype.getName()}</h1>         

            <table class="y-table">
                <%-- Noms des champs --%>
                <tr>
                    <c:forEach var="tabheader" items="${attributes.get(idit.count - 1)}">
                        <td>${tabheader.name}</td>
                    </c:forEach>

                </tr>
                <%-- Remplissage --%>
                <c:forEach var="item" items="${values.get(idit.count - 1)}" varStatus="idi">
                    <tr>
                        <c:forEach var="val" items="${values.get(idit.count - 1).get(idi.count-1)}">
                            <td>
                                ${val.valStr}
                            </td>
                        </c:forEach>
                    </tr>                    
                </c:forEach>

            </table>
        </c:forEach>

    </section>

</section>

<div id="foreground"></div>
