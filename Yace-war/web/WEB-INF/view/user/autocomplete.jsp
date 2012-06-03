<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
        <h1>${pageTitle}</h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <h1>${pageTitle}</h1>
        <form name="search">
            <input type="text" id="name" placeholder="Recherche"/>
            <input type="button" id="btn1" class="y-button y-button-green" value="Get films" onclick="getMovies()"/>
            <input type="button" id="btn2" class="y-button y-button-green" value="Get albums" onclick="getAlbums()"/>            
            <input type="button" id="btn3" class="y-button y-button-green" value="Get books en" onclick="getBooks('en')"/>
            <input type="button" id="btn4" class="y-button y-button-green" value="Get books fr" onclick="getBooks('fr')"/>
        </form>
        <div id="searching"> </div>
        <div id="content"> </div>
    </section>

</section>
      
<script type="application/javascript" src="./theme/default/script/Autocomplete/ac-film.js"></script>
<script type="application/javascript" src="./theme/default/script/Autocomplete/ac-music.js"></script>
<script type="application/javascript" src="./theme/default/script/Autocomplete/ac-book.js"></script>