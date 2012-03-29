if(document.getElementById('pandoriumLoginStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','pandoriumLoginStyle');
    style.innerHTML = "%%CSS%%";
    document.body.appendChild(style);
}
var oldstyle = document.getElementById('splashStyle');
if (oldstyle !== null) {
    oldstyle.parentElement.removeChild(oldstyle);
}