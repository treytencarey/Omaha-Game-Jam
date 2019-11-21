package servlets;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.ContributorTableBean;
import beans.GameBean;
import beans.GameTableBean;
import beans.ProfileBean;
import exceptions.EmptyQueryException;
import project.Main;

/**
 * Controller that verifies profile exists, stores necessary DB data in the session, and determines whether the logged in user can edit the profile.
 */
@WebServlet("/profile")
public class ProfileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * <ul>
	 * <li>Sets request attribute "CanEdit" depending on the logged in user</li>
	 * <li>Sets request attribute "Profile" if profile found</li>
	 * <li>Sets request attribute "Games" to an ArrayList<Game>.
	 * </ul>
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		ProfileBean p;
		ContributorTableBean ct;
		GameTableBean gt;
		boolean canEdit;
		String picPath;
		String toJsp;
		String id = request.getParameter("id");
		
		try // Does an accountPKey attribute exist in the session? If not, can't edit.
		{
			canEdit = request.getSession().getAttribute("accountPKey").equals(id); // Did the profile's owner request to see this page? If so, they can edit it.
		}
		catch (NullPointerException npe)
		{
			canEdit = false;
		}
		request.setAttribute("CanEdit", new Boolean(canEdit));
		
		try // Get the Profile from the DB
		{
			p = new ProfileBean(id);
			request.setAttribute("Profile", p);
			
			// Set profile pic path
			picPath = "/Uploads/Profiles/Pics/" + id;
			File f = new File(Main.context.getRealPath(picPath));
			//System.out.println(f.length());
        	if (!f.exists() || f.length() == 0) // Display default if file is empty or non-existent
        		picPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
        	else
        		picPath = request.getContextPath() + picPath;
			request.setAttribute("PicPath", picPath);
			
			toJsp = "Profile/view_profile.jsp";
		}
			catch (EmptyQueryException eqe)
		{
			toJsp = "Profile/empty_profile.jsp";
			System.out.println("Empty profile: " + eqe.getQuery());
			
		}
		
		ct = new ContributorTableBean();
		ct.fillByAccount(id);
		ArrayList<String> gameIds = ct.getGameIds();
		
		gt = new GameTableBean();
		gt.fillByIds(gameIds.toArray(new String[gameIds.size()]));
		request.setAttribute("Games", gt);
		
		request.getRequestDispatcher(toJsp).forward(request, response); // If all successful, forward to view_game.jsp
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
