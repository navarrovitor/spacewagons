document.addEventListener('DOMContentLoaded', function() {

// The goal of this function is to build the animations and logic
// For the board-in basic part picking menu
// The user has 10 000 coins and has to spend them
// Picking one part for each part type between the given options
// The user can only proceed when he picked one part of each type and spent all his coins

// --------------------------------------------------------------------------------
// Support functions

// Log shortcut
function l(x) {
  console.log(x);
}

// Find the index of an element compared to its sibling nodes
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

//Find the price of a part given its index
function price_of_part(part_index) {
  let partCost = parseInt(allListings[part_index].getElementsByClassName("basic-part-listing-header")[0].getElementsByClassName("row")[0].getElementsByClassName("col-xs-3")[0].getElementsByClassName("boardin-part-price")[0].getElementsByClassName("part-cost")[0].innerHTML.replace(/\s/g, ''),10)
  return partCost
}
// --------------------------------------------------------------------------------

//Get all needed elements
const categoryTabs = document.querySelectorAll(".boardin-category-item");
const categoryGroups = document.querySelectorAll(".basic-part-category-group");
const allListings = document.querySelectorAll(".basic-part-listing");
const selectButtons = document.querySelectorAll(".select-part-btn");
const userCoins = document.querySelector(".user-boardin-coin");
const coinBlock = document.querySelector(".user-boardin-coin-block");
const finalSubmit = document.querySelector(".final-submit-btn");
const shipNameInput = document.querySelector("#ship-name-select");
const allPartIds = document.querySelectorAll(".hidden-part-id");

//Get all rails forms inputs
const formPropulsor = document.querySelector("#prop-select");
const formShield = document.querySelector("#shield-select");
const formShell = document.querySelector("#shell-select");
const formBumper = document.querySelector("#bumper-select");
const formWing = document.querySelector("#wing-select");
const formFinalButton = document.querySelector("#final-submit-btn");
const formMockButton = document.querySelector("#final-mock-btn");

// Initiate support variables
let checkCoins = 0;
let checkNumberParts = 0;

// Make submit button not clickable if conditions are not met
formFinalButton.style.display = "none";

// Picking the basic parts
// The user is given 3 basic parts for each type of part
// The 3 parts for each type have ranks
// The first part is low rank, costs 1000 and is weaker
// The second part is average rank, costs 2000 and is weaker
// The third part is high rank, costs 3000 and is weaker
// You have 10 000 coins to start
// Therefore, you could pick 5 average rank parts
// Or you could pick a high rank part, but then you have to pick a low rank on other part type
// You can only proceed if you spent all your money on the parts

// Start page on propulsors
Array.prototype.forEach.call(categoryGroups, group => {
  group.style.display = "none";
});
categoryGroups[0].style.display = "";

// Navigation between the part type tabs
// Each part type has a tab that can be clicked to navigate to that part type
Array.prototype.forEach.call(categoryTabs, a => {
  a.addEventListener("click", function() {

    // Make all tabs inactive
    Array.prototype.forEach.call(categoryTabs, all => {
      all.classList.remove("boardin-active")
    });

    // Make clicked tab active (CSS effects)
    a.classList.add("boardin-active")

    // Save current active category name
    currentCategory = a.innerHTML.toLowerCase().replace(/\s/g, '');

    // Hide all non-active tabs
    Array.prototype.forEach.call(categoryGroups, group => {
      group.style.display = "none";
    });

    // Display the active tab
    let activeGroup = document.querySelector(`#listing-${currentCategory}`)

    activeGroup.style.display = "";
  });
});

// Get which parts have been selected
// When user clicks "Select" on a part, it gets highlighted and selected
// All other parts of the same time gets un-selected
// When selection is made, calculate the total cost of current selections
// And update the amount left to spend

let selectedParts = [];

Array.prototype.forEach.call(selectButtons, button => {
  button.addEventListener("click", function() {
    // Get which select button was clicked (in the tab)
    btnIndex = (index(button.parentNode.parentNode.parentNode.parentNode.parentNode) - 1) / 2
    // Get which tab had a button clicked
    groupIndex = ((index(button.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode) - 1) / 2)

    // Get which select button was clicked (globally)
    btnIndex += groupIndex * 3

    // Get all parts from the same part type
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

    // Remove highlight from parts of the same group
    sameGroup = []

    Array.prototype.forEach.call(btnIndexGroup, listing => {
      allListings[listing].classList.remove("part-selected")
    });

    // Add highlight to selected part
    allListings[btnIndex].classList.add("part-selected");

    // Get the id of the part which is a hidden value in the page
    partId = allPartIds[btnIndex].innerHTML

    // Change the Rails input value corresponding to that part type
    if (groupIndex === 0) {
      formPropulsor.value = partId
    } else if (groupIndex === 1) {
      formShell.value = partId
      l(formShield)
    } else if (groupIndex === 2) {
      formShield.value = partId
    } else if (groupIndex === 3) {
      formBumper.value = partId
    } else if (groupIndex === 4) {
      formWing.value = partId
    }

    // Form submit conditions

    // If you spent more than you have, "Not enough coins"
    // Cant proceed!
    if (moneyLeft < 0) {
      coinBlock.style.backgroundColor = "rgba(240,80,80,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Not enough coins!";

      formFinalButton.style.display = "none";
      formMockButton.style.display = "";

    // All money is spent, but you haven't selected one part of each type
    // Cant proceed!
    } else if (moneyLeft === 0 && selectedParts.length !== 5) {
      coinBlock.style.backgroundColor = "rgba(240,80,80,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Select at least one of each part!";

      formFinalButton.style.display = "none";
      formMockButton.style.display = "";

    // If there is money left, but not all parts are picked, keep picking
    // Keep going
    } else if ( moneyLeft > 0 && selectedParts.length < 5    ) {
      coinBlock.style.backgroundColor = "rgba(100,100,100,1"
      coinBlock.querySelector(".coins-left-text").style.color = "white";
      coinBlock.querySelector(".spend-hint").style.color = "white";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Pick some cool parts!";

      formFinalButton.style.display = "none";
      formMockButton.style.display = "";

      // If one part of each type is selected and there is still money left, "Pick better parts"
      // Keep going
    } else if ( moneyLeft > 0 && selectedParts.length === 5) {
      coinBlock.style.backgroundColor = "rgba(240,80,80,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(160,0,0,1)";
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>There's still money left! Pick better parts";

      formFinalButton.style.display = "none";
      formMockButton.style.display = "";

    // You picked one part of each and spent all the money
    // Awesome! You can proceed and create the ship
    } else {
      coinBlock.style.backgroundColor = "rgba(80,240,140,1)"
      coinBlock.querySelector(".coins-left-text").style.color = "rgba(0,120,50,1)";
      coinBlock.querySelector(".spend-hint").style.color = "rgba(0,120,50,1)"
      coinBlock.querySelector(".spend-hint").innerHTML = "<br>Looks like a good setup!";

      formFinalButton.style.display = "";
      formMockButton.style.display = "none";
    }

  });
});

});
