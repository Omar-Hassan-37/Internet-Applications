<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<%@page import="org.hibernate.Session" %>
<%@page import="IA_Project.WebData.*" %>
<%@page import="IA_Project.Util.*" %>
<%@page import="org.hibernate.Criteria" %>
<%@page import="org.hibernate.criterion.Restrictions" %>
<%@page import="org.hibernate.criterion.Criterion" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="unifiedCSSFile.css?version=2">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Hotel Search Admin</title>
</head>

<%
String hcountry = request.getParameter("country");
String hcity = request.getParameter("city");
String hname = request.getParameter("name");

HttpSession httpSess = request.getSession(false);

Session sess = HibernateUtil.getInstance().getSession();

if(hcountry == null || hcountry.isEmpty() 
&& (hcity == null || hcity.isEmpty())
&& (hname == null || hcity.isEmpty())){
	hcountry = "@";

	hcity = "@";

	hname = "@";
}

Criteria c = sess.createCriteria(Hotel.class);

if(!hcity.isEmpty())
	c.add(Restrictions.like("city","%"+hcity+"%"));
if(!hcountry.isEmpty())
	c.add(Restrictions.like("country","%"+hcountry+"%"));
if(!hname.isEmpty())
	c.add(Restrictions.like("name","%"+hname+"%"));

List<Hotel> hotels = (List<Hotel>) c.list();


%>
<body>
     <div class="topnav" id="userHomeNB">
 <div class="menu-btn">
     <i class="fas fa-bars"></i>
 </div>
    <div class="AHdropdown">
        <button class="dropbtn">Notifications
          <i class="fa fa-caret-down"></i>
        </button>
        <div class="dropdown-content">
          
        </div>
    </div>
 </div>
 <div class="sideBar">
     <div class="close-btn">
         <i class="fas fa-times"></i>
     </div>
     <div class="userMenu">
            <div class="item"><a href = AdminHome.jsp>Home</a></div>
            <div class="item"><a href = currentreservations.jsp>Current Reservations</a></div>
            <div class="item"><a href = reservationsbydate.jsp>Reservations History</a></div>
     </div>
 </div>
    
    
<div class="form" id="hotelSearchForm">
<form action="updatehotel.jsp">
	<table>
	<%
		for(Hotel h : hotels){
			

	%>
	<tr>
	<td><input type="radio" id=<%=h.getHid() %> name=selectedhotel value = <%=h.getHid() %>> 
	<td><%=h.getName() %></td>
	<td><%= h.getIncludingMeals() %></td>
	<td> <a href="viewrates.jsp?h=<%=h.getHid()%>">View Rates</a></td>
	
	</tr>
	<%
		}
	%>
	</table>
	<input type=submit value="Update">
	</form>
        
        
<div class="form" id="HSForm">
    <form action=hotelsearchadmin.jsp>
    <table> 
            <tr>
                <td><label for="country">Country: </label></td>
                <td><input type="text" name="country" placeholder="country" onfocus="this.placeholder = ''"
                           onblur="this.placeholder = 'country'"></td>
            </tr>
            <tr>      
                <td><label for="city">City: </label></td>
                <td><input type=text name=city placeholder="city" onfocus="this.placeholder = ''"
                           onblur="this.placeholder = 'city'"></td>
            </tr>
            <tr>
                <td><label for="name">Name: </label></td>
                <td><input type=text name=name placeholder="name" onfocus="this.placeholder = ''"
                           onblur="this.placeholder = 'name'"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type=submit></td>
            </tr>
    </table>
	</form>
    </div>
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
</html>