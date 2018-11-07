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
const allListings = document.querySelectorAll(".part-listing");
const listingCount = allListingHeaders.length;
const buyButtons = document.querySelectorAll('.buy-btn');
const priceFilterMax = document.querySelector('#price-filter-max');
const priceFilterMin = document.querySelector('#price-filter-min');
const filterBtn = document.querySelector('#filter-btn')

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

//Filter price input validation


priceFilterMax.addEventListener('keyup', (event) => {
  textNow = priceFilterMax.value
  previousText = textNow.substring(0, textNow.length-1)

  if (event.keyCode < 48 || event.keyCode > 57) {
    priceFilterMax.value = previousText;
  }
});

priceFilterMin.addEventListener('keyup', (event) => {
  textNow = priceFilterMin.value
  previousText = textNow.substring(0, textNow.length-1)

  if (event.keyCode < 48 || event.keyCode > 57) {
    priceFilterMin.value = previousText;
  }
});


//Filter price
filterBtn.addEventListener("click", function() {
  if (priceFilterMax.value !== "") {
    priceFilterMaxValue = parseInt(priceFilterMax.value,10);
  } else {
    priceFilterMaxValue = 1000000000;
  }
  if (priceFilterMin.value !== "") {
    priceFilterMinValue = parseInt(priceFilterMin.value,10);
  } else {
    priceFilterMinValue = 0;
  }

  Array.prototype.forEach.call(allListings, listing => {
    instancePartPrice = parseInt(listing.getElementsByClassName("listing-header")[0].getElementsByClassName("row")[0].getElementsByClassName("col-xs-2")[1].getElementsByClassName("part-price")[0].getElementsByClassName("part-price-value")[0].innerHTML.replace(/\s/g, ''),10)

    listing.style.display = "";

    if ( instancePartPrice >= priceFilterMaxValue ||  instancePartPrice <= priceFilterMinValue ) {
      listing.style.display = "none";
    }
  });
});






});

