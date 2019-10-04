<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="profile.ProfileBean" %>
	
<%
ProfileBean p = (ProfileBean)request.getAttribute("profile");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
</head>
<body>

<form action="view">
	<input type="hidden" name="id" value="<%= session.getAttribute("accountPKey").toString() %>">
	<input type="submit" value="View as guest">
</form>

<%
if ( (boolean)request.getAttribute("updateSuccessful") )
{
	out.println("Update successful!");
}
%>

	<h2>Profile info</h2>

	<form action="edit" method="POST">
		Profile picture: <input type="image" src="/profile/pics/<%= p.getId() %>"><br>
		Name: <input name="name" value="<%= p.getName() %>" ><br>
		Bio: <textarea rows="3" name="bio"><%= p.getBio() %></textarea><br>
		Website: <input name="site" value="<%= p.getSite() %>"><br>
		Skills: <textarea rows="3" name="skills"><%= p.getSkills() %></textarea><br>
		<input type="submit" value="Update profile">
	</form>
	
	<!--
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
	-->

</body>
</html>