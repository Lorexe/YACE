<!--
 Nom
        index.html
 Desc
        Page d'accueil de YaCE!
        S'y trouve l'inscription et une pr&eacute;sentation de YaCE!
 Auteur
        Bruno BOI <biddaputzese@gmail.com>
-->
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>${initParam.appName}</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <meta charset="utf-8" />

        <link rel="stylesheet" type="text/css" href="./theme/default/common.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="./theme/default/buttonsandforms.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="./theme/default/presentation_layout.css" media="screen" />

        <script src="./theme/default/script/jquery-1.7.js"></script>
        <script src="./theme/default/script/jquery.timers-1.2.js"></script>
        <script src="./theme/default/script/common.js"></script>
        <script src="./theme/default/script/jq.myslideshow.js"></script>
        <script src="./theme/default/script/mycaptcha.js"></script>

        <!--
                Le script suivant permet de faire en sorte que les nouvelles balises HTML5 s'affichent correctement sur les anciennes versions d'Internet Explorer (IE6, IE7, IE8, IE9).
        -->
        <!--[if lt IE 10]>
                <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body>
        <header role="welcome">
            <img class="yace-logo" alt="YaCE!" title="${initParam.appName}" src="./theme/default/img/img_trans.gif" />
            <aside>
                <p>vous souhaite la bienvenue</p>
            </aside>
        </header>

        <section id="tour">
            <header role="tour">
                <h1>Visite guid&eacute;e</h1>
            </header>

            <aside role="signin">
                <h1>Connexion</h1>
                <form name="connexion" action="login" method="post">
                    <input type="text" name="pseudo" maxlength="200" placeholder="Pseudo ou email" />
                    <br />
                    <input type="password" name="pwd" maxlength="200" placeholder="Mot de passe" />
                    <br />
                    <input type="submit" class="y-button y-button-blue" value="Connectez-vous" />
                </form>
                <h1>Inscription</h1>
                <form name="inscription" action="register" method="post">
                    <input type="text" name="pseudo" maxlength="200" placeholder="Nom d'utilisateur" />
                    <br />
                    <input type="text" name="email" maxlength="200" placeholder="Email valide" />
                    <br />
                    <input type="password" name="pwd" maxlength="200" placeholder="Mot de passe" />
                    <br />
                    <input type="password" name="pwd-verif" maxlength="200" placeholder="Confirmation MDP" />
                    <br />
                    <script type="text/javascript">showCaptcha();</script>
                    <input type="button" class="y-button y-button-blue" value="Enregistrez-vous" onclick="validateCaptcha()?submit():errorCaptcha()" />
                </form>
                <% if (request.getAttribute("error") != null) {%>
                <output id="out1" class="warning output"><%= request.getAttribute("error")%></output>
                <% } else if (request.getAttribute("info") != null) {%>
                <output id="out1" class="info output"><%= request.getAttribute("info")%></output>
                <% } else {%>
                <output id="out1" class="hidden"></output>
                <% }%>
            </aside>

            <div id="slideshow" class="angled stripes">

                <article class="slide">
                    <h1>Yace, c'est quoi?</h1>
                    <p>
                        <strong>Yace</strong> vous propose un outil de gestion pour vos <strong>collections personnelles</strong>. Il rend <strong>facile</strong> la gestion de vos livres, vid&eacute;os, musiques, tableaux, vins et toute autre chose. Vous avez <strong>la libert&eacute; de cr&eacute;er n'importe quel type de collection</strong>.
                    </p>
                    <p>
                        L'application est accessible <strong>en ligne</strong>, et vous offre la possibilit&eacute; de <strong>partager</strong>, si vous le d&eacute;sirez, le contenu de vos collections. Le partage se fait via un lien permanent ou via vos <strong>r&eacute;seaux sociaux</strong> favoris!
                    </p>
                </article>

                <article class="slide">
                    <h1>Accessible &agrave; tous</h1>
                    <p>
                        Yace a pour objectif de <strong>faciliter l'exp&eacute;rience utilisateur</strong>, au travers d'une <strong>interface claire et soign&eacute;e</strong> et d'une <strong>aide contextuelle et pertinente</strong>.
                    </p>
                    <p>
                        Yace dispose aussi d'un <strong>assistant</strong> d'aide &agrave; la cr&eacute;ation de collections, ce qui le distingue fortement d'un gestionnaire de bases de donn&eacute;es classique, m&ecirc;me sp&eacute;cialis&eacute;. Celui-ci vous guide pour rajouter tous les d&eacute;tails que vous d&eacute;sirez.
                    </p>
                </article>

                <article class="slide">
                    <h1>Compl&egrave;te les informations</h1>
                    <p>
                        Les types d'objets les plus courant (films, livres, CD,...) b&eacute;n&eacute;ficient donc d'une <strong>fonctionnalit&eacute; d'auto-compl&eacute;tion</strong>, r&eacute;alis&eacute;e grâce aux bases de donn&eacute;es populaires. Ces types d'objets sont <strong>personnalisable</strong>. Vous pouvez leur rajouter les informations que vous souhaitez !
                    </p>
                    <p>
                        L'auto-compl&eacute;tion r&eacute;cup&egrave;re automatiquement ses informations de sites sp&eacute;cialis&eacute;s, comme <a href="http://www.imdb.com">The Internet Movie Database</a> - base de donn&eacute;es n°1 pour les films - ou encore <a href="http://www.amazon.com">Amazon</a> - base de donn&eacute;es de r&eacute;f&eacute;rence pour les livres, musiques, films, jeux vid&eacute;os... - et beaucoup d'autres.
                    </p>
                </article>

                <article class="slide">
                    <h1>Et c'est quoi, une collection?</h1>
                    <p>
                        <em>Mais qu'entendons-nous par collection ?</em> Yace consid&egrave;re qu'une collection est un ensemble d'objets ax&eacute;s autour d'un <strong>th&egrave;me</strong> particulier. Il laisse &agrave; l'utilisateur la libert&eacute; de d&eacute;cider ce &agrave; quoi un th&egrave;me correspond : cela peut aller d'un simple <strong>type d'objets</strong> collectionn&eacute;s (par exemple des livres ou des timbres) &agrave; une collection <strong>th&eacute;matique</strong> (une collection "Tintin" par exemple) elle m&ecirc;me contenant des <strong>types d'objets</strong> divers et vari&eacute;s (dans notre exemple : des BDs, des posters, des figurines, ...).
                    </p>
                </article>

            </div>

            <footer role="tour" class="clearfix">
                <nav role="slideremote">
                    <img id="prev" alt="Pr&eacute;c&eacute;dent" title="Pr&eacute;c&eacute;dent" src="./theme/default/img/img_trans.gif" />
                    <img id="pause" alt="Pause" title="Pause" src="./theme/default/img/img_trans.gif" />
                    <img id="play" alt="Lancer" title="Lancer" src="./theme/default/img/img_trans.gif" />
                    <img id="next" alt="Suivant" title="Suivant" src="./theme/default/img/img_trans.gif" />
                </nav>
            </footer>
        </section>
    </body>
</html>