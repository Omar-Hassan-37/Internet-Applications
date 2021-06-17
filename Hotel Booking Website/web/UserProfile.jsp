<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "IA_Project.WebData.*" %>
<%@page import= "javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="unifiedCSSFile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesom e/5.15.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>User Profile Page</title>
</head>
</head>
<body>
	<%
	
	HttpSession requestSession = request.getSession(false);

	
	User user = (User)requestSession.getAttribute("currentUser");
	System.out.println(user);
	%>

        <div class="topnav" id="userHomeNB">
        <div class="menu-btn">
            <i class="fas fa-bars"></i>
        </div>
        </div>
    <div class="sideBar">
        <div class="close-btn">
            <i class="fas fa-times"></i>
        </div>
     <div class="userMenu">
            <div class="item"><a href="UserHome.jsp">Home</a></div>
            <div class="item"><a href="UserProfile.jsp">Profile</a></div>
            <div class="item"><a href="managereservations.jsp">Manage Reservations</a></div>
     </div>
    </div>
        
	<form action="UpdateUser" method=post>
            <div class="form" id="profileForm">
		<table>
			<tr>
                            <td><label for="FistName">First Name:</label></td>
                            <td><input type=text name=fname placeholder="<%=user.getName().getfName() %>" onfocus="this.placeholder = ''"
                            onblur="this.placeholder = '<%=user.getName().getfName() %>'" value = <%=user.getName().getfName() %>></td>
			</tr>
			<tr>
                            <td><label for="MiddleName"> Middle Name:</label></td>
                            <td><input type=text name=mname placeholder="<%=user.getName().getmName()%>" onfocus="this.placeholder = ''"
                            onblur="this.placeholder = '<%=user.getName().getmName()%>'" value =<%=user.getName().getmName()%>></td>
			</tr>
			<tr>
                            <td><label for="LastName"> Last Name:</label></td>
                            <td><input type=text name=lname placeholder="<%=user.getName().getlName()%>" onfocus="this.placeholder = ''"
                            onblur="this.placeholder = '<%=user.getName().getlName()%>'" value =<%=user.getName().getlName()%> ></td>
			</tr>
			<tr>
                            <td><label for="Email"> Email:</label></td>
                            <td><input type=text name=email placeholder="<%=user.getEmail()%>" onfocus="this.placeholder = ''"
                            onblur="this.placeholder = '<%=user.getEmail()%>'" value =<%=user.getEmail()%>></td>
			</tr>
			<tr>
                            <td><label for="PhoneNumber"> Phone Number:</label></td>
                            <td><input type=text name=phonenumber placeholder="<%=user.getPhonenumber()%>" onfocus="this.placeholder = ''"
                            onblur="this.placeholder = '<%=user.getPhonenumber()%>'" value =<%=user.getPhonenumber()%> ></td>
			</tr>
			<tr>
                            <td><label for="input-1">Old Password:</label></td>
                            <td><input type=password name="oldpassword">
			</tr>
			<tr>
                            <td><label for="input-1">New Password:</label></td>
                            <td><input type=password name="newpassword">
			</tr>
			<tr>
			<td><input type=submit value=Update>
			</tr>
			
		</table>
            </div>
	</form>
        <script type="text/javascript">
        $('document').ready(function(){
            $('.menu-btn').click(function(){
                $('.sideBar').addClass('active');
                $('.menu-btn').css("visibility","hidden");
            })
            $('.close-btn').click(function(){
                $('.sideBar').removeClass('active');
                $('.menu-btn').css("visibility","visible");
            });
        });
        </script>
</body>
</html>