if(document.getElementById('albumartStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','albumartStyle');
    style.innerHTML = '%%CSS%%';
    document.body.appendChild(style);
    
    $('.slideDragHandle').simulateDragSortable({ move: -20 });
}
