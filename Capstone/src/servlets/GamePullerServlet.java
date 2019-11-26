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
		int gameCount = 0;
		while (i.hasNext())
		{
			GameBean g = i.next();
			String s = "";
			if (gameCount % 3 == 0) {
				s = "<div class=\"row\" style=\"margin-bottom: 50px;\">";
			}
			s = s + String.format(
					  "<div class=\"card col-sm-3 gameCard\">"
					+   "<div class=\"cardImgDiv\">"
					+     "<img class=\"card-img-top\" src=\"%s\" alt=\"Game Icon\">"
					+   "</div>"
					+   "<div class=\"card-body\">"
					+     "<h5 class=\"card-title\">%s</h5>"
					+     "<div class=\"card-text\">%s</div>"
					+     "<a href=\"%s\" class=\"btn btn-primary\">View Game</a>"
					+   "</div>"
					+ "</div>",
					request.getContextPath() + "/Uploads/Games/Thumbnails/" + g.getId(), g.getTitle(), g.getDesc(), request.getContextPath() + "/game?id=" + g.getId()
					);
			if (gameCount % 3 == 2) {
				s = s + "</div>";
			}
			gameCount++;
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
