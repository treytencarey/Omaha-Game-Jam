package profile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Database;

/**
 * Servlet implementation class ViewProfile
 */
@WebServlet(description = "For viewing the profile of any particular user.", urlPatterns = { "/profile/view" })
public class ViewProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Fetch and set profile attribute.
		ProfileBean p = ProfileDB.fetchProfileFromDB( request.getParameter( "id" ) );
		request.setAttribute("profile", p);
		
		// Forward to destination
        RequestDispatcher rd = request.getRequestDispatcher( "/view_profile.jsp" );  
        rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public List<Map<String, Object>> getProfileValues( String id ) {
		return Database.executeQuery( String.format("SELECT * FROM Profiles WHERE AccountID=%s", id ) );
	}

}
