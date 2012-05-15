<!DOCTYPE html>
<html lang="fr" class="angled stripes">
    <head>
        <title>Page Xyz - ${initParam.appName}</title>
        <link rel="shortcut icon" href="favicon.ico" />
        <meta charset="utf-8" />

        <link rel="stylesheet" type="text/css" href="./theme/default/common.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="./theme/default/buttonsandforms.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="./theme/default/master_layout.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="./theme/default/jquery.tooltip.css" media="screen" />

        <script src="./theme/default/script/jquery-1.7.js"></script>
        <!-- Custom scripts -->
        <script src="./theme/default/script/common.js"></script>
        <script src="./theme/default/script/jq.mytoggletips.js"></script>
        <script src="./theme/default/script/jq.previewsplash.js"></script>

        <!--
                Le script suivant permet de faire en sorte que les nouvelles balises HTML5 s'affichent correctement sur les anciennes versions d'Internet Explorer (IE6, IE7, IE8, IE9).
        -->
        <!--[if lt IE 10]>
                <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body>
        <header role="menu" class="yace-logo">
            <nav id="menu">
                <form name="menu" id="menubar" action="/menu" method="POST">
                    <input type="image" class="homeicon" alt="Accueil" title="Affiche votre page d'accueil" src="./theme/default/img/img_trans.gif" />
                    <input type="image" class="helpicon" alt="Aide" title="Affiche l'aide de YaCE!" src="./theme/default/img/img_trans.gif" />
                    <div id="searchbar" title="Choisissez de rechercher dans toutes vos collections ou uniquement dans celle que vous parcourez en ce moment">
                        <input type="image" class="searchicon" src="./theme/default/img/img_trans.gif" />
                        <input type="text" id="keyword" />
                        <select name="searchdomain">
                            <option label="Cette collection" value="thiscoll" />
                            <option label="Mes collections" value="all" />
                        </select>
                    </div>
                </form>
                <form action="/menu" method="POST" id="accountbar" name="account">
                    ${user.pseudo}
                    <input type="image" class="profileicon" alt="Votre compte" title="Modifiez vos informations personelles" src="./theme/default/img/img_trans.gif" />
                    <input type="image" class="exiticon" alt="D&eacute;connexion" title="D&eacute;connexion" src="./theme/default/img/img_trans.gif" />
                </form>
            </nav>
        </header>

        <aside id="explore" class="whitebox"> <!-- left panel -->
            <header>
                <h1>Navigation</h1>
            </header>

            <nav id="collview">
                <h2>Mes collections</h2>
                <input type="button" class="y-button y-button-white" value="Nouvelle collection" name="newColl" />

                <ul class="collsList">

                    <li class="closedList">
                        <a href="#">+</a> Jeux Vid&eacute;os
                        <ul class="none">
                            <li><a href="#">Jeux PS3</a></li>
                            <li><a href="#">Jeux Wii</a></li>
                            <li><a href="#">Jeux X360</a></li>
                        </ul>
                    </li>

                    <li class="closedList">
                        <a href="#">+</a> Tintin
                        <ul class="none">
                            <li><a href="#">Affiches</a></li>
                            <li><a href="#">Bandes dessin&eacute;es</a></li>
                            <li><a href="#">Dessins anim&eacute;s</a></li>
                            <li><a href="#">Figurines</a></li>
                        </ul>
                    </li>

                    <li class="openedList">
                        <a href="#">-</a> Vases
                        <ul>
                            <li><a href="#">Argiles</a></li>
                            <li><a href="#">Cuivres</a></li>
                        </ul>
                    </li>

                </ul>

            </nav>

            <nav id="detailview">
                <h2>Liste de <strong>Vases</strong></h2>
                <input type="button" class="y-button y-button-white" value="Nouvel objet" name="newItem" />

                <ul id="itemlist">
                    <li class="squarecol" style="color: blue;">Vase ancien</li>
                    <li class="squarecol" style="color: blue;">Vase anglais</li>
                    <li class="squarecol" style="color: green;">Vase fran&ccedil;ais</li>
                    <li class="squarecol" style="color: green;">Vase zoulou</li>
                </ul>

            </nav>
        </aside>

        <aside id="guide" class="none whitebox"> <!-- aide et guide à l'utilisation -->
            <header>
                <h1>Utilisation</h1>
            </header>

            <section id="infotips">
                <header>
                    <h1>Guide et astuces</h1>
                </header>

                <div class="infobox">
                    <img class="infoicon32" title="Que dois-je faire?" src="./theme/default/img/img_trans.gif" />
                    <p>Veggies sunt bona vobis, proinde vos postulo esse magis yarrow watercress rock melon nori chard tigernut wakame pea sprouts wattle seed potato kale kohlrabi avocado aubergine.</p>
                </div>

                <div class="infobox">
                    <img class="infoicon32" title="Que dois-je faire?" src="./theme/default/img/img_trans.gif" />
                    <p>Dandelion bush tomato quandong bok choy lotus root seakale plantain gram okra cress sorrel yarrow komatsuna chicory grape. Chard tomatillo grape black-eyed pea potato cress bamboo shoot. Epazote ricebean cauliflower kale kombu endive.</p>
                </div>

                <div class="tipbox">
                    <img class="tipicon" title="Astuce!" src="./theme/default/img/img_trans.gif" />
                    <p>Corn horseradish komatsuna bok choy artichoke salsify. Collard greens tatsoi potato bok choy catsear broccoli spinach parsley caulie soko. Prairie turnip cucumber rock melon arugula epazote bitterleaf cabbage potato coriander bunya nuts soybean nori spinach endive shallot.</p>
                </div>
            </section>

            <section id="legend"> <!-- je suis une légende :) -->
                <header>
                    <h1>L&eacute;gende</h1>
                </header>
                <ul id="legendlist">
                    <li class="squarecol" style="color: blue;"> <!-- où stocker la couleur de l'itemType -->
                        <span class="itemtype">Argiles</span>
                    </li>
                    <li class="squarecol" style="color: green;">
                        <span class="itemtype">Cuivres</span>
                    </li>
                </ul>
            </section>
        </aside>

        <section id="main" class="whitebox"> <!-- main panel -->

            <header>
                <input type="image" id="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
                <h1>
                    Consultation de <strong>Vases</strong>
                </h1>
            </header>

            <section class="content"> <!-- contenu intéressant -->
                <aside id="toggletips"><strong>A I D E</strong></aside>

                <h1>Argiles</h1>
                <figure class="cover" id="item1">
                    <aside class="item-details">
                        <a href="details?item=1">
                            <strong>D&eacute;tails</strong>
                        </a>
                    </aside>
                    <img alt="" src="./theme/default/img/icon/image_128.png">
                    <!-- POUR LE FIGCAPTION SUIVANT ==> PREVOIR TAILLE CONTENU MAXIMALE -->
                    <figcaption title="Vase ancien de tr&egrave;s grande valeur">Vase ancien de ...</figcaption>
                </figure>
                <figure class="cover" id="item2">
                    <aside class="item-details">
                        <a href="details?item=2">
                            <strong>D&eacute;tails</strong>
                        </a>
                    </aside>
                    <img alt="" src="./theme/default/img/icon/image_128.png">
                    <figcaption title="Vase anglais">Vase angl...</figcaption>
                </figure>


                <h1>Cuivres</h1>
                <figure class="cover" id="item3">
                    <aside class="item-details">
                        <a href="details?item=3">
                            <strong>D&eacute;tails</strong>
                        </a>
                    </aside>
                    <img alt="" src="./theme/default/img/icon/image_128.png">
                    <figcaption title="Vase zoulou">Vase zou...</figcaption>
                </figure>
                <figure class="cover" id="item4">
                    <aside class="item-details">
                        <a href="details?item=4">
                            <strong>D&eacute;tails</strong>
                        </a>
                    </aside>
                    <img alt="" src="./theme/default/img/icon/image_128.png">
                    <figcaption title="Vase fran&ccedil;ais">Vase fran&ccedil;...</figcaption>
                </figure>

            </section>

        </section>

        <div id="foreground"></div>

        <div role="preview" id="prev-item1">
            <section class="splash whitebox">
                <header>
                    <h1>Vase ancien de tr&egrave;s grande valeur - Aper&ccedil;u</h1>
                </header>
                <section class="content">
                    <h1>H&eacute; ouais</h1>
                    oh yeah
                </section>
            </section>
        </div>

        <div role="preview" id="prev-item2">
            <section class="splash whitebox">
                <header>
                    <h1>Vase anglais - Aper&ccedil;u</h1>
                </header>
                <section class="content">
                    <h1>H&eacute; ouais</h1>
                    oh yeah
                </section>
            </section>
        </div>

        <div role="preview" id="prev-item3">
            <section class="splash whitebox">
                <header>
                    <h1>Vase zoulou - Aper&ccedil;u</h1>
                </header>
                <section class="content">
                    <h1>H&eacute; ouais</h1>
                    oh yeah
                </section>
            </section>
        </div>

        <div role="preview" id="prev-item4">
            <section class="splash whitebox">
                <header>
                    <h1>Vase fran&ccedil;ais - Aper&ccedil;u</h1>
                </header>
                <section class="content">
                    <h1>H&eacute; ouais</h1>
                    oh yeah
                </section>
            </section>
        </div>

        <footer class="clearfix">
            <p id="copyright">&copy; Ya<em class="CE">ce</em>!</p>
            <a href="/yadmin"><strong>Administrer Ya<em class="CE">ce</em>!</strong></a>
        </footer>
    </body>
</html>
