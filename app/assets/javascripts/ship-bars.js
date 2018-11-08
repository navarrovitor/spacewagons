document.addEventListener('DOMContentLoaded', function() {

// Log shortcut
function l(x) {
  console.log(x);
}

statBarAcc = document.querySelector("#stat-bar-acc")
statBarSpd = document.querySelector("#stat-bar-spd")
statBarMan = document.querySelector("#stat-bar-man")
statBarAtk = document.querySelector("#stat-bar-atk")
statBarDef = document.querySelector("#stat-bar-def")
statBarEx = document.querySelector(".stat-bar-full")

accVal = parseInt(document.querySelector("#stat-val-acc").innerHTML,10)
spdVal = parseInt(document.querySelector("#stat-val-spd").innerHTML,10)
manVal = parseInt(document.querySelector("#stat-val-man").innerHTML,10)
atkVal = parseInt(document.querySelector("#stat-val-atk").innerHTML,10)
defVal = parseInt(document.querySelector("#stat-val-def").innerHTML,10)


l("---")
// Values

fullStatBar = statBarEx.offsetWidth

statVal = accVal
if (statVal < 0) {
  statVal = 0;
} else if (statVal > 100) {
  statVal = 100
} else {

}
statBarAcc.style.width = (Math.floor(fullStatBar * statVal/100)).toString() + "px"

statVal = spdVal
if (statVal < 0) {
  statVal = 0;
} else if (statVal > 100) {
  statVal = 100
} else {

}
statBarSpd.style.width = (Math.floor(fullStatBar * statVal/100)).toString() + "px"

statVal = manVal
if (statVal < 0) {
  statVal = 0;
} else if (statVal > 100) {
  statVal = 100
} else {

}
statBarMan.style.width = (Math.floor(fullStatBar * statVal/100)).toString() + "px"

statVal = atkVal
if (statVal < 0) {
  statVal = 0;
} else if (statVal > 100) {
  statVal = 100
} else {

}
statBarAtk.style.width = (Math.floor(fullStatBar * statVal/100)).toString() + "px"

statVal = defVal
if (statVal < 0) {
  statVal = 0;
} else if (statVal > 100) {
  statVal = 100
} else {

}
statBarDef.style.width = (Math.floor(fullStatBar * statVal/100)).toString() + "px"

});
