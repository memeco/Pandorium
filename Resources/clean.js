if(document.getElementById('pandoriumStyle') === null) {
    // Adding extra div to the right of the searchbox for shortening it
    var searchTable = document.createElement('table');
    var searchTableRow = document.createElement('tr');
    var searchTableCol0 = document.createElement('td');
    var searchTableCol1 = document.createElement('td');
    
    searchTable.setAttribute('id', 'pandoriumSearchTable');
    searchTable.setAttribute('border', '0');
    
    var searchAdd = document.createElement('div');
    searchAdd.setAttribute('id', 'pandoriumSearchAdd');
    
    x = document.getElementsByClassName('searchBox');
    var docSearchBox; // the correct div.searchBox element
    for (var i=0;i<x.length;i++) {
        if (x[i].children.length == 1) {
            docSearchBox = x[i];
            docSearchBox.setAttribute('id', 'theSearchBox');
        }
    }
    
    var docSearchBoxParent = docSearchBox.parentNode;
    docSearchBoxParent.removeChild(docSearchBox);
    
    // add the original search elements to the table
    searchTableCol0.appendChild(docSearchBox);
    searchTableCol1.appendChild(searchAdd);
    
    // setup table structure
    searchTableRow.appendChild(searchTableCol0);
    searchTableRow.appendChild(searchTableCol1);
    searchTable.appendChild(searchTableRow);
    
    docSearchBoxParent.appendChild(searchTable);
    
    
    
    /*$('.searchInput').focus(function() {
                            $('.searchBox').addClass('searchBoxFocus');
                            });
    
    $('.searchInput').blur(function() {
                           $('.searchBox').removeClass('searchBoxFocus');
                           });
     
     onload = function(e) {
     document.getElementsByTagName("div")[0].addEventListener("focus", function(e) {
     alert("Focused!");
     }, false); // fails
     document.getElementsByTagName("input")[0].addEventListener("focus", function(e) {
     alert("Focused!");
     }, false); // works
     };
     
     */
    
    docSearchBox.children[0].setAttribute('onfocus',"document.getElementById('theSearchBox').addClass('searchBoxFocus');");

    /*docSearchBox.children[0].addEventListener('focus', function(e) {
        docSearchBox.addClass('searchBoxFocus');
    }, false);
    */
    // setup table into the page
    
    var style = document.createElement('style');
    style.setAttribute('id','pandoriumStyle');
    style.innerHTML = "%%CLEANCSS%%";
    document.body.appendChild(style);
}