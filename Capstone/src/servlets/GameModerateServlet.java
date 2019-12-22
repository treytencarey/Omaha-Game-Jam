package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.GameBean;
import exceptions.EmptyQueryException;
import exceptions.UnsuccessfulUpdateException;

/**
 * This is a slopped-together Servlet to handle game moderation.
 */
@WebServlet("/game_moderate")
public class GameModerateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameModerateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String status = request.getParameter("status");
		String id = request.getParameter("id");
		try {
			GameBean g = new GameBean(id);
			g.setStatus(status);
			g.writeChanges();
		} catch (UnsuccessfulUpdateException uue) {
			System.out.println("Problem updating status.");
			System.out.println(uue.getQuery());
			System.out.println(uue.getMessage());
		}
		response.sendRedirect("game?id=" + id);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
