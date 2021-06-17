/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author oh377
 */
@WebServlet(urlPatterns = {"/confirmTransCancel"})
public class confirmTransCancel extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
             try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                String url = "jdbc:mysql://localhost:3306/bankdb";
                String user = "root";
                String password = "3773";
                Connection Con = null;
                Statement Stmt = null;
                ResultSet RS = null;
                
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date now = new Date(System.currentTimeMillis());
                
                String cus_id = request.getSession().getAttribute("customerID").toString();
                String bt_id = request.getSession().getAttribute("bankTransactionID").toString();
                
                
                
                RS = Stmt.executeQuery("SELECT * FROM banktransaction where bankTransactionID = '" + bt_id + "' and btFromAccount = '" + cus_id + "';");
                RS.next();
               
                
                String fromAccount = RS.getString("btFromAccount");
                String toAccount = RS.getString("btToAccount");
                int amount = RS.getInt("btAmount");
                String date = RS.getString("btCreationDate");
                
                Date btc_date = sdf.parse(date);
                
                out.println((Math.abs(btc_date.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)) % 365);
                
                RS.close();
                
                if((Math.abs(btc_date.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)) % 365<1)
                {
                    ResultSet RS1 = null;
                    RS1 = Stmt.executeQuery("SELECT * FROM bankaccount WHERE CustomerID = '" + fromAccount + "';");
                    RS1.next();
                    int fromAccount_newb = RS1.getInt("BACurrentBalance") + amount;
                    int row1 = Stmt.executeUpdate("UPDATE bankaccount SET BACurrentBalance = '" + fromAccount_newb + "' WHERE BankAccountID = '" + RS1.getInt("bankAccountID") + "';");
                    RS1.close();
                    
                    ResultSet RS2 = null;
                    RS2 = Stmt.executeQuery("SELECT * FROM bankaccount WHERE CustomerID = '" + toAccount + "';");
                    RS2.next();
                    int toAccount_newb = RS2.getInt("BACurrentBalance") - amount;
                    int row2 = Stmt.executeUpdate("UPDATE bankaccount SET BACurrentBalance = '" + toAccount_newb + "' WHERE BankAccountID = '" + RS2.getInt("bankAccountID") + "';");
                    RS2.close();
                    
                    int row3 = Stmt.executeUpdate("DELETE FROM banktransaction WHERE bankTransactionID= '" + bt_id + "' ");
                    
                    Stmt.close();
                    Con.close();
                    
                    response.sendRedirect("transactions.jsp");
                }
                
            }catch (Exception e) {
                String message1 = "process failed";
                request.setAttribute("message", message1);
                request.getRequestDispatcher("transactions.jsp").forward(request, response);
                out.print("Error" + e);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
