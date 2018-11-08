document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

// Elements

mockGoBtn = document.querySelector("#go-mock")
RealGoBtn = document.querySelector("#go-real")
destinationName = document.querySelector("#destination-name-dd")
destinationNameLabel = document.querySelector("#destination-name-select")
destinationNameItems = document.querySelectorAll(".destination-name-item")
expeditionCounter = document.querySelector(".expedition-counter").querySelector("h2").querySelector("span").innerHTML

// Update name of destination on dropdown

destinationNameLabel.value = destinationName.value;

destinationName.onchange = function() {
    destinationNameLabel.value = destinationName.value;
}

// Button appear or disappear

mockGoBtn.style.display = "none";

if (expeditionCounter === '0') {
  mockGoBtn.style.display = "";
  realGoBtn.style.display = "none";
}


});

