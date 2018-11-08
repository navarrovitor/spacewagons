document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

const sellPriceSelect = document.querySelector('#sell-price-select');

sellPriceSelect.addEventListener('keyup', (event) => {
  if (event.keyCode < 48 || event.keyCode > 57) {
    sellPriceSelect.value = "";
  }
});

});
