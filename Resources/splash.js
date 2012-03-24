if(document.getElementById('splashStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','splashStyle');
    style.innerHTML = '%%CSS%%';
    document.body.appendChild(style);
}
