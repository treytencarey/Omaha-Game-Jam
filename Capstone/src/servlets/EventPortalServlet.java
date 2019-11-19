package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Database;

/**
 * Servlet implementation class EventServlet
 */
@WebServlet("/EventServlet")
public class EventPortalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventPortalServlet() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Got Here");
		response.sendRedirect(request.getContextPath() + "/Events/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		/**
		 * String representing title of event
		 */
		String title = request.getParameter("title");
		
		/**
		 * String representing theme of event
		 */
		String theme = request.getParameter("theme");
		
		/**
		 * String representing description of event
		 */
		String eventDescription = request.getParameter("eventDescription");
		
		/**
		 * String array representing mutator list for event
		 */
		String[] mutators = request.getParameterValues("mutator");
		
		/**
		 * String array representing mutator descriptions for event
		 */
		String[] mutatorDescriptions = request.getParameterValues("mutatorDescription");
		
		/**
		 * String representing start date of event
		 */
		String startDate = request.getParameter("startDate");
		
		/**
		 * String representing end date of event
		 */
		String endDate = request.getParameter("endDate");
		
		/*System.out.println(request.getParameter("theme"));
		System.out.println(request.getParameter("eventDescription"));
		System.out.println(request.getParameter("eventImage"));
		System.out.println(request.getParameterValues("mutatorDescription"));
		System.out.println(request.getParameter("startDate"));
		System.out.println(request.getParameter("endDate"));

		
		for(int i = 0; i < mutators.length; i++) {
			System.out.println("Mutator "+i+": "+mutators[i]);
		}*/
		
		Database.executeUpdate("INSERT OR REPLACE INTO Events (Title, Theme, Description, StartDate, EndDate) VALUES ('" + title + "', '" + theme + "', '" + eventDescription + "', '" + startDate + "', '" + endDate + "')");
		List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Events WHERE Title=\'" + title + "\'");
		Database.executeUpdate("DELETE FROM ActiveEvent");
		Database.executeUpdate("INSERT OR REPLACE INTO ActiveEvent (EventPKey, IsPublic) VALUES ('" + query.get(0).get("PKey").toString() + "', '" + 0 + "')");
		response.sendRedirect(request.getContextPath() + "/Events/");
		
		
	}

}
