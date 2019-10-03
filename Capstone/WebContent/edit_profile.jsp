<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="database.Database,java.util.List,java.util.Map" %>
	
<%!
// After querying and getting a map of results, use this to retreive a value.
private String tryGetParam(Map<?, ?> map, String name)
{
	String res; 
	try
	{
		res = map.get(name).toString();
	}
	catch(NullPointerException npe)
	{
		res = "";
	}
	
	return res;
}
%>
	
<%
// If redirected from edit_profile after an update, try to put the requested fields into the DB.
if (request.getParameter("name") != null)
{
	//int id = 2;
	String idStr = session.getAttribute("accountPKey").toString();
	
	// Check whether to update or insert
	List<?> result = Database.executeQuery( String.format("SELECT COUNT(*) FROM Profiles WHERE AccountID=%s", idStr) );
	if (result.size() > 0)
	{
		Map<?, ?> map = (Map<?, ?>) result.get(0);
		int count = Integer.parseInt( map.get("COUNT(*)").toString() );

		String pu = request.getParameter("picURL");
		String n = request.getParameter("name");
		String b = request.getParameter("bio");
		String w = request.getParameter("site");
		String s = request.getParameter("skills");
		

		String cmd;
		if (count == 0)
		{
			cmd = String.format("INSERT INTO Profiles (AccountID, ProfilePicURL, Name, Bio, Website, SkillsList) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')",
					idStr, pu, n, b, w, s);
		}
		else
		{
			cmd = String.format("UPDATE Profiles SET ProfilePicURL = '%s', Name = '%s', Bio = '%s', Website = '%s', SkillsList = '%s' WHERE AccountID=%s",
					pu, n, b, w, s, idStr);
		}
		// Execute the command
		Database.executeUpdate(cmd);
	}
%>
<p>Updated successfully!</p>	
<%
}
%>	


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
</head>
<body>
	<h2>Profile info</h2>

	<%
	// Query Profiles to fill in inputs with existing fields
	String picURL, name, bio, site, skills;
	picURL = name = bio = site = skills = "";
	List<?> result = Database.executeQuery( String.format("SELECT * FROM Profiles WHERE AccountID=%s", session.getAttribute("accountPKey").toString()) );
	if (result.size() > 0)
	{
		Map<?, ?> map = (Map<?, ?>) result.get(0);
		picURL = tryGetParam(map, "ProfilePicURL");
		name = tryGetParam(map, "Name");
		bio = tryGetParam(map, "Bio");
		site = tryGetParam(map, "Website");
		skills = tryGetParam(map, "SkillsList");
	}
	%>
	<form action="edit_profile.jsp" method="POST">
		Profile picture: <input type="image" src="<%= picURL %>"><br>
		Name: <input name="name" value="<%= name %>"><br>
		Bio: <textarea rows="3" name="bio"><%= bio %></textarea><br>
		Website: <input name="site" value="<%= site %>"><br>
		Skills: <textarea rows="3" name="skills"><%= skills %></textarea><br>
		<input type="submit" value="Update profile">
	</form>
	
	<h2>Account</h2>
	<form>
		Email: <input type="email"><br>
		Display on profile: <textarea rows="3"></textarea><br>
		<input type="submit" value="Update account">
	</form>
	
	<h2>Password</h2>
	<form>
		New password: <input type="password"><br>
		Confirm new password: <input type="password"><br>
		<input type="submit" value="Update password">
	</form>

</body>
</html>