<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="database.Game, database.Profile, database.ContributorTableInterface, database.Contributor, database.RoleTableInterface, database.Role" %>

<%
Game g = new Game(1);
ContributorTableInterface cti = new ContributorTableInterface(1);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= g.getTitle() %></title>
</head>
<body>

	<img src="<%= request.getContextPath() %>/Uploads/Games/Thumbnails/<%= g.getId() %>"><br>
	<h1><%= g.getTitle() %></h1><br>
	<p><%= g.getDesc() %></p>
	<h2>Mutators</h2>
	<ul>
		<li>These are placeholder</li>
		<li>These should query the Mutators table for all mutators with an EventPKey of <%= g.getEvent() %></li>
		<li>DYLAN!!!!!!!!!!</li> 
	</ul>
	<i>For event with a key of <%= g.getEvent() %></i><br>
	<i>Submitted by account with key of <%= g.getSubmitter() %></i><br>
	<h2>Play now!</h2>
	<a href="<%= g.getLink() %>"><%= g.getLink() %></a>
	
<h2>Contributors</h2>
<table>
<%
for(Contributor c : cti.getContributors())
{
	Profile p = new Profile(Integer.parseInt(c.getAccountPKey()));
	RoleTableInterface rti = new RoleTableInterface(c.getRolePKey());
%>
	<tr>
		<td><img height="32" width="32" src="<%= request.getContextPath() + "/Uploads/Profiles/Pics/" + c.getAccountPKey() %>"></td>
		<td><a href="<%= request.getContextPath() + "/profile?id=" + c.getAccountPKey() %>"> <%= p.getName() %> </a></td>
		<td><%= rti.getTitle() %></td>
	</tr>
<%
}
%>
</table>

</body>
</html>