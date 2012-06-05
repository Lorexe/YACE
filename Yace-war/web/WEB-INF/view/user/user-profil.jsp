<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>
            Modifier ses <strong>param&ecirc;tres de connexion</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intÃ©ressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <form role="profile-edit" method="POST" action="#">
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
                            <input type="submit" class="y-button y-button-green" value="J'enregistre" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <div role="share">
                <div id='fb-root'></div>
                <script src='http://connect.facebook.net/en_US/all.js'></script>
                <p><a class="y-button y-button-blue" onclick='postToFeed(); return false;'>Je publie sur FACEBOOK mes collections publiques !</a></p>
                <p id='msg'></p>

                <script type="text/javascript">
                      FB.init({appId: "377846235598184", status: true, cookie: true});

                      function postToFeed() {

                        // calling the API ...
                        var obj = {
                          method: 'feed',
                          link: 'http://yace.no-ip.com/Yace-war/collections?u=${user.idYUSER}',
                          picture: 'http://yace.no-ip.com/Yace-war/theme/default/img/logo.png',
                          name: 'Collectionneur ? YaCE!',
                          caption: 'Gestionnaire de collection pour TOUS les collectionneurs !',
                          description: "YaCE!, c'est [yes] mais avec [yeah] dedans.",
                          display: 'iframe'
                        };

                        function callback(response) {
                            if (response && response.post_id) {
                                document.getElementById('msg').innerHTML = "Vous venez de partager vos collections sur votre mur Facebook !";
                            } else {
                                //document.getElementById('msg').innerHTML = "Une erreur s'est produite, veuillez réessayer !";
                            }
                        }

                        FB.ui(obj, callback);
                      }
                </script>
                <a href="collections?u=${user.idYUSER}">Copier le lien public</a> (clic-droit -> copier le lien)
            </div>
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
