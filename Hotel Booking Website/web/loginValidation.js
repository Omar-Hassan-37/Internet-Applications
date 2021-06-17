function loginValidation() {
  var userName = document.forms["Login"]["username1"].value;
  var password = document.forms["Login"]["password1"].value;
  if ((userName == "") || (password == "")) {
    alert("Name and password must be filled out");
    return false;
  }
}