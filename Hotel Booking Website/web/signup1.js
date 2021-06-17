function signUpValidation()
{
	var firstName = document.forms["signup"]["fName"].value;
	var middleName = document.forms["signup"]["mName"].value;
	var lastName = document.forms["signup"]["lName"].value;
	var userName = document.forms["signup"]["username"].value;
	var email = document.forms["signup"]["email"].value;
	var phoneNumber = document.forms["signup"]["phonenumber"].value;
	alert(firstName);
	if(validateName(firstName)){
		if(validateName(middleName)){
			if(validateName(lastName)){
				if(validateUserName(userName)){
					if(validateEmail(email)){
						if(validatePhoneNumber(phoneNumber)){
							
						}
					}
				}
			}
		}
	}
	
	/*if (validateName(firstName) == true){return true;}
	if (validateName(middleName) == true){return true;}
	if (validateName(lastName) == true){return true;}
	if (validateUserName(userName) == true){return true;}
	if (validateEmail(email) == true){return true;}
	if (validatePhoneNumber(phoneNumber) == true){return true;}*/
	
	return false;
}


function validateName(name)
{
	var n_length = name.value.length;
	var letters = /^[A-Za-z]+$/;
	
	if(n_length < 4 || n_length > 15 || n_lengeth == 0)
		{
			alert("user name should be between 4 and 15");
			name.focus();
			return false;
		}
	
	if(name.value.match(letters))
		{
			return true;
		}
	else
		{
			alert('name must have alphabet letters only');
			name.focus();
			return false;
		}
	
	return true;
}


function validateUserName(userName)
{
	var un_length = userName.value.length;
	var letterNumber = /^[0-9a-zA-Z]+$/;
	
	if(un_length < 5 || un_length > 20 || un_length == 0)
		{
			alert("user name should be between 5 and 20");
			userName.focus();
			return false;
		}
	
	if(userName.value.match(letterNumber))
		{
			return true;
		}
	else
		{
			alert("user name must be alphabet letters and numbers");
			userName.focus();
			return false;
		}
	
	return true;
}

function validateEmail(email)
{
	var mailFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(email.value.match(mailformat))
		{
			return true;
		}
	else
		{
			alert("You have entered an invalid email address!");
			email.focus();
			return false;
		}
	if(mailFormat.value.length == 0){
		return false;
	}
}

function validatePhoneNumber(pNumber)
{
	var numbers = /^[0-9]+$/;
	if(pNumber.value.length == 0){
		return false;
	}
	if(pNumber.value.match(numbers))
		{
			return true;
		}
	else
		{
			alert("phone number must be numbers only");
			return false;
		}
}
