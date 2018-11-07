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
const partIds = document.querySelectorAll('.intel-part-id');
const loggedUserId = parseInt(document.querySelector('#logged-user-id').innerHTML.replace(/\s/g, ''),10);

l(loggedUserId);

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

Array.prototype.forEach.call(buyButtons, btn => {
  btn.addEventListener("click", function() {

    indexBuy = (index(btn.parentNode.parentNode.parentNode.parentNode)-1)/2;

    var partBuyId = partIds[indexBuy].innerHTML;
    var buyerId = loggedUserId;

    // Rails.ajax({
    //   url: `transact?part_id=${partBuyId}&buyer_id=${buyerId}`,
    //   type: 'POST',
    //   sucess: function(r){
    //     }
    //   });
    // })

    Rails.ajax({
      url: `/transact`,
      type: 'POST',
      sucess: function(){
        l("sucess")
        },
      error: function(){
        l("fail")
      }
      });
    })



  });
});

