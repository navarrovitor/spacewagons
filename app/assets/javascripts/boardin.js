


document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

function index(el) {
    var children = el.parentNode.childNodes,
        i = 0;
    for (; i < children.length; i++) {
        if (children[i] == el) {
            return i;
        }
    }
    return -1;
}

//Elements
const categoryTabs = document.querySelectorAll(".boardin-category-item");
const categoryGroups = document.querySelectorAll(".basic-part-category-group");
const allListings = document.querySelectorAll(".basic-part-listing");
const selectButtons = document.querySelectorAll(".select-part-btn");
const userCoins = document.querySelector(".user-boardin-coin");
const coinBlock = document.querySelector(".user-boardin-coin-block");
const finalSubmit = document.querySelector(".final-submit-btn");

//Find price of a part
function price_of_part(part_index) {
  let partCost = parseInt(allListings[part_index].getElementsByClassName("basic-part-listing-header")[0].getElementsByClassName("row")[0].getElementsByClassName("col-xs-3")[0].getElementsByClassName("boardin-part-price")[0].getElementsByClassName("part-cost")[0].innerHTML.replace(/\s/g, ''),10)
  return partCost
}

// Start page on propulsors
Array.prototype.forEach.call(categoryGroups, group => {
  group.style.display = "none";
});
categoryGroups[0].style.display = "";


Array.prototype.forEach.call(categoryTabs, a => {
  a.addEventListener("click", function() {

    Array.prototype.forEach.call(categoryTabs, all => {
      all.classList.remove("boardin-active")
    });

    a.classList.add("boardin-active")

    currentCategory = a.innerHTML.toLowerCase().replace(/\s/g, '');
    l(currentCategory);

    Array.prototype.forEach.call(categoryGroups, group => {
      group.style.display = "none";
    });

    let activeGroup = document.querySelector(`#listing-${currentCategory}`)
    l(activeGroup)

    activeGroup.style.display = "";
  });
});

let selectedParts = [];
l(selectedParts)

Array.prototype.forEach.call(selectButtons, button => {
  button.addEventListener("click", function() {

    btnIndex = (index(button.parentNode.parentNode.parentNode.parentNode.parentNode) - 1) / 2
    groupIndex = ((index(button.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode) - 1) / 2)

    btnIndex += groupIndex * 3

    btnIndexGroup = []
    btnIndexGroup.push(groupIndex * 3)
    btnIndexGroup.push(groupIndex * 3 + 1)
    btnIndexGroup.push(groupIndex * 3 + 2)

    // Remove all parts of same group from Setup
    Array.prototype.forEach.call(btnIndexGroup, listing => {
      var index = selectedParts.indexOf(listing)
      if (index > -1) {
        selectedParts.splice(index, 1);
      }
    });
    // Add new part to Setup

    selectedParts.push(btnIndex)

    // Calculate price of current Setup

    setupCost = 0;

    Array.prototype.forEach.call(selectedParts, item => {
      setupCost += price_of_part(item)
    });

    // Update amount of money user has

    moneyLeft = 10000 - setupCost

    userCoins.innerHTML = moneyLeft

    // Update style and text if negative

    if (moneyLeft < 0) {
      coinBlock.style.backgroundColor = "rgba(240,80,80,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Not enough coins!";
    } else if (moneyLeft === 0) {
      coinBlock.style.backgroundColor = "rgba(80,240,140,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(0,120,50,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(0,120,50,1)"
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Looks like a good setup!";
    } else {
      coinBlock.style.backgroundColor = "rgba(100,100,100,1"
      coinBlock.querySelector(".coins-left-text").style.color = "white";
      coinBlock.querySelector(".spend-hint").style.color = "white";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Pick awesome parts";
    }


    // Remove highlight from parts

    sameGroup = []

    Array.prototype.forEach.call(btnIndexGroup, listing => {
      allListings[listing].classList.remove("part-selected")
    });

    // Add highlight to selected part

    allListings[btnIndex].classList.add("part-selected");
  });
});

// l(finalSubmit);

// finalSubmit.addEventListener("click", function() {
//   Rails.ajax({
//     url: '/boardin',
//     type: 'POST',
//     sucess: function(r){
//       l("FUCK");
//     }
//   });
// });
});
