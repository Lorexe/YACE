<!DOCTYPE html>
<html lang="fr" class="angled stripes">
<head>
	<title>Administration - Gestion niveaux - ${initParam.appName}</title>
	<link rel="shortcut icon" href="favicon.ico" />
	<meta charset="utf-8" />

	<link rel="stylesheet" type="text/css" href="./theme/default/common.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="./theme/default/buttonsandforms.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="./theme/default/master_layout.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="./theme/default/jquery.tooltip.css" media="screen" />

	<script src="./theme/default/script/jquery-1.7.js"></script>
	<script src="./theme/default/script/jquery-ui-1.8.16.custom.min.js"></script>
	<script src="./theme/default/script/jquery.tooltip.js"></script>
	<script src="./theme/default/script/common.js"></script>
        
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
			<h1>Administration</h1>
		</header>

		<nav>
			<h2>Gestion du site</h2>
			<ul>
				<li>
						<a href="admin-inscriptions.html">G&eacute;rer les inscriptions</a>
				</li>
			</ul>
		</nav>

		<nav>
			<h2>Gestion des utilisateurs</h2>
			<ul>
				<li>
						<a href="admin-utilisateurs.html">G&eacute;rer les utilisateurs</a>
				</li>
				<li>
						<a href="admin-niveaux.html">G&eacute;rer les niveaux d'utilisateurs</a>
				</li>
			</ul>
		</nav>
	</aside>

	<section id="main" class="whitebox"> <!-- main panel -->

		<header>
			<h1>
				G&eacute;rer les <strong>niveaux</strong> d'utilisateurs
			</h1>
		</header>

		<section class="content"> <!-- contenu intéressant -->
			Recherchez/choisissez un niveau d'utilisateur :
			<select name="" id="levels">
				<option value="">Administrateur</option>
				<option value="">Membre Free</option>
				<option value="">Membre Premium</option>
			</select>
			<button id="" class="y-button y-button-blue">Modifier</button>
			<button id="" class="y-button y-button-green">Ajouter</button>
			<button id="" class="y-button y-button-red">Supprimer</button>
			<br><br>
			<h1>H&eacute;&eacute;&eacute;&eacute; ouaaaaiiis !</h1>

		</section>

	</section>

	<footer class="clearfix">
		<p id="copyright">&copy; Ya<em class="CE">ce</em>!</p>
		<a href="/yadmin"><strong>Administrer Ya<em class="CE">ce</em>!</strong></a>
	</footer>

<!-- Modal dialogs -->
	<!-- confirm dialog -->
	<div class="modal modal-info whitebox" id="confirm">
		<header>
			<h1><strong>Nouveau</strong> grade</h1>
		</header>
		<p>
			<form action="" id="">
				<table class="y-table y-table-form">
					<tr class="odd">
						<td><label for="">Nom du grade :</label></td>
						<td><input type="text" /></td>
					</tr>
					<tr>
						<td><label for="">Nombre d'objets max :</label></td>
						<td><input type="text" /></td>
					</tr>
					<tr class="odd">
						<td><label for="">Pouvoir administrateur :</label></td>
						<td><input type="checkbox" /></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
				</table>
			</form>
		</p>

		<p>
			<button class="close y-button y-button-red"> oui </button>
			<button class="close y-button y-button-blue"> non </button>
		</p>
	</div>

</body>
</html>