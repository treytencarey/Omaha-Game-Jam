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

@WebServlet("/profileServlet")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String name="";
	private String bio="";
	private String website="";
	private String skills="";
	
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		boolean updatingProfile = request.getParameter("update") != null;
		if (updatingProfile)
		{
			new Profile(request.getParameter("name").toString(), request.getParameter("bio").toString(), request.getParameter("site").toString(), request.getParameter("skills").toString()).updateProfile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
			
			session.setAttribute("message", "Update successful!");
			response.sendRedirect(session.getAttribute("curPage").toString());
			return;
		}
	}
	
	public Profile(int PKey)
	{
		System.out.println(PKey);
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Profiles WHERE AccountPKey=" + String.valueOf(PKey));
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> account = query.get(0);
		
		this.setName(account.get("Name").toString());
		this.setBio(account.get("Bio").toString());
		this.setWebsite(account.get("Website").toString());
		this.setSkills(account.get("SkillsList").toString());
	}
	
	public Profile(String name, String bio, String website, String skills)
	{
		this.setName(name);
		this.setBio(bio);
		this.setWebsite(website);
		this.setSkills(skills);
	}
	
	public Profile()
	{
		
	}
	
	@Override
	public String toString()
	{
		return "'" + Database.formatString(name) + "' , '" + Database.formatString(bio) + "', '" + Database.formatString(website) + "', '" + Database.formatString(skills) + "'";
	}
	
	private void updateProfile(int PKey)
	{
		Database.executeUpdate("INSERT OR REPLACE INTO Profiles (AccountPKey, Name, Bio, Website, SkillsList) VALUES (" + String.valueOf(PKey) + ", " + this.toString() + ")");
	}
	
	public String getName()
	{
		return this.name;
	}
	
	public String getBio()
	{
		return this.bio;
	}
	
	public String getWebsite()
	{
		return this.website;
	}
	
	public String getSkills()
	{
		return this.skills;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setBio(String bio)
	{
		this.bio = bio;
	}
	
	public void setWebsite(String website)
	{
		this.website = website;
	}
	
	public void setSkills(String skills)
	{
		this.skills = skills;
	}
}
