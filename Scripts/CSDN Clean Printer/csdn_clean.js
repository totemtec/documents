const toolbarBox = document.getElementById('toolbarBox');
if (toolbarBox) {
    toolbarBox.remove();
}

const asides = document.getElementsByTagName("aside");
for (let i = 0; i < asides.length; i++) {
    asides[i].remove();
}

const moreToolbars = document.getElementsByClassName('more-toolbar');
for (let i = 0; i < moreToolbars.length; i++) {
    moreToolbars[i].remove();
}

const recommends = document.getElementsByClassName('recommend-box');
for (const r of recommends) {
    r.remove();
}

const foots = document.getElementsByClassName('blog-footer-bottom');
for (const i of foots) {
    i.remove();
}

const optBoxs = document.getElementsByClassName('opt-box');
for (const i of optBoxs) {
    for (const son of i.children) {
        son.remove();
    }
}




const sideToolbar = document.getElementsByClassName('csdn-side-toolbar');
for (const i of sideToolbar) {
    i.parentElement.remove();
}

const login = document.getElementsByClassName('passport-login-tip-container');
for (const i of login) {
    i.remove();
}


var preCodes = document.getElementsByClassName('hide-preCode-box');
for (var i = 0; i < preCodes.length; i++) {
    preCodes[i].children[0].click();
}


let buttons = document.getElementsByClassName('hljs-button');
for (const i of buttons) {
    i.remove();
}

buttons = document.getElementsByClassName('hljs-button');
for (const i of buttons) {
    i.remove();
}

buttons = document.getElementsByClassName('hljs-button');
for (const i of buttons) {
    i.remove();
}

