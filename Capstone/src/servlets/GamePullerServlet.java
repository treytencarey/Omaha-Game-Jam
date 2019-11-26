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
 * Controller that serves AJAX requests from the Game Portal to display games.
 */
@WebServlet("/gamepull")
public class GamePullerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GamePullerServlet() {
        super();
    }

	/**
	 * Returns all games submitted for a certain event as (crappy) HTML. "event", the event primary key, should be passed as a parameter.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GameTableBean gt = new GameTableBean();
		gt.fillByEvent(request.getParameter("event"));
		Iterator<GameBean> i = gt.getGames().iterator();
		while (i.hasNext())
		{
			GameBean g = i.next();
			String gameUrl = String.format("%s/game?id=%s", request.getContextPath(), g.getId());
			String picUrl = String.format("%s/Uploads/Games/Thumbnails/%s", request.getContextPath(), g.getId()); 
			
			String s = String.format(
					"<div class=\"col-sm-3\">"
					+ "<div class=\"card\">"
					+ "<a href=\"%s\"><img class=\"card-img-top zoom\" src=\"%s\" /></a>"
					+ "<div class=\"card-body dark\">"
					+ "<h5 class=\"card-title\"><a href=\"%s\">%s</a></h5>"
					+ "<p class=\"card-text\">%s</p>"
					+ "</div>"
					+ "</div>"
					+ "</div>",
					gameUrl, picUrl, gameUrl, g.getTitle(), g.getDesc()
					);
			response.getWriter().append(s);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
