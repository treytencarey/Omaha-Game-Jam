package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ProfileBean;
import exceptions.EmptyQueryException;
import exceptions.UnsuccessfulUpdateException;

/**
 * Handles moderation actions related to profiles. For instance, when a profile is either denied or verified by an admin.
 */
@WebServlet("/profile_moderate")
public class ProfileModerateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileModerateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * Take the status and id parameters and update the Profiles table to reflect the profile's new status.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String status = request.getParameter("status");
		String id = request.getParameter("id");
		try {
			ProfileBean p = new ProfileBean(id);
			p.setStatus(status);
			p.writeChanges();
		} catch (EmptyQueryException eqe) {
			System.out.println("Problem getting profile during status update.");
			System.out.println(eqe.getQuery());
		} catch (UnsuccessfulUpdateException uue) {
			System.out.println("Problem updating status.");
			System.out.println(uue.getQuery());
			System.out.println(uue.getMessage());
		}
		response.sendRedirect("profile?id=" + id);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
