<!DOCTYPE html>
<html lang="fr" class="angled stripes">
<head>
	<title>Modifier son profil - YACE! Yet Another Collection Engine - Gestionnaire pour collectionneurs</title>
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
					Username
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
				<li class="squarecol" style="color: green;">Vase français</li>
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
				<img id="infoicon" title="Que dois-je faire?" src="./theme/default/img/img_trans.gif" />
				<p>
					Ici, vous pouvez modifier vos informations de connexion. Votre mot de passe actuel est requis. Il vous est demand&eacute; dans un soucis de s&eacute;curit&eacute;. Merci de votre compr&eacute;hension.
				</p>
			</div>

		</section>

	</aside>

	<section id="main" class="whitebox"> <!-- main panel -->

		<header>
			<input type="image" id="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
			<h1>
				Modifier ses <strong>param&ecirc;tres de connexion</strong>
			</h1>
		</header>

		<section class="content"> <!-- contenu intéressant -->
			<aside id="toggletips"><strong>A I D E</strong></aside>

			<table class="y-table y-table-form">
				<tbody>
					<tr class="odd">
						<td>*<label for="username">Nom d'utilisateur :</label></td>
						<td><input type="text" id="username" value="Admin" placeholder="Requis" /></td>
					</tr>
					<tr>
						<td>*<label for="email">Email :</label></td>
						<td><input type="text" id="email" value="admin@yace.com" placeholder="Requis" /></td>
					</tr>
					<tr class="odd">
						<td><label for="newpwd">Nouveau mot de passe :</label></td>
						<td><input id="newpwd" type="password" /></td>
					</tr>
					<tr>
						<td><label for="newpwd-verif">Nouveau mot de passe (bis) :</label></td>
						<td><input id="newpwd-verif" type="password" /></td>
					</tr>
					<tr class="odd">
						<td>*<label for="pwd">Mot de passe actuel :</label></td>
						<td><input id="pwd" type="password" placeholder="Requis" /></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" class="y-button y-button-blue" />
						</td>
					</tr>
				</tbody>
			</table>

		</section>
	</section>

	<footer class="clearfix">
		<p id="copyright">&copy; Ya<em class="CE">ce</em>!</p>
		<a href="/yadmin"><strong>Administrer Ya<em class="CE">ce</em>!</strong></a>
	</footer>
</body>
</html>
