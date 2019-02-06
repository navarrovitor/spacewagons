document.addEventListener('DOMContentLoaded', function() {

// The goal of this code is to make the expedition results animation
// When expedition finishes, the results are shown in a slower, more dramatic fashion
// First of all, there is an animation of the ship travelling to the planet
// Then, we show the amount of gold found
// The amount of gold animation is a fast increasing number until the number arrives at the final value
// Then, we show the items
// On an expedition, the user can find between 1 and 3 itens
// To make it dramatic and so that the user doesn't know how many parts he found beforehand
// We show the first part after a little delay
// Then, we show the second part after a little delay, if there is one
// Then, we show the third part after a little delay, if there is one
// If the parts found finished, we show the back to dashboard button after a little delay
// So the player knows that the run has finished


// Support function
// Log shortcut
function l(x) {
  console.log(x);
}

// Get needed elements
loadingTab = document.querySelector(".travelling-bar");
loadingTabShip = document.querySelector(".space-bar");
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

// Get the amount of gold found
goldTotal = parseInt(goldTab.getElementsByTagName("h2")[0].getElementsByClassName("gold-counter")[0].innerHTML,10);
// Get the loading bar width so it can be slowly filled
fullLoadingBar = loadingFull.offsetWidth
// Set the current loading amount to 0
load = 0

// Hide all elements. Elements will be shown one by one on a succession
goldTab.style.display = "none";
itemsTab.style.display = "none";
item1.style.display = "none";

// Hide second item (if there is one)
if (items.length > 1 ) {
  item2.style.display = "none";
}

// Hide third item (if there is one)
if (items.length > 2 ) {
  item3.style.display = "none";
}

// Hide back to dashboard button
simulatorEnd.style.display = "none";

// FIRST ANIMATION: Traveling bar load and spaceship flying
// Strategy: start with a counter padding = 0
// Create an interval with has a very quick refresh rate
// At each refresh, the size of the bar fill increases
// And the paddingLeft on the spaceship increases, so it seems like it is flying
// When bar is filled, stop the animations, and start showing the gold found
function moveBar() {
    var width = 1;
    var padding = 0;
    var id = setInterval(frame, 30);
    function frame() {
        if (width >= 100) {
            clearInterval(id);
            increaseGold();
            loadingTab.style.display = "none";
            loadingTabShip.style.display = "none";
        } else {
            width += Math.random();
            padding += 6;
            loadingAmount.style.width = width + '%';
            loadingAmountShip.style.paddingLeft = padding.toString() + 'px';
        }
    }
}

// SECOND ANIMATION: amount of gold found
// Strategy: start with a counter gold = 0
// Create an interval with has a very quick refresh rate
// At each refresh, increase the gold counter and update the gold count innerHTML
// When gold on counter passes the gold found, stop interval
// The gold counter will increase in random intervals, therefore it will probably
// not exactly match the gold found
// Therefore, when animation ends, quickly set the gold found to the correct value
// Call the next animation
function increaseGold() {
    goldTab.style.display = "";
    simulatorTitle.innerHTML = "Exploring the planet"
    var gold = 0;
    var id = setInterval(frame, 30);
    function frame() {
        if (gold >= goldTotal) {
            clearInterval(id);
            goldCount.innerHTML = goldTotal;
            showItems();
        } else {
            gold += Math.floor(Math.random()*50);
            goldCount.innerHTML = gold
        }
    }
}

// THIRD ANIMATION: items found
// Strategy: set a counter that goes from 0 to 100 and takes time for each increment of 1
// When counter hits 30, show first item
// When counter hits 60, show second item (if there is one)
// When counter hits 90, show third item (if there is one)
// When it hits 100, finish animation
// Then show the back to dashboard button so the user can navigate back

function showItems() {
    itemsTab.style.display = "";
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

// Start the first animation
// The other animations will be called by the previous animations
moveBar()

});


