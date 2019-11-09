package database;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.GameBean;

/**
 * Controller that verifies input for viewing game pages
 */
@WebServlet("/GameServlet")
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		List<Map<String, Object>> query; // Map of all games returned from DB, should only have 1
		Map<String, Object> game; // Single game Map from col name to value
		GameBean g; // Bean to store all game info in; to be passed to the JSP
		
		/**
		 * ID-related error checking
		 */
		if (id == null) // ID supplied?
		{
			response.getWriter().append("No ID suppled.");
			return;
		}
		query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + id);
		if (query.size() == 0) // ID exists?
		{
			response.getWriter().append("Game page doesn't exist for ID " + id);
			return;
		}
		game = query.get(0);
		if (game.get("IsPublic").toString() == "0") // Game page public?
		{
			response.getWriter().append("Game page not public.");
			return;
		}
		
		/**
		 * Create a GameBean to stash DB data in
		 */
		g = new GameBean();
		g.setId(id);
		
		g.setEvent(game.get("EventPKey").toString());
		g.setSubmitter(game.get("SubmitterPKey").toString());
		g.setTitle(game.get("Title").toString());
		g.setDesc(game.get("Description").toString());
		g.setLink(game.get("PlayLink").toString());
		g.setIsPublic(game.get("IsPublic").toString());
		
		request.setAttribute("Game", g); // Store GameBean in request for JSP to retrieve it from
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
