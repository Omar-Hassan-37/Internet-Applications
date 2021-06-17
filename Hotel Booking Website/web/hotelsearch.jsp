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
    <title>Hotel Search</title>
</head>
	<%
	String checkinS = request.getParameter("checkin");
	String checkoutS = request.getParameter("checkout");
	Date checkinD;
	Date checkoutD;
	HttpSession httpSess = request.getSession(false);
	
	String q = request.getParameter("querytext");
	if(q == null)
	{
		q = (String)httpSess.getAttribute("querytext");
		
	}
	else
	{
		httpSess.setAttribute("querytext", q);
	}
	if(checkinS != null)
	{
		System.out.println(checkinS);
		checkinD = Date.valueOf(checkinS.replace("/", "-"));
		httpSess.setAttribute("checkin", checkinD);
	}
	else
		checkinD = (Date)httpSess.getAttribute("checkin");
	
	if(checkoutS != null)
	{
		checkoutD = Date.valueOf(checkoutS.replace("/", "-"));
		httpSess.setAttribute("checkout", checkoutD);
	}
	else
		checkoutD = (Date)httpSess.getAttribute("checkout");
	
	
	String min_price = request.getParameter("min_price");
	String max_price = request.getParameter("max_price");
	
	String min_rating = request.getParameter("min_rating");
	String max_rating = request.getParameter("max_rating");
	
	String min_stars = request.getParameter("min_stars");
	String max_stars = request.getParameter("max_stars");
	
	String min_distance = request.getParameter("min_distance");
	
	String[] meals = request.getParameterValues("meals");
	
	Session sess = HibernateUtil.getInstance().getSession();
	
	Criteria c = sess.createCriteria(Hotel.class);
	
	Criterion city = Restrictions.like("city","%"+q+"%");
	
	Criterion country = Restrictions.like("country","%"+q+"%");
	
	
	double min_price_d = 0;
	double max_price_d = 99999;
	double min_rate_d = 0;
	double max_rate_d = 10;
	double min_stars_d  = 0;
	double max_stars_d  = 5;
	double min_distance_d = 1000;
	
	if(min_price != null && !min_price.isEmpty())
	{
		min_price_d = Double.parseDouble(min_price);
	}
	if(min_price!= null&& !max_price.isEmpty())
	{
		max_price_d = Double.parseDouble(max_price);
	}
	if(min_price!= null && !min_rating.isEmpty())
	{
		min_rate_d = Double.parseDouble(min_rating);
	}
	if(min_price!= null&& !max_rating.isEmpty())
	{
		max_rate_d = Double.parseDouble(max_rating);
	}
	if(min_price!= null&& !min_stars.isEmpty())
	{
		min_stars_d = Double.parseDouble(min_stars);
	}
	if(min_price!= null && !max_stars.isEmpty())
	{
		max_stars_d = Double.parseDouble(max_stars);
	}
	if(min_price!= null && !min_distance.isEmpty())
	{
		min_distance_d = Double.parseDouble(min_distance);
	}
	
	
	c.add(Restrictions.or(city, country));
	c.add(Restrictions.between("price", min_price_d, max_price_d));
	c.add(Restrictions.between("userRating", min_rate_d, max_rate_d));
	c.add(Restrictions.between("stars", min_stars_d, max_stars_d));
	c.add(Restrictions.or(Restrictions.lt("distanceToCityCenter", min_distance_d),
			Restrictions.eq("distanceToCityCenter", min_distance_d)));
	
	
	List<Hotel> hotels = (List<Hotel>) c.list();
	
	
	
	//sess.close();
	System.out.println(q);
	
	%>
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
	
  <div class="form" id="reserveRoomsForm">
    <form action="reserverooms.jsp">
	<table>
	<%
		for(Hotel h : hotels){
			
			boolean mealsIncluded = true;
			if(meals!= null){
			for(int i = 0; i < meals.length;i++){
			if(!h.getIncludingMeals().contains(meals[i]))
				mealsIncluded = false;
				break;
			}
			}
			if(!mealsIncluded)
				continue;
	%>
	<tr>
	<td><input type="radio" id=<%=h.getHid() %> name=selectedhotel value = <%=h.getHid() %>> 
	<td><%=h.getName() %></td>
	<td><%= h.getIncludingMeals() %></td>
	</tr>
	<%
		}
	%>
	</table>
	<input type=submit value="reserve">
	</form>
    </div>
	
    <div class="form" id="HotelsForm">
	<label for="Filters">Filters </label><br>
	<form action=hotelsearch.jsp>
            <table>
                
                <tr>
                    <td><label for="Price">Price: </label></td>
                    <td><input type=text placeholder="min price" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'min price'"  name=min_price></td>
                    <td><input type=text placeholder="max price" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'max price'"  name=max_price></td>
                </tr>
                
                <tr>
                    <td><label for="Rating">Rating: </label></td>
                    <td><input type=text placeholder="min rating" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'min rating'"  name=min_rating></td>
                    <td><input type=text placeholder="max rating" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'max rating'"  name=max_rating></td>
                </tr>
                
                <tr>
                    <td><label for="Stars">Stars: </label></td>
                    <td><input type=text placeholder="min stars" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'min stars'"  name=min_stars></td>
                    <td><input type=text placeholder="max stars" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'max stars'"  name=max_stars></td>
                </tr>
		
                <tr>
                    <td><label for="Distance">Distance: </label></td>
                    <td><input type=text placeholder="min distance" onfocus="this.placeholder = ''"
                    onblur="this.placeholder = 'min distance'"  name=min_distance></td>
                </tr>
		
                <tr>
                    <td><label for="Meals">Meals: </label></td>
                    <td><input type=checkbox name=meals value=breakfast> Breakfast</td>
                    <td> <input type=checkbox name=meals value=lunch> Lunch</td>
                    <td><input type=checkbox name=meals value=dinner> Dinner</td>
                </tr>
		
                <tr>
                    <td></td>
                    <td><input type=submit></td>
                </tr>
            </table>
	</form>
	<%sess.close(); %>
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