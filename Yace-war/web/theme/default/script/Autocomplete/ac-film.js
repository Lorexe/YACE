var semafilm = 0;
var basename = "";

var tabmovies = new Array();

//Start all the research
function getMovies(input_basename)
{
    tabmovies = new Array();
    basename = input_basename;
    var name = $("#search_input").val();
    $("#search_result").empty();
    $("#search_result").html("<h2>R&eacute;sultats de la recherche</h2>");
    
    getImdb(name);
    getTmdb(name);
}

function addFilmToForm(id) {
    var film = tabmovies[id];
    
    var writers="";
    var directors="";
    var actors="";
    var genres="";
    
    for (var i = 0; i < film.writers.length; i++)
        writers += film.writers[i].name + ", ";
    if(writers.length > 0) writers = writers.substr(0,writers.length-2);
    
    for (i = 0; i < film.directors.length; i++)
        directors += film.directors[i].name + ", ";
    if(directors.length > 0) directors = directors.substr(0,directors.length-2);
    
    for (i = 0; i < film.actors.length; i++)
        actors += film.actors[i].name + ", ";
    if(actors.length > 0) actors = actors.substr(0,actors.length-2);
    
    for (i = 0; i < film.directors.length; i++)
        genres += film.genres[i].name + ", ";
    if(genres.length > 0) genres = genres.substr(0,genres.length-2);
    
    if(film.poster=="undefined") $("#"+basename+"cover").val("");
    else                   $("#"+basename+"cover").val(film.poster);
    if(film.title=="undefined") $("#"+basename+"titre").val("");
    else                   $("#"+basename+"titre").val(film.title);
    if(directors=="undefined") $("#"+basename+"realisateur").val("");
    else                         $("#"+basename+"realisateur").val(directors);
    if(writers=="undefined") $("#"+basename+"auteur").val("");
    else                    $("#"+basename+"auteur").val(writers);
    if(actors=="undefined") $("#"+basename+"acteur").val("");
    else                    $("#"+basename+"acteur").val(actors);
    if(film.plot=="undefined") $("#"+basename+"resume").val("");
    else                    $("#"+basename+"resume").val(film.plot);
    if(film.runtime=="undefined") $("#"+basename+"duree").val("");
    else                   $("#"+basename+"duree").val(film.runtime);
    if(film.rating=="undefined") $("#"+basename+"note").val("");
    else                  $("#"+basename+"note").val(film.rating);
    if(genres=="undefined") $("#"+basename+"genre").val("");
    else                   $("#"+basename+"genre").val(genres);
    if(film.released=="undefined") $("#"+basename+"date_de_sortie").val("");
    else                   $("#"+basename+"date_de_sortie").val(film.released);
}

function escape_string(str) {
    return (str+'').replace(/"/g, "&quot;").replace(/'/g, "&#039;");
}

//Adds a film to the list (to be modified)
function addFilm(film)
{
    tabmovies.push(film);   
    
    var writers="";
    var directors="";
    var actors="";
    var genres="";
    
    for (var i = 0; i < film.writers.length; i++)
        writers += film.writers[i].name + ", ";
    if(writers.length > 0) writers = writers.substr(0,writers.length-2);
    
    for (i = 0; i < film.directors.length; i++)
        directors += film.directors[i].name + ", ";
    if(directors.length > 0) directors = directors.substr(0,directors.length-2);
    
    for (i = 0; i < film.actors.length; i++)
        actors += film.actors[i].name + ", ";
    if(actors.length > 0) actors = actors.substr(0,actors.length-2);
    
    for (i = 0; i < film.directors.length; i++)
        genres += film.genres[i].name + ", ";
    if(genres.length > 0) genres = genres.substr(0,genres.length-2);
    
    $("#search_result").append("<div class='ac_box' onclick=\"addFilmToForm("+tabmovies.indexOf(film)+")\">" +
        "<img height='150' src='" + film.poster + "'/>" +
        "<ul><li>Titre: " + film.title + "</li>" +
        "<li>Auteur: " + writers + "</li>" +
        "<li>R&eacute;alisateur: " + directors + "</li>" +
        "<li>R&eacute;sum&eacute;: " + film.plot + "</li></ul><div class='clear_image'></div></div>");
}

function searchFilmStarted()
{
    $("#searching").append("<img class='spinwheelicon' src='./theme/default/img/img_trans.gif'/>");
}

function searchFilmStopped()
{
    $("#searching").empty();
}

function doingFilmSearch()
{
    if (semafilm == 0)
        searchFilmStarted();
    semafilm++;
}

function finishingFilmSearch()
{
    semafilm--;
    if (semafilm == 0)
        searchFilmStopped();
}

//Get imdb info with film title
function getImdb(name)
{
    var uri = "http://www.imdbapi.com/?t="+name+"&callback=?";
    doingFilmSearch();
    
    $.ajax({
       type:"GET",
       url:uri,
       dataType:"jsonp",
       error: function() {finishingFilmSearch();}, 
       success: function(data){
            
            var writers = [];
            var actors = [];
            var directors = [];
            var genres = [];
            
            var splitted = data.Writer.split(",");
            for (var i = 0; i < splitted.length; i++) {
                writers.push({"name":splitted[i]});
            }
            
            splitted = data.Actors.split(",");
            for (i = 0; i < splitted.length; i++) {
                actors.push({"name":splitted[i]});
            }
            
            splitted = data.Director.split(",");
            for (i = 0; i < splitted.length; i++) {
                directors.push({"name":splitted[i]});
            }
            
            splitted = data.Genre.split(",");
            for (i = 0; i < splitted.length; i++) {
                genres.push({"name":splitted[i]});
            }
            
            var film = {
                provider : "imdb",
                title : data.Title,
                directors : directors,
                writers : writers,
                actors : actors,
                plot : data.Plot,
                poster : data.Poster,
                runtime : data.Runtime,
                rating : data.Rating,
                genres : genres,
                released : data.Released,
                year : data.Year
            };    
            addFilm(film);
            finishingFilmSearch();
       }
   }); // ajax
}

//Initiate search in TheMovieDB (gives multiple film choices)
function getTmdb(name)
{
    var uri = "http://api.themoviedb.org/2.1/Movie.search/en/json/e5ce14dd590334e71c1ac17d889d1d81/" + name + "?callback=?";
    
    $.ajax({
       type:"GET",
       url:uri,
       dataType:"jsonp",
       error: function() {finishingFilmSearch();}, 
       success: function(data){
           for (var i = 0; i < data.length; i++)
           {
               getTmdbFilm(data[i].id, "en");  
               getTmdbFilm(data[i].id, "fr");
           }
       }
    });
}

//Get info for a film from TheMovieDB
function getTmdbFilm(id, lang)
{
    var uri = "http://api.themoviedb.org/2.1/Movie.getInfo/"+ lang +"/json/e5ce14dd590334e71c1ac17d889d1d81/" + id + "?callback=?";
    
    doingFilmSearch();
    
    $.ajax({
       type:"GET",
       url:uri,
       dataType:"jsonp",
       error: function() {finishingFilmSearch();}, 
       success: function(data){
            
            //We need the writer, actors, poster and genre
            var writers = [];
            var actors = [];
            var directors = [];
            var genres = [];
            var poster = "";
            //writer; actors; director
            
            for (var i =0; i < data[0].cast.length; i++)
            {
                var elt = data[0].cast[i];
                if (elt.department == "Writing")
                    writers.push({"name":elt.name});
                else if (elt.department == "Actors")
                    actors.push({"name":elt.name});
                else if (elt.department == "Directing")
                    directors.push({"name":elt.name});
            }
            //genre
            for (i = 0; i < data[0].genres.length; i++)
            {
                elt = data[0].genres[i];
                genres.push({"name":elt.name});
            }
            //poster
            poster = data[0].posters[4].image.url;
            
            var film = {
                provider : "tmdb",
                title : data[0].original_name,
                writers : writers,
                directors : directors,
                actors : actors,
                plot : data[0].overview,
                poster : poster,
                runtime : data[0].runtime,
                rating : data[0].rating,
                genres : genres,
                released : data[0].released
            };
            
            addFilm(film);
            finishingFilmSearch();
       }
   }); // ajax
}