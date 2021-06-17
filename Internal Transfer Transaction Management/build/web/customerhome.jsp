<%-- 
    Document   : customerhome
    Created on : Dec 21, 2020, 2:15:45 PM
    Author     : oh377
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Home</title>
    </head>

    <body>
        <%
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "3773";
            String Line;
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            String cus_id = request.getSession().getAttribute("customerID").toString(); 
            
            try {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                
                RS = Stmt.executeQuery("SELECT * FROM bankaccount where CustomerID = '" + cus_id + "';");   
                RS.next();
                
                if(RS.getString("CustomerID") != null)
                {
                    out.println(RS.getInt("BACurrentBalance"));
                    %>
                    <br>
                        <button type="submit" disabled>add account</button>
                    <br>
                    <form action="transactions.jsp">
                        <button type="submit">view transaction list</button>
                    </form>
                    <%
                Stmt.close();
                Con.close();
                }
            } catch (Exception e) {
                 %>
                 <br>
                 <form action="addaccount">
                    <button type="submit">add account</button>
                 </form>
                 <%
                System.err.println("Exception: " + e);
            }
        %>
        </form>
    </body>
</html>

<%
    RS.close();
    Stmt.close();
    Con.close();
%>