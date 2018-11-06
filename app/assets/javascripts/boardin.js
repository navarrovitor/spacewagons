document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

//Elements
const categoryTabs = document.querySelectorAll(".boardin-category-item");
const categoryGroups = document.querySelectorAll(".basic-part-category-group");



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

    currentCategory = a.innerHTML.toLowerCase().replace(/\s/g, '');;
    l(currentCategory);

    Array.prototype.forEach.call(categoryGroups, group => {
      group.style.display = "none";
    });

    let activeGroup = document.querySelector(`#listing-${currentCategory}s`)
    l(activeGroup)

    activeGroup.style.display = "";
  });
});



});
