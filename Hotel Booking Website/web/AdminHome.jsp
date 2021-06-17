<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List" %>
<%@page import="java.sql.Date" %>
<%@page import="org.hibernate.Session" %>
<%@page import="IA_Project.WebData.*" %>
<%@page import="IA_Project.Util.*" %>
<%@page import="org.hibernate.Criteria" %>
<%@page import="org.hibernate.Query" %>
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
    <title>Admin Home Page</title>
</head>
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
            <div class="item"><a href = currentreservations.jsp>Current Reservations</a></div>
            <div class="item"><a href = reservationsbydate.jsp>Reservations History</a></div>
            <div class="item"><a href = hotelsearchadmin.jsp>Hotels</a></div>
     </div>
 </div>
    
    
    
    <div class="form" id="AHForm">
        <form action="clientsearch.jsp" method=get>
            <table>
                <tr>
                    <td><label for="ClientName">Client Name:</label>
                    <td><input type=text placeholder="Client Name" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'Client Name'" name=q></td>
                </tr>
                    <td></td>
                    <td><input type=submit value=search></td>
                   
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