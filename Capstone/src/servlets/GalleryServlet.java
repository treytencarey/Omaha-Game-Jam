package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Event;
import beans.EventTableBean;

/**
 * Servlet implementation class GalleryServlet
 */
@WebServlet("/GalleryServlet")
public class GalleryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DESTINATION_JSP = "Gallery/index.jsp";
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GalleryServlet() {
		super();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		EventTableBean eventTable = new EventTableBean();
		
		/**
		 * Setup gallery page for the current event if no id is given
		 */
		try {
			ArrayList<Event> pastEvents = eventTable.getPastEvents();
			if(id == null) {
				request.setAttribute("events", pastEvents);
				request.getRequestDispatcher(DESTINATION_JSP).forward(request, response);
				return;
			}
		} catch(Exception ex) {
			System.err.println(ex);
			return;
		}
	}
}
