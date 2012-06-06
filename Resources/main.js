if(document.getElementById('pandoriumStyle') === null) {
    var style = document.createElement('style');
    style.setAttribute('id','pandoriumStyle');
    style.innerHTML = "%%CSS%%";
    document.body.appendChild(style);
}
var oldstyle = document.getElementById('loginStyle');
if (oldstyle !== null) {
    oldstyle.parentElement.removeChild(oldstyle);
}
document.getElementsByName('email')[0].focus();

$('#trackInfo .slideDrag').mousedown(function(ev) {
    $('#trackInfo .slideDragHandle').trigger(ev);
});