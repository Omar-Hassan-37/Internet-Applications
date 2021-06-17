<%-- 
    Document   : transactions
    Created on : Dec 23, 2020, 1:34:05 PM
    Author     : oh377
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction Page</title>
    </head>
    
    <body>
        <table cellspacin="5" cellpadding="5" border="1">
        <%
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password = "3773";
            String Line;
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            String cus_id = request.getSession().getAttribute("customerID").toString(); 
            
            try 
            {
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                
                RS = Stmt.executeQuery("SELECT * FROM banktransaction where btFromAccount = '" + cus_id + "' or btToAccount = '" + cus_id + "';");
            %>
            <tr>
                <th>Bank Transaction ID</th> 
                <th>BT Creation Date</th> 
                <th>BT Amount</th> 
                <th>BT From Account</th>
                <th>BT To Account</th>
            </tr>
            <%
                while (RS.next()) {
                    int from = RS.getInt("btFromAccount");
                    int to = RS.getInt("btToAccount");
            %>
            <tr>
                <td><%=RS.getInt("BankTransactionID")%></td>
                <td><%=RS.getString("BTCreationDate")%></td>
                <td><%=RS.getInt("BTAmount")%></td>
                <td><%=RS.getInt("BTFromAccount")%></td>
                <td><%=RS.getInt("BTToAccount")%></td>
            </tr>
            <%}
            }
            catch (Exception e)
            {
                out.println("no transactions found " + e);
            }
        %>
        </table>
        <br>
        <br>
        <form action="validateTransaction">
                <table cellspacing="5" border="0">
                    <tr>
                        <td align="left">bt Amount: </td>
                        <td><input type="text" name="btAmount"></td>
                    </tr>
                    <tr>
                        <td align="left">bt to Account: </td>
                        <td><input type="text" name="btToAccount"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Submit Transaction"></td>
                    </tr>
                </table>    
        </form>
        <p> ${message} </p>
        <br>
        <hr>
        <form action="cancelTransaction.jsp">
            <h2>Cancel Transaction</h2>
            <table cellspacing="5" border="0">
                <tr>
                    <td align="left"> bank transaction id:</td>
                    <td><input type="text" name="bankTransactionID"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Cancel Transaction"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
