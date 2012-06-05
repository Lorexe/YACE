<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>
            &Agrave; propos de <strong>Ya<em class="CE">ce</em></strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intÃ©ressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        
        <h1>Contact</h1>
        <p>Utilisez le formulaire ci-dessous pour nous envoyer des suggestions, questions ou autres commentaires.</p>
        <form action="mailto:admin@yace.com?subject=Message provenant de YaCE!" method="post" enctype="text/plain">
            <table class="y-table y-table-form">
                <tr class="odd">
                    <td><b>Votre nom:</b></td>
                    <td><input name="name" size="20" value="${user.pseudo}"></td>
                </tr>
                <tr>
                    <td><b>Email:</b></td>
                    <td><input name="email" size="20" value="${user.email}"></td>
                </tr>
                <tr class="odd">
                    <td><b>Message:</b></td>
                    <td><textarea name="msg"></textarea></td>
                </tr>
                <tr>
                    <td><input class="y-button y-button-blue" type="submit" value="J'envoie le message"/></td>
                    <td><input class="y-button y-button-white" type="reset" value="Je recommence"></td>
                </tr>
            </table>
        </form>
                
        <h1>${pageTitle}</h1>
        <p>Ya<em class="CE">ce</em>! est un gestionnaire de collection développé dans le cadre d'un projet scolaire.</p>
        <p>
            Les participants sont list&eacute;s ci-dessous:
            <ul>
                <li>Bruno <em class="CE">MaBoy</em> Boi</li>
                <li>Pierre-Guy <em class="CE">Pegazz</em> Lempereur</li>
                <li>Mikha&icirc;l <em class="CE">ChessMaster</em> Pitchugin</li>
                <li>J&eacute;r&ocirc;me <em class="CE">PHP</em> Scohy</li>
            </ul>
        </p>

    </section>

</section>