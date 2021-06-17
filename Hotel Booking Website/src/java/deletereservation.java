

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import IA_Project.Util.HibernateUtil;
import IA_Project.WebData.Reservation;
import IA_Project.WebData.User;

/**
 * Servlet implementation class deletereservation
 */
@WebServlet("/deletereservation")
public class deletereservation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deletereservation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		Reservation reservation = (Reservation) request.getSession(false).getAttribute("currentReservation");
		
		
		
		
		Session sess = HibernateUtil.getInstance().getSession();
		reservation.setCancelled(true);
		reservation.setActive(false);
		Transaction t = sess.beginTransaction();
		User user = reservation.getUser();
		EmailHandler.sendEmail(user.getEmail(), "user deleted " + reservation.getHotel().getName(), "user dleeted hist bta3");
		sess.update(reservation.getHotel());
		sess.update(reservation);
		t.commit();
		sess.close();
		response.getWriter().println("reservation deleted");
	}

}
