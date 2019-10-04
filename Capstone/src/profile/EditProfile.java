package profile;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditProfile
 */
@WebServlet(description = "For editing the profile of the logged-in user.", urlPatterns = { "/profile/edit" })
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String forwardTo;
		ProfileBean p = new ProfileBean();
		Object idObject = request.getSession().getAttribute("accountPKey");
		
		if(idObject == null) // If not logged in and user tries to access this page, send them back to the homepage
		{
			forwardTo = "/";
		}
		else // Fetch profile from DB and store in ProfileBean
		{
			forwardTo = "/edit_profile.jsp";
			request.setAttribute( "updateSuccessful", ProfileDB.tryUpdateDBFromParams(request) );
			p = ProfileDB.fetchProfileFromDB( request.getSession().getAttribute("accountPKey").toString() );
		}
		
		// Forward to destination
		request.setAttribute("profile", p);
        RequestDispatcher rd = request.getRequestDispatcher( forwardTo );  
        rd.forward(request, response); 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
