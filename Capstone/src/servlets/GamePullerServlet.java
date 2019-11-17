package servlets;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.GameBean;
import beans.GameTableBean;


/**
 * This serves AJAX calls from the Game Portal.
 */
@WebServlet("/gamepull")
public class GamePullerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GamePullerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		GameTableBean gt = new GameTableBean(request.getParameter("event"));
		Iterator<GameBean> i = gt.getGames().iterator();
		while (i.hasNext())
		{
			GameBean g = i.next();
			String s = String.format(
					"<div>"
					+ "<h2><a href=\"%s\">%s</a></h2>"
					+ "<p>%s</p>"
					+ "</div>",
					request.getContextPath() + "/game?id=" + g.getId(), g.getTitle(), g.getDesc()
					);
			response.getWriter().append(s);
		}
		//response.getWriter().append("You asked to pull games for event " + request.getParameter("event"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
