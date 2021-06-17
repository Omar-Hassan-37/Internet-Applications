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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author oh377
 */
@WebServlet(urlPatterns = {"/validateTransaction"})
public class validateTransaction extends HttpServlet {

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
                String cus_id = "";
                int bt_amount = 0;
                String bt_to_account = "";
                //ResultSet RS2 = null;

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();
                
                //DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
                //LocalDateTime now = LocalDateTime.now();  
                //dtf.format(now));
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date now = new Date(System.currentTimeMillis());
                
                
                cus_id = request.getSession().getAttribute("customerID").toString();
                bt_amount = Integer.parseInt(request.getParameter("btAmount"));
                bt_to_account = request.getParameter("btToAccount");
                
                RS = Stmt.executeQuery("SELECT * FROM bankaccount WHERE CustomerID = '" + cus_id + "';");
                RS.next();
                int cu1_bankID = RS.getInt("BankAccountID");
         
                //RS2 = Stmt.executeQuery("SELECT BACurrentBalance FROM bankaccount where CustomerID = '" + cus_id + "';");
                if(RS.getInt("BACurrentBalance") >= bt_amount)
                {
                    
                    int cus_newb  = 0;
                    cus_newb = RS.getInt("BACurrentBalance") - bt_amount;
                    
                    int row1 = Stmt.executeUpdate("UPDATE bankaccount SET BACurrentBalance = '" + cus_newb + "' WHERE BankAccountID = '" + cu1_bankID + "';");
                   
                    RS.close();
                    
                    ResultSet RS1 = null;
                    RS1 = Stmt.executeQuery("SELECT * FROM bankaccount WHERE CustomerID = '" + bt_to_account + "';");
                    RS1.next();
                    
                    int toCus_newb = 0;
                    toCus_newb = RS1.getInt("BACurrentBalance") + bt_amount;
                    
                    int row2 = Stmt.executeUpdate("UPDATE bankaccount SET BACurrentBalance = '" + toCus_newb + "' WHERE BankAccountID = '" + RS1.getInt("BankAccountID") + "';");
                    RS1.close();
                    
                    int row = Stmt.executeUpdate("INSERT INTO banktransaction(btCreationDate, btAmount, btFromAccount, btToAccount)"
                        + "VALUES('" + sdf.format(now) + "','" + bt_amount + "','" + cus_id + "','" + bt_to_account + "');");
                    
                    if(row != 0)
                    {
                        String message = "transaction succeeded";
                        request.setAttribute("message", message);
                        request.getRequestDispatcher("transactions.jsp").forward(request, response);
                    }
                }
                
                Stmt.close();
                Con.close();
                
                String message = "transaction failed";
                request.setAttribute("message", message);
                request.getRequestDispatcher("transactions.jsp").forward(request, response);
                
            }catch (Exception e) {
                String message = "transaction failed";
                request.setAttribute("message", message);
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
