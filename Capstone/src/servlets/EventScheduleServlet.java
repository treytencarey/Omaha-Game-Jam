package servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Event;
import database.Database;

/**
 * Servlet implementation class EventScheduleServlet
 */
@WebServlet("/EventScheduleServlet")
public class EventScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventScheduleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("event", new Event(request.getParameter("event-key")));
		RequestDispatcher rd = request.getRequestDispatcher("Events/eventSchedule.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String eventPKey = request.getParameter("EventPKey");
		String schedule = request.getParameter("eventSchedule");
		System.out.println(eventPKey);
		System.out.println(schedule);
		List<Map<String, Object>> check = Database.executeQuery("SELECT * FROM EventSchedules WHERE EventPKey=" + eventPKey);
		
		if(check.size() > 0) {
			Database.executeUpdate("UPDATE EventSchedule SET Schedule=\'" + schedule + "\' WHERE EventPKey=" + eventPKey);
		}
		else{
			Database.executeUpdate("INSERT OR REPLACE INTO EventSchedules (EventPKey, Schedule) VALUES ('" + eventPKey + "', '" + schedule + "')");
		}
	}

}
