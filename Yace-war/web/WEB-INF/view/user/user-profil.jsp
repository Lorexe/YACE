<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>
            Modifier ses <strong>param&ecirc;tres de connexion</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <form method="POST" action="#">
            <table class="y-table y-table-form">
                <tbody>
                    <tr class="odd">
                        <td>*<label for="pseudo">Nom d'utilisateur :</label></td>
                        <td><input type="text" name="pseudo" value="${user.pseudo}" placeholder="Requis" required="required" /></td>
                    </tr>
                    <tr>
                        <td>*<label for="email">Email :</label></td>
                        <td><input type="text" name="email" value="${user.email}" placeholder="Requis" required="required" /></td>
                    </tr>
                    <tr class="odd">
                        <td><label for="newpwd">Nouveau mot de passe :</label></td>
                        <td><input name="newpwd" type="password" /></td>
                    </tr>
                    <tr>
                        <td><label for="newpwd-verif">Nouveau mot de passe (bis) :</label></td>
                        <td><input name="newpwd-verif" type="password" /></td>
                    </tr>
                    <tr class="odd">
                        <td>*<label for="pwd">Mot de passe actuel :</label></td>
                        <td><input name="pwd" type="password" placeholder="Requis" required="required" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" class="y-button y-button-blue" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <% if (request.getAttribute("error") != null) {%>
        <output id="out1" class="warning output"><%= request.getAttribute("error")%></output>
        <% } else if (request.getAttribute("info") != null) {%>
        <output id="out1" class="info output"><%= request.getAttribute("info")%></output>
        <% } else {%>
        <output id="out1" class="hidden"></output>
        <% }%>
    </section>
</section>
