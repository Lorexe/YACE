var append = "&api_key=c9aec14b6bfccf2883dbc1ad9e9adf6c&format=json&callback=?";
var uri="http://ws.audioscrobbler.com/2.0/";
 
function getAlbums()
{
    //var apik = "c9aec14b6bfccf2883dbc1ad9e9adf6c";
    //var uri = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=cher&api_key=b25b959554ed76058ac220b7b2e0a026";
    var name = $("#name").val();
    $("#content").empty();
    searchLastfm(name);
}
 
function addAlbum(album)
{
    $("#content").append("<h2>Results from last.fm</h2><ul>" +
        "<li>Image : <img width=150 src=\"" + album.cover + "\"/></li>" +
        "<li>Artist : " + album.artist + "</li>" +
        "<li>Album : " + album.name + "</li>" +
        "</ul>");
}
 
function searchLastfm(name)
{
    searchLastfmArtist(name);
    searchLastfmAlbum(name);
}
 
function searchLastfmArtist(name)
{
    //search related artists and their albums
    var url = uri + "?method=artist.search&artist=" + name + append;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-ARTIST SEARCH-");
            console.log(data);

            var keeper = data.results.artistmatches.artist.length;			
            for (var i = 0; i < keeper; i++)
            {
                var mbid = data.results.artistmatches.artist[i].mbid;
                console.log(mbid);
                if (mbid != "")
                    getLastfmArtistAlbums(mbid);
            }
        }
    }); // ajax
}

function getLastfmArtistAlbums(mbid)
{
    //search available albums for an artist
    var url = uri + "?method=artist.getTopAlbums&mbid=" + mbid + append;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-ARTIST's ALBUMS SEARCH-");
            console.log(data);
            
            var keeper = data.topalbums.album.length;
            if (keeper == undefined)
            {
                if (data.topalbums.album != undefined)
                {
                    var mbid = data.topalbums.album.mbid;
                    if (mbid != "")
                        getLastfmAlbum(mbid);
                }
            }
            else
            {
                for (var i = 0; i < keeper; i++)
                {
                    var mbid = data.topalbums.album[i].mbid;
                    console.log(mbid);
                    if (mbid != "")
                        getLastfmAlbum(mbid);
                }
            }
        }
    }); // ajax
}
 
function searchLastfmAlbum(name)
{
    //search related albums
    var url = uri + "?method=album.search&album=" + name + append;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-ALBUM SEARCH-");
            console.log(data);
            
            var keeper = data.results.albummatches.album.length;
            if (keeper == undefined)
            {
                if (data.results.albummatches.album != undefined)
                {
                    var mbid = data.results.albummatches.album.mbid;
                    if (mbid != "")
                        getLastfmAlbum(mbid);
                }
            }
            else
            {
                for (var i = 0; i < keeper; i++)
                {
                    var mbid = data.results.albummatches.album[i].mbid;
                    if (mbid != "")
                        getLastfmAlbum(mbid);
                }
            }
        }
    }); // ajax
}
 
function getLastfmAlbum(mbid)
{
    //Get information for a specific album
    var url = uri + "?method=album.getInfo&mbid=" + mbid + append;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-ALBUM GETINFO-");
            console.log(data);
            
            var album = {
                artist: data.album.artist,
                name: data.album.name,
                released: data.album.releasedate,
                cover: data.album.image[4]['#text']
            };
			
            addAlbum(album);
        }
    }); // ajax
}
 