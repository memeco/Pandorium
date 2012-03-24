if(document.getElementById('pandoriumStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','pandoriumStyle');
    style.innerHTML = "%%CSS%%";
    document.body.appendChild(style);
}