document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

// Find index of item
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

// Element listing
const allListingDetails = document.querySelectorAll(".listing-body");
const allListingHeaders = document.querySelectorAll(".listing-header");
const listingCount = allListingHeaders.length;
const buyButtons = document.querySelectorAll('.buy-btn');

var detailsShown = new Array(100);
for (var i = 0; i < detailsShown.length; ++i) { detailsShown[i] = false; }


l(listingCount)
// Initializations
Array.prototype.forEach.call(allListingDetails, a => {
  a.style.display = "none";
});

// Listing on click

Array.prototype.forEach.call(allListingHeaders, a => {
  a.addEventListener("click", function() {
    indexClick = (index(a.parentNode) - 1)/2

    if (detailsShown[indexClick] == false) {
      allListingDetails[indexClick].style.display = "";
      detailsShown[indexClick] = true;
    } else {
      allListingDetails[indexClick].style.display = "none";
      detailsShown[indexClick] = false;
    }
  });
});



});

