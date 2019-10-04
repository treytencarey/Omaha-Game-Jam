<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="profile.ProfileBean"%>
    
<%
ProfileBean p = (ProfileBean)request.getAttribute("profile");
String reqId = request.getParameter("id");
String msg = null;
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Profile</title>
</head>
<body>

<%
if (reqId == null)
{
	msg = "Error: no ID specified.";
}
else
{
	if ( reqId.equals( session.getAttribute("accountPKey").toString() ) ) // If viewing own profile, display edit button.
	{
%>
	<form action="edit">
		<input type="submit" value="Edit profile">
	</form>
<%
	}
	
	if (! p.getExists())
	{
		msg = "No profile has been created for this account yet.";
	}
	else
	{
%>

	Profile picture: <img src="/profile/pics/"<%= p.getId() %>><br>
	Name: <%= p.getName() %><br>
	Bio: <%= p.getBio() %><br>
	Website: <%= p.getSite() %><br>
	Skills: <%= p.getSkills() %><br>
	
<%	
	}
	
	if (msg != null)
	{
		out.println(msg);
	}
	
}
%>

</body>
</html>