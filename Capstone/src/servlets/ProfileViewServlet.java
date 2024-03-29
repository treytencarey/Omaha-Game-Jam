package servlets;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.AccountBean;
import beans.AttendeeTableBean;
import beans.ContributorTableBean;
import beans.EventTableBean;
import beans.GameTableBean;
import beans.ProfileBean;
import beans.RoleTableBean;
import database.Account;
import database.Contributor;
import exceptions.EmptyQueryException;
import project.Main;
import constants.ProfileConstants;
import constants.SessionConstants;

/**
 * Controller that verifies profile exists, stores necessary DB data in the session, and determines whether the logged in user can edit the profile.
 */
@WebServlet("/profile")
public class ProfileViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UNSET_PICPATH = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
	private static final String EMPTY_PAGE = "Profile/empty_profile.jsp";
	private static final String HIDDEN_PAGE = "Profile/hidden_profile.jsp";
	private static final String SUCCESS_PAGE = "Profile/view_profile.jsp";
	
       
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
		ProfileBean p; // Holds info about this profile
		AccountBean a; // Used for retrieving this profile's email
		//AttendeeTableBean at; // List of attended records (AttendeeBean)
		//EventTableBean et; // List of Event objects this account has attended
		ContributorTableBean ct;
		RoleTableBean rt;
		GameTableBean gt;
		boolean isOwner; // Is the viewing user the owner of this profile?
		boolean isPublic = true; // Is the profile public?
		String picPath; // Real path to this user's profile picture
		String toPage = SUCCESS_PAGE; // Page to redirect to
		String id = request.getParameter("id");
		
		try // Does an accountPKey attribute exist in the session? If not, can't edit.
		{
			HttpSession s = request.getSession(false);
			String apk = s.getAttribute(SessionConstants.ACCOUNT_PKEY).toString();
			isOwner = apk.equals(id); // Did the profile's owner request to see this page? If so, they can edit it.
		}
		catch (NullPointerException npe)
		{
			isOwner = false;
		}
		request.setAttribute(ProfileConstants.CAN_EDIT, new Boolean(isOwner));
		
		try // Get the Profile from the DB
		{
			// Store Profile in request
			p = new ProfileBean(id);
			request.setAttribute(ProfileConstants.PROFILE, p);
			
			// Check profile's status
			if (!p.isPublic() && ! Account.isAdmin(request.getSession())) // If the profile is hidden and the user isn't an admin,
			{
				isPublic = false;
				if (! isOwner) // AND the user doesn't own the profile
					toPage = HIDDEN_PAGE; // Can't view
			}
			request.setAttribute(ProfileConstants.IS_PUBLIC, new Boolean(isPublic)); // Can view
			
			// Set profile pic path
			picPath = "/Uploads/Profiles/Pics/" + id;
			File f = new File(Main.context.getRealPath(picPath));
        	if (!f.exists() || f.length() == 0) // Display default if file is empty or non-existent
        		picPath = UNSET_PICPATH;
        	else
        		picPath = request.getContextPath() + picPath;
			request.setAttribute(ProfileConstants.PIC_PATH, picPath);
		}
		catch (EmptyQueryException eqe)
		{
			toPage = EMPTY_PAGE;
			System.out.println("Empty profile: " + eqe.getQuery());
		}
		catch (NullPointerException npe) // Session expired
		{
			
		}
		
		try
		{
			a = new AccountBean(id);
			request.setAttribute(ProfileConstants.EMAIL, a.getEmail()); // Currently only need email, so don't send the entire bean.
		}
		catch (EmptyQueryException eqe)
		{
			System.out.println("Account not found. How is this possible???");
		}
		
		//at = new AttendeeTableBean();
		//at.fillByAccountIds(id);
		//et = new EventTableBean();
		
		//request.setAttribute(ProfileConstants.ATTENDED_EVENTS, et);
		
		ct = new ContributorTableBean();
		ct.fillByAccount(id);
		
		// Creating a Map, using GamePKey as an index to retrieve a value ArrayList<String> of the roleIDs
		Map<String, ArrayList<String>> roles = new HashMap<String, ArrayList<String>>(); // Map from 1 game to 1..n roles
		ArrayList<String> rids = new ArrayList<String>();
		Iterator<Contributor> ic = ct.getContributors().iterator();
		while (ic.hasNext()) // For each contribution
		{
			Contributor c = ic.next();
			if (roles.get(c.getGamePKey()) == null) // If this is the first contribution related to a certain game, create an ArrayList.
				roles.put(c.getGamePKey(), new ArrayList<String>());
			roles.get(c.getGamePKey()).add(c.getRolePKey());
			rids.add(c.getRolePKey());
		}
		rt = new RoleTableBean();
		rt.fillByIds(rids.toArray(new String[rids.size()])); // RoleTableBean filled with all ID/Titles this user has contributed
		// Loop over the previously created Map and replace RoleIDs with RoleTitles
		for (Map.Entry<String, ArrayList<String>> r : roles.entrySet()) // For each game
		{
			for (int j = 0; j < r.getValue().size(); j++) // For each role associated to a particular game
			{
				ArrayList<String> ids = r.getValue(); // Get the ArrayList of Role IDs
				ids.set(j, rt.getTitle(ids.get(j))); // Replace the ArrayList element (ID) with Title
			}
		}
		request.setAttribute(ProfileConstants.ROLES, roles);
		
		ArrayList<String> gameIds = ct.getGameIds();
		gt = new GameTableBean();
		gt.fillByIds(gameIds.toArray(new String[gameIds.size()]));
		request.setAttribute(ProfileConstants.GAMES, gt);
		
		request.getRequestDispatcher(toPage).forward(request, response); // If all successful, forward to view_game.jsp
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
