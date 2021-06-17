<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.List" %>
<%@page import="java.sql.Date" %>
<%@page import="org.hibernate.*" %>
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
    <title>Reservations Page</title>
</head>

<%	
	HttpSession httpSess = request.getSession(false);
	Session sess = HibernateUtil.getInstance().getSession();
	
	User currentUser = (User)httpSess.getAttribute("currentUser");
	String userId = request.getParameter("userId");
	Query c;
	//c.add(Restrictions.eq("active", true));
	StringBuilder hql = new StringBuilder("Select r from Reservation r where r.active=\'1\' ");
	if(userId != null && !userId.isEmpty()){
		hql.append(" and (r.user.email = :userId or r.user.username = :userId) ");
	}
	c = sess.createQuery(hql.toString());
	
	if(userId != null && !userId.isEmpty()){
		c.setParameter("userId", userId);
	}
	
	List<Reservation> reservationsList = c.list();
	
	System.out.println(reservationsList.size());
	System.out.println(currentUser.getAid());
	
	
	
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
            <div class="item"><a href = adminHome.jsp>Home</a></div>
            <div class="item"><a href = reservationsbydate.jsp>Reservations History</a></div>
            <div class="item"><a href = hotelsearchadmin.jsp>Hotels</a></div>
     </div>
 </div>

    <div class="form" id="CRSearchForm">
        <form action=currentreservations.jsp>
            <table>
                <tr>
                    <td><label for="UserID">User Id:</label></td>
                    <td><input type=text placeholder="User Id" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'User Id'" name=userId></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type=submit></td>
                </tr>
            </table>
        </form>
    </div>
	<%
		for(Reservation r : reservationsList){
			
			
	%>
        <div class="form" id="CRForm">
            <form action = managereservations method=post>
                <table>
                    <tr>
	<tr>
	<td><input type="radio" id="<%=r.getRid() %>" name="selectedreservation" value = "<%=r.getRid() %>"> 
	<td><%=r.getHotel().getName() %></td>
	<td><%= r.getPrice() %></td>
	<td><%= r.getCheckIn() %></td>
	<td><%= r.getExpectedCheckOut() %></td>
	<td><%= r.isPaid() %></td>
	</tr>
	<%
		}
sess.close();
	%>
	</table>
	<input type = submit name=delete value="Delete">
	<input type = submit name=confirmpayment value="Confirm Payment">
	<input type = submit name=checkin value="checkin">
	<input type = submit name=checkout value="checkout">
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