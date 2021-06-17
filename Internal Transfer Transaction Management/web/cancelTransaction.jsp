<%-- 
    Document   : cancelTransaction
    Created on : Dec 24, 2020, 3:12:44 PM
    Author     : oh377
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cancel Transaction</title>
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
            String bt_id = request.getParameter("bankTransactionID");
            session.setAttribute("bankTransactionID", bt_id);
            
            try 
            {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                
                if(bt_id.isEmpty())
                {
                    response.sendRedirect("transactions.jsp");
                }
                
                RS = Stmt.executeQuery("SELECT * FROM banktransaction where bankTransactionID = '" + bt_id + "' and btFromAccount = '" + cus_id + "';");
        %>
        <form action="confirmTransCancel">
            <input type="submit" value="confirm process">
        </form>
        <%
            RS.close();
            Stmt.close();
            Con.close();
            }
            catch (Exception e)
            {
                
                out.println("no transactions found " + e);
            }
            %>
    </body>
</html>
