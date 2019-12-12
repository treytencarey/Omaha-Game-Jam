package database;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * Handles interactions between an account and profiles.
 *
 */
@WebServlet("/profileServlet")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * The name of the account (email/username).
	 */
	private String name="";
	/**
	 * The bio of the profile.
	 */
	private String bio="";
	/**
	 * The website of the profile.
	 */
	private String website="";
	/**
	 * The skills of the profile.
	 */
	private String skills="";
	
	/**
	 * Handles form submissions for the profileServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		boolean updatingProfile = request.getParameter("update") != null;
		if (updatingProfile)
		{
			System.out.println("HIIIII");
			new Profile(request.getParameter("name").toString(), request.getParameter("bio").toString(), request.getParameter("site").toString(), request.getParameter("skills").toString()).updateProfile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
			
			session.setAttribute("updateProfileMessage", "Update successful!");
			response.sendRedirect(session.getAttribute("curPage").toString());
			return;
		}
	}
	
	/**
	 * Gets a profile from the database.
	 * @param PKey an integer value of the profile's primary key.
	 */
	public Profile(int PKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Profiles WHERE AccountPKey=" + String.valueOf(PKey));
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> account = query.get(0);
		
		this.setName(account.get("Name").toString());
		this.setBio(account.get("Bio").toString());
		this.setWebsite(account.get("Website").toString());
		this.setSkills(account.get("SkillsList").toString());
	}
	
	/**
	 * Gets a profile based on the given values.
	 * @param name a string of the name of the account (email/username).
	 * @param bio a string of the profile's bio.
	 * @param website a string of the profile's website.
	 * @param skills a string of the profile's skills.
	 */
	public Profile(String name, String bio, String website, String skills)
	{
		this.setName(name);
		this.setBio(bio);
		this.setWebsite(website);
		this.setSkills(skills);
	}
	
	/**
	 * Gets a blank profile.
	 */
	public Profile()
	{
		
	}
	
	/**
	 * Gets the profile as a string.
	 * @return The profile as a string.
	 */
	@Override
	public String toString()
	{
		return "'" + Database.formatString(name) + "' , '" + Database.formatString(bio) + "', '" + Database.formatString(website) + "', '" + Database.formatString(skills) + "'";
	}
	
	/**
	 * Updates the profile in the database with the given primary key to the values of the profile.
	 * @param PKey an integer value of the profile's primary key.
	 */
	public void updateProfile(int PKey)
	{
		Database.executeUpdate("INSERT OR REPLACE INTO Profiles (AccountPKey, Name, Bio, Website, SkillsList) VALUES (" + String.valueOf(PKey) + ", " + this.toString() + ")");
	}
	
	/**
	 * Gets the name of the profile (email/username).
	 * @return The name of the profile (email/username).
	 */
	public String getName()
	{
		return this.name;
	}
	
	/**
	 * Gets the bio of the profile.
	 * @return The bio of the profile.
	 */
	public String getBio()
	{
		return this.bio;
	}
	
	/**
	 * Gets the website of the profile.
	 * @return The website of the profile.
	 */
	public String getWebsite()
	{
		return this.website;
	}
	
	/**
	 * Gets the skills of the profile.
	 * @return The skills of the profile.
	 */
	public String getSkills()
	{
		return this.skills;
	}
	
	/**
	 * Sets the name of the profile.
	 * @param name a string of the name (email/username).
	 */
	public void setName(String name)
	{
		this.name = name;
	}
	
	/**
	 * Sets the bio of the profile.
	 * @param bio a string of the bio.
	 */
	public void setBio(String bio)
	{
		this.bio = bio;
	}
	
	/**
	 * Sets the website of the profile.
	 * @param website a string of the website.
	 */
	public void setWebsite(String website)
	{
		this.website = website;
	}
	
	/**
	 * Sets the skills of the profile.
	 * @param skills a string of the skills.
	 */
	public void setSkills(String skills)
	{
		this.skills = skills;
	}
}
