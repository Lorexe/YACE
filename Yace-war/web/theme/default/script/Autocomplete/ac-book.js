var uri_book = "https://www.googleapis.com/books/v1/volumes";
var append_book = "key=AIzaSyACxun2j0Wat4J9vtrBFDSgluDft7UI-mg&callback=?";

var semabook = 0;
var basename = "";

function getBooks(input_basename, lang)
{
    basename = input_basename;
    var name = $("#" + input_basename + "titre").val();
    $("#search_result").empty();
    searchGBook(name, lang);
}

function addBookToForm(cover, titre, auteur, resume, editeur, annee, nb_pages) {
    if(cover=="undefined") $("#"+basename+"cover").val("");
    else                   $("#"+basename+"cover").val(cover);
    if(titre=="undefined") $("#"+basename+"titre").val("");
    else                   $("#"+basename+"titre").val(titre);
    if(auteur=="undefined") $("#"+basename+"auteur").val("");
    else                    $("#"+basename+"auteur").val(auteur);
    if(resume=="undefined") $("#"+basename+"resume").val("");
    else                    $("#"+basename+"resume").val(resume);
    if(editeur=="undefined") $("#"+basename+"editeur").val("");
    else                     $("#"+basename+"editeur").val(editeur);
    if(annee=="undefined") $("#"+basename+"date_de_sortie").val("");
    else                   $("#"+basename+"date_de_sortie").val(annee);
    if(nb_pages=="undefined") $("#"+basename+"nombre_de_pages").val("");
    else                      $("#"+basename+"nombre_de_pages").val(nb_pages);
}

/*
 * Le code des fonctions addBook, searchBookStarted et searchBookStopped est modifiable pour l'affichage 
 */
function addBook(book)
{
    var authorstr = "";
    for (var i = 0; i < book.authors.length; i++)
        authorstr += book.authors[i].name + ", ";
    
    $("#search_result").append("<div class='ac_box' onclick=\"addBookToForm('"+book.cover+"', '"+book.title+"', '"+authorstr+"', '"+book.plot+"', '"+book.publisher+"', '"+book.released+"', '"+book.pageCount+"')\">" +
        "<img height=150 src='" + book.cover + "'/>" +
        "<ul><li>Auteur : " + authorstr + "</li>" +
        "<li>Titre : " + book.title + "</li>" +
        "<li>Résumé : " + book.plot + "</li></ul></div>"
    );
}

function searchBookStarted()
{
    $("#searching").append("Searching...");
}

function searchBookStopped()
{
    $("#searching").empty();
}

function doingBookSearch()
{
    if (semabook == 0)
        searchBookStarted();
    semabook++;
}

function finishingBookSearch()
{
    semabook--;
    if (semabook==0)
        searchBookStopped();
}
function searchGBook(name, lang)
{
    var url = uri_book + "?q=" + name + "&langRestrict=" + lang + "&" + append_book;
    doingBookSearch();
    
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){

            var keeper = data.items.length;
            if (keeper != undefined)
            {
                for (var i = 0; i < keeper; i++)
                {
                    var authors = [];
                    for (var j=0; j<data.items[i].volumeInfo.authors.length; j++)
                        authors.push({"name":data.items[i].volumeInfo.authors[j]});
                    
                    var image = "";
                    if (data.items[i].volumeInfo.imageLinks != undefined)
                        image = data.items[i].volumeInfo.imageLinks["thumbnail"];
                    
                    var book = {
                        provider: "Google Books",
                        authors: authors,
                        title: data.items[i].volumeInfo.title,
                        plot: data.items[i].volumeInfo.description,
                        cover: image,
                        publisher: data.items[i].volumeInfo.publisher,
                        released: data.items[i].volumeInfo.publishedDate,
                        pageCount: data.items[i].volumeInfo.pageCount
                    };
                    
                    addBook(book);
                    finishingBookSearch();
                }
            }
        }
    }); // ajax
}

function addslashes( str ) {
    return (str+'').replace(/([\\"'])/g, "\\$1").replace(/\0/g, "\\0");
}
