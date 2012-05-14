var a = Math.ceil(Math.random() * 10);
var b = Math.ceil(Math.random() * 10);
var c = a + b;

function showCaptcha() {
  document.write("<span id='calcul'>" + a + " + " + b +" = </span>");
  document.write("<input id='captcha' role='captcha' type='text' maxlength='2' placeholder='?'/>");
}

function validateCaptcha() {
  var d = document.getElementById('captcha').value;
  if (d == c) return true;
  return false;
}

function errorCaptcha() {
	setWarning('#out1', 'Veuillez entrer le bon r&eacute;sultat pour le calcul.');
}