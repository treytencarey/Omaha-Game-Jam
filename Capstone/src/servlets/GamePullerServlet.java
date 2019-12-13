package servlets;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.GameBean;
import beans.GameTableBean;
import database.Account;


/**
 * Controller that serves AJAX requests from the Game Portal to display games. Currently serves HTML, but in the future, should just send JSON/XML.
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
		HttpSession session = request.getSession();
		boolean isAdmin = Account.isAdmin(session);
		
		while (i.hasNext())
		{
			GameBean g = i.next();
			String color = "";
			String s = "";
			String gameStatus = "";
			String displayBanner = "none";
			
			if (! isAdmin)
			{
				if (! g.isPublic())
				{
					continue;
				}
			}
			else // If user is admin, change colors of game cards to reflect their moderation status.
			{
				displayBanner = "unset";
				switch (g.getStatus())
				{
				case "-1":
					color = "red";
					gameStatus = "Not Public, Verfified";
					break;
				case "0":
					color = "yellow";
					gameStatus = "Not Public, Unverfified";
					break;
				case "1":
					color = "greenyellow";
					gameStatus = "Public, Unverfified";
					break;
				case "2":
					color = "green";
					gameStatus = "Public, Verfified";
					break;
				}
			}
			
			if (gameCount % 3 == 0) {
				s = "<div class=\"row\" style=\"margin-bottom: 50px;\">";
			}
			s = s + String.format(
					  "<div class=\"card col-sm-3 gameCard\" style='border: solid 5px %s;'>"
					+   "<div class=\"gameTypeBanner\" style=\"border-bottom: 50px solid %s; display: %s;\">%s</div>"
					+   "<div class=\"cardImgDiv\">"
					+     "<img class=\"card-img-top\" src=\"%s\" alt=\"Game Icon\">"
					+   "</div>"
					+   "<div class=\"card-body\">"
					+     "<h5 class=\"card-title\">%s</h5>"
					+     "<div class=\"card-text\">%s</div>"
					+     "<a href=\"%s\" class=\"btn btn-primary\">View Game</a>"
					+   "</div>"
					+ "</div>",
					color, color, displayBanner, gameStatus, request.getContextPath() + "/Uploads/Games/Thumbnails/" + g.getId(), g.getTitle(), g.getDesc(), request.getContextPath() + "/game?id=" + g.getId()
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
