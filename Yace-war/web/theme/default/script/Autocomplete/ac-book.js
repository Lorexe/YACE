var uri_book = "https://www.googleapis.com/books/v1/volumes";
var append_book = "key=AIzaSyACxun2j0Wat4J9vtrBFDSgluDft7UI-mg&callback=?";

var semabook = 0;
var basename = "";

var tabbooks = new Array();

function getBooks(input_basename, lang)
{
    tabbooks = new Array();
    basename = input_basename;
    var name = $("#search_input").val();
    $("#search_result").empty();
    $("#search_result").html("<h2>R&eacute;sultats de la recherche</h2>");
    
    searchGBook(name, lang);
}

function addBookToForm(id) {
    var book = tabbooks[id];    
    
    var authorstr = "";
    for (var i = 0; i < book.authors.length; i++)
        authorstr += book.authors[i].name + ", ";
    if(authorstr.length > 0) authorstr = authorstr.substr(0,authorstr.length-2);
    
    if(book.cover=="undefined") $("#"+basename+"cover").val("");
    else                   $("#"+basename+"cover").val(book.cover);
    if(book.title=="undefined") $("#"+basename+"titre").val("");
    else                   $("#"+basename+"titre").val(book.title);
    if(authorstr=="undefined") $("#"+basename+"auteur").val("");
    else                    $("#"+basename+"auteur").val(authorstr);
    if(book.plot=="undefined") $("#"+basename+"resume").val("");
    else                    $("#"+basename+"resume").val(book.plot);
    if(book.publisher=="undefined") $("#"+basename+"editeur").val("");
    else                     $("#"+basename+"editeur").val(book.publisher);
    if(book.released=="undefined") $("#"+basename+"date_de_sortie").val("");
    else                   $("#"+basename+"date_de_sortie").val(book.released);
    if(book.pageCount=="undefined") $("#"+basename+"nombre_de_pages").val("");
    else                      $("#"+basename+"nombre_de_pages").val(book.pageCount);
}

/*
 * Le code des fonctions addBook, searchBookStarted et searchBookStopped est modifiable pour l'affichage 
 */
function addBook(book)
{
    tabbooks.push(book);
    
    var authorstr = "";
    for (var i = 0; i < book.authors.length; i++)
        authorstr += book.authors[i].name + ", ";
    if(authorstr.length > 0) authorstr = authorstr.substr(0,authorstr.length-2);
    
    $("#search_result").append("<div class='ac_box' onclick=\"addBookToForm("+tabbooks.indexOf(book)+")\">" +
        "<img height='150' src='" + book.cover + "'/>" +
        "<ul><li>Auteur : " + authorstr + "</li>" +
        "<li>Titre : " + book.title + "</li>" +
        "<li>R&eacute;sum&eacute; : " + book.plot + "</li></ul><div class='clear_image'></div></div>"
    );
}

function searchBookStarted()
{
    $("#searching").append("<img class='spinwheelicon' src='./theme/default/img/img_trans.gif'/>");
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
        error: function() { finishingBookSearch();}, 
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
