document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

function sortTable(table,column) {
  var table, rows, switching, i, x, y, shouldSwitch;
  switching = true;
  while (switching) {
    switching = false;
    rows = table.rows;
    for (i = 0; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[column - 1];
      y = rows[i + 1].getElementsByTagName("TD")[column - 1];
      if (parseFloat(x.innerHTML) < parseFloat(y.innerHTML)) {
        shouldSwitch = true;
        break;
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }
}

// Lap navigation
lapContainers = document.getElementsByClassName('container-race-lap')
lapNext = document.getElementsByClassName('lap-control-next')[0]
lapPrev = document.getElementsByClassName('lap-control-prev')[0]
lapNum = document.getElementsByClassName('lap-control-text')[0]
maxLaps = parseInt(document.getElementsByClassName('js_max_laps')[0].innerHTML,10)

currentLapNum = 1

// Hide all laps but the first
Array.prototype.forEach.call(lapContainers, lap => {
  if (lap !== lapContainers[0]) {
    lap.style.display = "none";
  }
});

// Change prev button on init lap 1
lapPrev.style.color = 'rgba(120,120,120,1)'

// Click on next
lapNext.addEventListener("click", function() {
  // If not on last lap, move to first
  if (currentLapNum !== maxLaps) {
    lapContainers[currentLapNum - 1].style.display = 'none'
    currentLapNum += 1
    lapContainers[currentLapNum - 1].style.display = ''
    lapNum.innerHTML = `Lap ${currentLapNum}`

    lapPrev.style.color = 'rgba(255,255,255,1)'

    if (currentLapNum === maxLaps) {
      lapNext.style.color = 'rgba(120,120,120,1)'
    }
  }
});

// Click on prev
lapPrev.addEventListener("click", function() {
  // If not on last lap, move to first
  if (currentLapNum !== 1) {
    lapContainers[currentLapNum - 1].style.display = 'none'
    currentLapNum -= 1
    lapContainers[currentLapNum - 1].style.display = ''
    lapNum.innerHTML = `Lap ${currentLapNum}`

    lapNext.style.color = 'rgba(255,255,255,1)'

    if (currentLapNum === 1) {
      lapPrev.style.color = 'rgba(120,120,120,1)'
    }
  }
});


// Sort the tables
finalStandings = document.getElementById('racestandings')
// Sort final result table
sortTable(finalStandings,7);

raceStandingPos = document.getElementsByClassName('race-standing-pos')
pos = 1
Array.prototype.forEach.call(raceStandingPos, posi => {
  if (pos === 1) {
    posi.innerHTML = '1st'
  } else if (pos === 2) {
    posi.innerHTML = '2nd'
  } else if (pos === 3) {
    posi.innerHTML = '3rd'
  } else {
    posi.innerHTML = `${pos}th`
  }
  pos += 1
});

// Sort each lap results table
lapStandings = document.getElementsByClassName('lap-standings')

Array.prototype.forEach.call(lapStandings, table => {
  sortTable(table,5)
});





});
