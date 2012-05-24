var uri = "https://www.googleapis.com/books/v1/volumes";
var append = "key=AIzaSyACxun2j0Wat4J9vtrBFDSgluDft7UI-mg&callback=?";

function getBooks(lang)
{
    var name = $("#name").val();
    $("#content").empty();
    searchGBook(name, lang);
}

function addBook(book)
{
    var authorstr = "";
    for (var i = 0; i < book.authors.length; i++)
        authorstr += book.authors[i].name + ", ";
    $("#content").append("<h2>Results from Google</h2><ul>" +
        "<li>Authors : " + authorstr + "</li>" +
        "<li>Title : " + book.title + "</li>" +
        "<li>Plot : " + book.plot + "</li>" +
        "<li>Cover : <img width=150 src=\"" + book.cover + "\"/></li>" + 
        "</ul>"
    );
}

function searchGBook(name, lang)
{
    var url = uri + "?q=" + name + "&langRestrict=" + lang + "&" + append;
    
    $.ajax({
        type:"GET",
        url:url,
        dataType:"jsonp",
        success: function(data){
            console.log("-BOOK SEARCH-");
            console.log(data);

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
                        authors: authors,
                        title: data.items[i].volumeInfo.title,
                        plot: data.items[i].volumeInfo.description,
                        cover: image,
                        publisher: data.items[i].volumeInfo.publisher,
                        released: data.items[i].volumeInfo.publishedDate,
                        pageCount: data.items[i].volumeInfo.pageCount
                    };
                    
                    addBook(book);
                }
            }
        }
    }); // ajax
}