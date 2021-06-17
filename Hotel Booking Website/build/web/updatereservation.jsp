<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List" %>
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
    <link rel="stylesheet" href="unifiedCSSFile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <title>Update Reservations</title>


<%
	Reservation res = (Reservation)request.getSession(false).getAttribute("currentReservation");

	

%>

</head>
<body>
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
     <div class="form" id="updatedReservationsForm">
        <form action=updatereservations method=post>
            <table>
                <tr>
                    <td><input type="date" name="newcheckin" value="checkin"></td>

                    <td><input type="date" name="newcheckout" value="checkout"></td>
                </tr>
                <tr>
                    <td><input type=submit value=Update></td>
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