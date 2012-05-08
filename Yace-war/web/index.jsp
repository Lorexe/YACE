<%-- 
 Nom
 	index.html
 Desc
 	Page d'accueil de YaCE!
 	S'y trouve l'inscription et une présentation de YaCE!
 Auteur
 	Bruno BOI <biddaputzese@gmail.com>
 Transformation jsp: Jerome SCOHY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
	<title>YACE! Yet Another Collection Engine - Gestionnaire pour collectionneurs</title>

	<meta charset="utf-8" />

	<link rel="stylesheet" type="text/css" href="./theme/default/common.css" />
	<link rel="stylesheet" type="text/css" href="./theme/default/buttonsandforms.css" />
	<link rel="stylesheet" type="text/css" href="./theme/default/presentation_layout.css" />

	<script src="./theme/default/script/jquery-1.7.js"></script>
	<script src="./theme/default/script/jquery.timers-1.2.js"></script>
	<script src="./theme/default/script/common.js"></script>
	<script src="./theme/default/script/jq.myslideshow.js"></script>
	<script src="./theme/default/script/mycaptcha.js"></script>
</head>
<body>
	<header role="welcome">
		<img id="logo-header" class="yace-logo" alt="YaCE!" title="Yet Another Collection Engine !" src="./theme/default/img/img_trans.gif" />
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
			<form name="connexion" action="ServletLogin" method="post" autocomplete="on">
				<input type="text" name="login" maxlength="200" placeholder="Email" />
				<br />
				<input type="password" name="pwd" maxlength="200" placeholder="Mot de passe" />
				<input type="submit" class="y-button y-button-submit" value="Connectez-vous" />
                        </form>
                        <h1>Inscription</h1>
			<form name="inscription" action="ServletRegister" method="post" autocomplete="on">
				<input type="text" name="login" maxlength="200" placeholder="Email" />
				<br />
				<input type="password" name="pwd" maxlength="200" placeholder="Mot de passe" />
				<br />
				<input type="password" name="pwd-verif" maxlength="200" placeholder="Confirmation MDP" />
				<br />
				<script type="text/javascript">showCaptcha();</script>
				<input type="button" class="y-button y-button-submit" value="Enregistrez-vous" onclick="validateCaptcha()?submit():errorCaptcha()" />
                        </form>
			
                        <% if(request.getAttribute("error") != null) { %>
                            <output id="out1" class="warning output"><%= request.getAttribute("error") %></output>
                        <% } else if(request.getAttribute("info") != null) { %>
                            <output id="out1" class="info output"><%= request.getAttribute("info") %></output>
                        <% } else { %>
                            <output id="out1" class="hidden"></output>
                        <% } %>
                        
		</aside>

		<div id="slideshow">

			<article class="slide">
				<h1>Yace, c'est quoi?</h1>
				<p>Yace est un site internet qui permet de gérer et partager vos collections. Il rend facile la gestion de vos livres, vidéos, musiques, tableaux, vins et toute autre chose.</p>
			</article>

			<article class="slide">
				<h1>Accessible à tous</h1>
				<p>Une interface simple et intuitive vous guide pour rajouter tous les détails que vous désirez.</p>
			</article>

			<article class="slide">
				<h1>Compl&egrave;te les informations</h1>
				<p>Des informations sont automatiquement récupérées de sites spécialisés, comme <a href="http://www.imdb.com">The Internet Movie Database</a> - base de données n°1 pour les films - ou encore <a href="http://www.amazon.com">Amazon</a> - base de données de référence pour les livres, musiques, films, jeux vidéos... - et beaucoup d'autres.</p>
			</article>

			<article class="slide">
				<h1>Epatez vos amis</h1>
				<p>Vous pouvez partager vos collections sur vos r&eacute;seaux sociaux!</p>
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
