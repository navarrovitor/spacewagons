document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

// Elements

loadingTab = document.querySelector(".travelling-bar");
loadingFull = document.querySelector(".full-bar");
loadingAmount = document.querySelector(".grow-bar");
loadingAmountShip = document.querySelector(".my-ship-bar");
goldTab = document.querySelector(".gold-found");
goldCount = goldTab.getElementsByTagName("h2")[0].getElementsByClassName("gold-counter")[0]
itemsTab = document.querySelector(".items-found");
simulatorTitle = document.querySelector(".simulator-title").getElementsByTagName("h1")[0];
simulatorTitleColor = simulatorTitle.querySelector("span");
simulatorEnd = document.querySelector(".simulator-end");
items = document.querySelectorAll(".item-listing")
item1 = document.querySelectorAll(".item-listing")[0];
item2 = document.querySelectorAll(".item-listing")[1];
item3 = document.querySelectorAll(".item-listing")[2];

// Values
goldTotal = parseInt(goldTab.getElementsByTagName("h2")[0].getElementsByClassName("gold-counter")[0].innerHTML,10);
fullLoadingBar = loadingFull.offsetWidth
load = 0

// Hide all
goldTab.style.display = "none";
itemsTab.style.display = "none";
item1.style.display = "none";

if (items.length > 1 ) {
  item2.style.display = "none";
}

if (items.length > 2 ) {
  item3.style.display = "none";
}

simulatorEnd.style.display = "none";

// Bar load

function moveBar() {
    var width = 1;
    var padding = 0;
    var id = setInterval(frame, 30);
    function frame() {
        if (width >= 100) {
            clearInterval(id);
            increaseGold();
            loadingTab.style.display = "none";
            loadingAmountShip.style.display = "none";
        } else {
            width += Math.random();
            padding += 6;
            loadingAmount.style.width = width + '%';
            loadingAmountShip.style.paddingLeft = padding.toString() + 'px';
        }
    }
}
function increaseGold() {
    goldTab.style.display = "";
    simulatorTitle.innerHTML = "Exploring the planet"
    var gold = 0;
    var id = setInterval(frame, 30);
    function frame() {
        if (gold >= goldTotal) {
            clearInterval(id);
            showItems();
        } else {
            gold += Math.floor(Math.random()*50);
            goldCount.innerHTML = gold
        }
    }
}


function showItems() {
    itemsTab.style.display = "";
    goldCount.innerHTML = goldTotal
    icomplete = 0
    var id = setInterval(frame, 40);
    function frame() {
        if (icomplete >= 100) {
            clearInterval(id);
            simulatorTitle.style.color = "black";
            simulatorTitleColor.style.color = "black";
            simulatorEnd.style.display = "";

        } else {
            icomplete ++;
            if (icomplete > 30 && icomplete < 60) {
              item1.style.display = "";
            }
            if (icomplete > 60 && icomplete < 90) {
              if (items.length > 1 ) {
                item2.style.display = "";
              }
            }
            if (icomplete > 90) {
              if (items.length > 2 ) {
                item3.style.display = "";
              }
            }
        }
    }
}


moveBar()


});


