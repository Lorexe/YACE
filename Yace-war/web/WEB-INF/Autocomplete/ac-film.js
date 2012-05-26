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
    $("#content").append("<h2>Results from "+ film.provider + "</h2>" +
        "<ul><li>Title: " + film.title + "</li>" +
        "<li>Writer: " + film.writer + "</li>" +
        "<li>Director: " + film.director + "</li>" +
        "<li>Resume: " + film.plot + "</li>" +
        "<li>Poster: <img height=150 src=\"" + film.poster + "\"/></li></ul>");
}

//Get imdb info with film title
function getImdb(name)
{
    var uri = "http://www.imdbapi.com/?t="+name+"&callback=?";
    
    $.ajax({
       type:"GET",
       url:uri,
       dataType:"jsonp",
       success: function(data){
            console.log(data);
            var film = {
                provider : "imdb",
                title : data.Title,
                director : data.Director,
                writer : data.Writer,
                actors : data.Actors,
                plot : data.Plot,
                poster : data.Poster,
                runtime : data.Runtime,
                rating : data.Rating,
                genre : data.Genre,
                released : data.Released,
                year : data.Year
            };    
            addFilm(film);
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
           console.log(data);
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
    
    $.ajax({
       type:"GET",
       url:uri,
       dataType:"jsonp",
       success: function(data){
            console.log(data);
            
            //We need the writer, actors, poster and genre
            var writer = "";
            var actor = "";
            var director = "";
            var genre = "";
            var poster = "";
            //writer; actors; director
            
            for (var i =0; i < data[0].cast.length; i++)
            {
                var elt = data[0].cast[i];
                if (elt.department == "Writing")
                    writer += elt.name + ", ";
                else if (elt.department == "Actors")
                    actor += elt.name + ", ";
                else if (elt.department == "Directing")
                    director += elt.name + ", ";
            }
            //genre
            for (i = 0; i < data[0].genres.length; i++)
            {
                elt = data[0].genres[i];
                genre += elt.name+", ";
            }
            //poster
            poster = data[0].posters[4].image.url;
            
            var film = {
                provider : "tmdb",
                title : data[0].original_name,
                writer : writer,
                director : director,
                actors : actor,
                plot : data[0].overview,
                poster : poster,
                runtime : data[0].runtime,
                rating : data[0].rating,
                genre : genre,
                released : data[0].released
            };
            
            addFilm(film);
       }
   }); // ajax
}