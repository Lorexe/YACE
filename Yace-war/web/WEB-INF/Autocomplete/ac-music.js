var append_album = "&api_key=c9aec14b6bfccf2883dbc1ad9e9adf6c&format=json&callback=?";
var uri_album = "http://ws.audioscrobbler.com/2.0/";

var semamusic = 0;

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
        "</ul>" +
        "<h3>Tracks</h3><ol>"
        );
        
    for (var i = 0; i < album.tracklist.length; i++){
        $("#content").append("<li>" + album.tracklist[i].name + " time : " + album.tracklist[i].duration + "</li>");
    }
    $("#content").append("</ol>");
}

function searchAlbumStarted()
{
    $("#searching").append("Searching...");
}

function searchAlbumStopped()
{
    $("#searching").empty();
}

function doingAlbumSearch()
{
    if (semamusic == 0)
        searchAlbumStarted();
    semamusic++;
}

function finishingAlbumSearch()
{
    semamusic--;
    if (semamusic == 0)
        searchAlbumStopped();
}
 
function searchLastfm(name)
{
    searchLastfmArtist(name);
    searchLastfmAlbum(name);
}
 
function searchLastfmArtist(name)
{
    //search related artists and their albums
    var url = uri_album + "?method=artist.search&artist=" + name + append_album;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){

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
    var url = uri_album + "?method=artist.getTopAlbums&mbid=" + mbid + append_album;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            
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
                    mbid = data.topalbums.album[i].mbid;
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
    var url = uri_album + "?method=album.search&album=" + name + append_album;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            
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
                    mbid = data.results.albummatches.album[i].mbid;
                    if (mbid != "")
                        getLastfmAlbum(mbid);
                }
            }
        }
    }); // ajax
}
 
function getLastfmAlbum(mbid)
{
    doingAlbumSearch();
    
    //Get information for a specific album
    var url = uri_album + "?method=album.getInfo&mbid=" + mbid + append_album;
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-ALBUM GETINFO-");
            console.log(data);
            
            var tracklist = [];
            if (data.album.tracks.track != undefined)
            {
                var keeper = data.album.tracks.track.length;
                for (var i = 0; i < keeper; i++) {
                    var name = data.album.tracks.track[i].name;
                    var duration = data.album.tracks.track[i].duration;
                    tracklist.push({
                        "name":name,
                        "duration":duration
                    });
                }
            }
            
            var album = {
                provider: "lastfm",
                artist: data.album.artist,
                name: data.album.name,
                released: data.album.releasedate,
                cover: data.album.image[4]['#text'],
                tracklist: tracklist
            };
			
            addAlbum(album);
            finishingAlbumSearch();
        }
    }); // ajax
}
 