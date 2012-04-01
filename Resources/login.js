if(document.getElementById('loginStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','loginStyle');
    style.innerHTML = '%%CSS%%';
    document.body.appendChild(style);
}
