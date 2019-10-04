package profile;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import database.Database;

public class ProfileDB {
	
	/*
	 * Get the URL of a profile picture for the specified AccountID.
	 */
	public static String getProfilePicURL(String id)
	{
		return String.format( "/profile/pic/%s", id);
	}
	
	/*
	 * If parameters exist, try to put them into the Profiles DB.
	 */
	public static boolean tryUpdateDBFromParams( HttpServletRequest request )
	{
		boolean success = false;
		String n, b, w, s;
		n = request.getParameter("name");
		if (n != null && ! n.equals("")) // Assume if name isn't empty, others aren't either.
		{
			String id = request.getSession().getAttribute("accountPKey").toString();
			List<?> result = Database.executeQuery( String.format("SELECT COUNT(*) FROM Profiles WHERE AccountID=%s", id) );
			
			if (result.size() > 0) // If query successful,
			{
				Map<?, ?> map = (Map<?, ?>) result.get(0);
				int count = Integer.parseInt( map.get("COUNT(*)").toString() );
				
				n = request.getParameter("name");
				b = request.getParameter("bio");
				w = request.getParameter("site");
				s = request.getParameter("skills");
				
				String cmd;
				if (count == 0) // Doesn't exist yet, so create.
				{
					cmd = String.format("INSERT INTO Profiles (AccountID, Name, Bio, Website, SkillsList) VALUES ('%s', '%s', '%s', '%s', '%s')",
							id, n, b, w, s);
				}
				else // Already exists, so update.
				{
					cmd = String.format("UPDATE Profiles SET Name = '%s', Bio = '%s', Website = '%s', SkillsList = '%s' WHERE AccountID=%s",
							n, b, w, s, id);
				}
				
				Database.executeUpdate(cmd);
				success = true;
			}
		}
		return success;
	}
	
	/*
	 * Query the Profiles table and return a ProfileBean with the values from the AccountID profile. If profile doesn't exist, everything is set to "".
	 */
	public static ProfileBean fetchProfileFromDB( String accountID)
	{
		ProfileBean pb = new ProfileBean();
		List<?> result = Database.executeQuery( String.format("SELECT * FROM Profiles WHERE AccountID=%s", accountID ) );
		
		if (result.size() > 0)
		{
			Map<?, ?> map = (Map<?, ?>) result.get(0);
			
			pb.setId( Database.tryGetValue(map, "AccountID") );
			//p.Database.tryGetValue(map, "ProfilePicURL");
			pb.setName( Database.tryGetValue(map, "Name") );
			pb.setBio( Database.tryGetValue(map, "Bio") );
			pb.setSite( Database.tryGetValue(map, "Website") );
			pb.setSkills( Database.tryGetValue(map, "SkillsList") );
			
			pb.updateIsBlank();
			pb.setExists(true);
		}
		
		return pb;
	}
}
