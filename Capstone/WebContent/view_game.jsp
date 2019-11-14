<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="utils.FolderReader, database.Game, database.Profile, database.ContributorTableBean, database.Contributor, database.RoleTableBean, database.Role, database.Mutator, database.MutatorTableBean" %>

<%
Game g = new Game();
MutatorTableBean mt = ((MutatorTableBean)request.getAttribute("MutatorTable"));
ContributorTableBean ct = ((ContributorTableBean)request.getAttribute("ContributorTable"));
boolean canEdit = ((Boolean)request.getAttribute("CanEdit")).booleanValue();
final String MEDIA_PATH = "/Uploads/Games";
final String MEDIA_PATH_FULL = request.getContextPath() + MEDIA_PATH;

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

	<img src="<%= MEDIA_PATH_FULL %>/Thumbnails/<%= g.getId() %>"><br>
	<h1><%= g.getTitle() %></h1><br>
	<i>Submitted for the <%= g.getEvent() %> jam.</i><br>
	<!--
	<i>Submitted by account with key of <%= g.getSubmitter() %></i><br>
	  -->
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
	
	<h2>Screenshots</h2>
	<%
	FolderReader fr = new FolderReader(MEDIA_PATH + "/Screenshots/" + g.getId());
	String[] carouselItems = fr.getFileList();
	if (carouselItems != null)
	{
		for(int i = 0; i < carouselItems.length; i++) {
	%>
			<img width=256 height=128 src="<%= MEDIA_PATH_FULL %>/Screenshots/<%= g.getId() %>/<%= carouselItems[i] %>">
	<%
		}
	}
	%>
	
	  
	  
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