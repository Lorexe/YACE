<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>
            &Agrave; propos de <strong>Ya<em class="CE">ce</em></strong>
        </h1>
    </header>

    <section class="content">
        <aside id="toggletips"><strong>A I D E</strong></aside>
        
        <h1>Contact</h1>
        <c:if test="${!empty messageInfos}">
            <div class="output info">${messageInfos}</div>
        </c:if>
        <c:if test="${!empty messageError}">
            <div class="output warning">${messageError}</div>
        </c:if>
        
        <p>Utilisez le formulaire ci-dessous pour nous envoyer des suggestions, questions ou autres commentaires.</p>
        <%-- <form action="mailto:admin@yace.com?subject=Message provenant de YaCE!" method="post" enctype="text/plain"> --%>
        <form action="about" method="post">
            <table class="y-table y-table-form">
                <tr class="odd">
                    <td><b>Votre nom:</b></td>
                    <td><input name="name" size="20" value="${user.pseudo}" placeholder="Jacques Dupont"></td>
                </tr>
                <tr>
                    <td><b>Votre email:</b></td>
                    <td><input name="email" size="20" value="${user.email}" placeholder="j.dupont@gmail.com"></td>
                </tr>
                <tr class="odd">
                    <td><b>Sujet:</b></td>
                    <td><input name="subject" size="20" placeholder="Id�e d'am�lioration"></td>
                </tr>
                <tr>
                    <td><b>Message:</b></td>
                    <td><textarea name="msg"></textarea></td>
                </tr>
                <tr class="odd">
                    <td><input class="y-button y-button-blue" type="submit" value="J'envoie le message"/></td>
                    <td><input class="y-button y-button-white" type="reset" value="Je recommence"/></td>
                </tr>
            </table>
        </form>
                
        <h1>${pageTitle}</h1>
        <p>Ya<em class="CE">ce</em>! est un gestionnaire de collection d�velopp� dans le cadre d'un projet scolaire.</p>
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