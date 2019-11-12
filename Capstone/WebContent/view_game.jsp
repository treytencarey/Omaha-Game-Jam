<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="database.GameBean, database.Profile, database.ContributorTableBean, database.Contributor, database.RoleTableBean, database.Role, database.Mutator, database.MutatorTableBean" %>

<%
GameBean g = ((GameBean)request.getAttribute("Game"));
MutatorTableBean mt = ((MutatorTableBean)request.getAttribute("MutatorTable"));
ContributorTableBean ct = ((ContributorTableBean)request.getAttribute("ContributorTable"));
boolean canEdit = ((Boolean)request.getAttribute("CanEdit")).booleanValue();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= g.getTitle() %></title>
</head>
<body>

<%
if (canEdit)
{
%>
	<button>Edit</button>
<%
}
%>

	<img src="<%= request.getContextPath() %>/Uploads/Games/Thumbnails/<%= g.getId() %>"><br>
	<h1><%= g.getTitle() %></h1><br>
	<p><%= g.getDesc() %></p>
	<h2>Mutators</h2>
	<table>
	<%
	for(Mutator m : mt.getMutators())
	{
	%>
		<tr>
			<td><%= m.getTitle() %></td>
			<td><%= m.getDesc() %></td>
		</tr>
	<%
	}
	%>
	</table>
	
	<!--
	<i>For event with a key of <%= g.getEvent() %></i><br>
	<i>Submitted by account with key of <%= g.getSubmitter() %></i><br>
	  -->
	  
	<h2>Play now!</h2>
	<a href="<%= g.getLink() %>"><%= g.getLink() %></a>
	
<h2>Contributors</h2>
<table>
<%
for(Contributor c : ct.getContributors())
{
	Profile p = new Profile(Integer.parseInt(c.getAccountPKey()));
	RoleTableBean rti = new RoleTableBean(c.getRolePKey());
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