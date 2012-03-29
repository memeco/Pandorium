if(document.getElementById('pandoriumStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','pandoriumStyle');
    style.innerHTML = "%%CSS%%";
    document.body.appendChild(style);
}
var oldstyle = document.getElementById('pandoriumLoginStyle');
if (oldstyle !== null) {
    oldstyle.parentElement.removeChild(oldstyle);
}
var oldstyle = document.getElementById('splashStyle');
if (oldstyle !== null) {
    oldstyle.parentElement.removeChild(oldstyle);
}