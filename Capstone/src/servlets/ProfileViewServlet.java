package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.GameBean;
import beans.ProfileBean;
import exceptions.EmptyQueryException;

/**
 * Controller that verifies profile exists, stores necessary DB data in the session, and determines whether the logged in user can edit the profile.
 */
@WebServlet("/profile")
public class ProfileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * <ul>
	 * <li>Sets request attribute "CanEdit" depending on the logged in user</li>
	 * <li>Sets request attribute "Profile" if profile found</li>
	 * </ul>
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		ProfileBean p;
		boolean canEdit;
		String toJsp;
		String id = request.getParameter("id");
		
		try // Does an accountPKey attribute exist in the session? If not, can't edit.
		{
			canEdit = request.getSession().getAttribute("accountPKey").equals(id); // Did the profile's owner request to see this page? If so, they can edit it.
		}
		catch (NullPointerException npe)
		{
			canEdit = false;
		}
		request.setAttribute("CanEdit", new Boolean(canEdit));
		
		try // Get the Profile from the DB
		{
			p = new ProfileBean(id);
			request.setAttribute("Profile", p);
			toJsp = "Profile/view_profile.jsp";
		}
			catch (EmptyQueryException eqe)
		{
			toJsp = "Profile/empty_profile.jsp";
			System.out.println("Empty profile: " + eqe.getQuery());
			
		}
		
		request.getRequestDispatcher(toJsp).forward(request, response); // If all successful, forward to view_game.jsp
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
