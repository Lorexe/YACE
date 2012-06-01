var semafilm = 0;

//Start all the research
function getMovies()
{
    var name = $("#name").val();
    $("#content").empty();
    getImdb(name);
    getTmdb(name);    
}

//Adds a film to the list (to be modified)
function addFilm(film)
{
    var writers="";
    var directors="";
    
    for (var i = 0; i < film.writers.length; i++)
        writers += film.writers[i].name + ",";
    for (i = 0; i < film.directors.length; i++)
        directors += film.directors[i].name + ",";
    $("#content").append("<h2>Results from "+ film.provider + "</h2>" +
        "<ul><li>Title: " + film.title + "</li>" +
        "<li>Writer: " + writers + "</li>" +
        "<li>Director: " + directors + "</li>" +
        "<li>Resume: " + film.plot + "</li>" +
        "<li>Poster: <img height=150 src=\"" + film.poster + "\"/></li></ul>");
}

function searchFilmStarted()
{
    $("#searching").append("Searching...");
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