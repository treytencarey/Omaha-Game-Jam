package database;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.GameBean;

/**
 * Controller that verifies input for viewing game pages
 */

public class GameServlet extends HttpServlet {
	
	private static final String SUCCESS_JSP = "view_game.jsp";
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameServlet() {
        super();
    }

	/**
	 * Handle the business logic for viewing games.
	 * <ul>
	 * <li>Validate game exists</li>
	 * <li>Retrieve and store the requested game and contributors in Beans ("Game" and "ContributorTable" respectively)</li>
	 * <li>Determine if the logged in user can edit, and store as "CanEdit" attribute</li>
	 * </ul>
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		GameBean g; // Bean to store all game info in; to be passed to the JSP
		MutatorTableBean mt;
		ContributorTableBean ct;
		HttpSession session; // User's session, used to retrieve AccountPKey
		Object apk; // The user's AccountPKey
		Boolean canEdit; // Attribute send to JSP that determines if logged in user can edit the current Game (logged in? registered for current event? submittor? contributor?)
		
		/**
		 * ID-related error checking
		 */
		try
		{
			g = new GameBean(id);
		}
			catch (NullPointerException npe)
		{
			response.getWriter().append("Game page doesn't exist for ID " + id);
			return;
		}
		if (g.getIsPublic().equals("0"))
		{
			response.getWriter().append("Game page not public.");
			return;
		}
		request.setAttribute("Game", g); // Store GameBean in request for JSP to retrieve it from
		mt = new MutatorTableBean(id);
		ct = new ContributorTableBean(id);
		request.setAttribute("MutatorTable", mt);
		request.setAttribute("ContributorTable", ct);
		
		/**
		 * Determine if logged in user can edit
		 */
		canEdit = new Boolean(false);
		session = request.getSession();  
		
		apk = session.getAttribute("accountPKey");
		if (apk != null)
		{
			String s = apk.toString();
			if (s.equals(g.getSubmitter())) // Is user the submittor?
				canEdit = new Boolean(true);
			for(Contributor c : ct.getContributors()) // Is the user a contributor?
			{
				//System.out.println();
				if (apk.toString().equals(c.getAccountPKey()))
				{
					canEdit = new Boolean(true);
					break;
				}
			}
		}
		request.setAttribute("CanEdit", canEdit);
        request.getRequestDispatcher(SUCCESS_JSP).forward(request, response); // If all successful, forward to view_game.jsp
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
