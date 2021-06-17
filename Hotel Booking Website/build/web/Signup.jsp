<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Signup Page</title>
<script src="IA_project1/WebContent/Signup.js"></script>
<script src="https://www.google.com/recaptcha/api.js?render=6Lfv7yEaAAAAANsYx7f0ECapzKSiQEtvgoxf4fFm"></script>
<link rel="stylesheet" href="unifiedCSSFile.css">

<script>
    grecaptcha.ready(function() {
    // do request for recaptcha token
    // response is promise with passed token
        grecaptcha.execute('6Lfv7yEaAAAAANsYx7f0ECapzKSiQEtvgoxf4fFm', {action:'validate_captcha'})
                  .then(function(token) {
            // add token value to form
            document.getElementById('g-recaptcha-response').value = token;
        });
    });
</script>

</head>
<body>
<div class="topnav">
  <a href="index.html">Login</a>
</div>
<form name="signup" action="Signup" method="post">
    <div class="form" id="signupForm">
    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
    <input type="hidden" name="action" value="validate_captcha">
    <table cellspacing="5" border="0">
        <tr>
            <td><label for="FistName">First Name:</label></td>
            <td><input type="text" id="fName" name="fName" placeholder="First Name" required></td>
        </tr>
        <tr>
            <td><label for="MiddleName"> Middle Name:</label></td>
            <td><input type="text" id="mName" name="mName" placeholder="Middle Name" required></td>
        </tr>
	<tr>
            <td><label for="LastName"> Last Name:</label></td>
            <td><input type="text" id="lName"  name="lName" placeholder="Last Name" required></td>
        </tr>
        <td><label for="UserName"> User Name:</label></td>
        <td><input type="text" id="username" name="username" placeholder="Username" required></td>
        <tr>
            <td><label for="email"> Email:</label></td>
            <td><input type="email" id="email" name="email" placeholder="Email" required></td>
        </tr>
        <tr>
            <td><label for="PhoneNumber"> Phone Number:</label></td>
            <td><input type="phonenumber" id="phonenumber" name="phonenumber" placeholder="Phonenumber" required></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" onclick="signUpValidation()" value=submit></td>
        </tr>
    </table>
    </div>
</form>
<div id="show_response"></div>
</body>

</html>