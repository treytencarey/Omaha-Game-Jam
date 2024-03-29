<%@page import="exceptions.EmptyQueryException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="utils.FolderReader, servlets.GameViewServlet, database.Game, database.Profile, beans.ContributorTableBean, database.Contributor, beans.RoleTableBean, beans.Event, database.Role, database.Mutator, database.Platform, database.Tool, beans.MutatorTableBean, beans.GameBean" %>

<%
Game g = new Game(Integer.parseInt(request.getParameter("id")));
MutatorTableBean mt = new MutatorTableBean(request.getParameter("id"));
ContributorTableBean ct =  new ContributorTableBean(); ct.fillByGame(request.getParameter("id"));
Event e = new Event(g.getEvent());
boolean canEdit = GameViewServlet.CanEdit(g, ct, session);
final String MEDIA_PATH = "/Uploads/Games";
final String MEDIA_PATH_FULL = request.getContextPath() + MEDIA_PATH;
pageContext.setAttribute("Website", g.getLink());

// This code is disgusting but I'm in a rush so whatever
boolean isAdmin = Account.isAdmin(session);

GameBean gb = new GameBean(request.getParameter("id"));
// Create a message to display to admins moderating the content of this profile.
String s = gb.getStatus();
String me;
switch (s)
{
case "-1":
	me = "Depublicized: game page was denied in its current state.";
	break;
case "0":
	me = "Depublicized: game page was previously denied but has since been edited.";
	break;
case "1":
	me = "Publicized: game page is unverified.";
	break;
case "2":
	me = "Publicized: game page was approved in its current state.";
	break;
default:
	me = "Something went wrong. Oops!";
}


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title><%= g.getTitle() %></title>
	
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/gameViewStyle.css">
	<script>
	function verify() {
		moderate(2);
	}
	function deny() {
		moderate(-1);
	}
	function moderate(x) {
		document.getElementById('status').value = x;
		document.getElementById('moderate_form').submit();
	}
</script>
	<title>View Games</title>
</head>
<body>
<%@include  file="/Common/navbar.jsp" %>
<%@include file="/Common/external_link_warning_modal.jsp"%>
<% ContributorTableBean ctView = new ContributorTableBean(); ctView.fillByGame(request.getParameter("id"));
   if (GameViewServlet.CanEdit(new Game(Integer.parseInt(request.getParameter("id"))), ctView, session)) { %>
	<%@include  file="/Games/newGameModal.jsp" %>
<% } %>

<%
	if (isAdmin) {
%>
<p><%= me %></p>
<form id="moderate_form" action="<%=request.getContextPath()%>/game_moderate" method="GET">
	<input type="hidden" name="status" id="status">
	<input type="hidden" name="id" value="<%= gb.getId() %>">
	<button type="button" class="btn btn-success" <%=gb.getStatus().equals("2") ? "disabled" : ""%> onclick="verify();">Publicize Game Page</button>
	<button type="button" class="btn btn-danger" <%=gb.getStatus().equals("-1") ? "disabled" : ""%> onclick="deny();">Depublicize Game Page</button>
</form>

<%
	}
%>

<%
	if (me.equals("-1") || me.equals("0")) {
%>
<div class="alert alert-warning">
	This game page has been depublicized by a moderator. Please clean it up!
</div>
<%
	}
%>

<div class="gameViewMainDiv">
	<div class="row gameViewMainRow">
		<div class="col-sm-5">
			<div class="row">
				<h1 class="gameViewTitle"><%= g.getTitle() %></h1>
			</div>
			<div class="row">
				<img class="gameViewIcon" src="<%= MEDIA_PATH_FULL %>/Thumbnails/<%= g.getId() %>"><br>
			</div>
			<div class="row">
				<h2 class="gameViewContributorTitle">Contributors</h2>
			</div>
			<div class="row">
				<div class="gameViewContributors container">
					<%
					for(Contributor c : ct.getContributors())
					{
						Profile p;
						try {
							p = new Profile(Integer.parseInt(c.getAccountPKey()));
						} catch (Exception profE) {
							p = new Profile();
							try {
								p.setName(Database.executeQuery("SELECT Email FROM Accounts WHERE PKey=" + c.getAccountPKey()).get(0).get("Email").toString());
							} catch (Exception accE) {
								// No profile found and no account found. Should never happen.
								continue;
							}
						}
						RoleTableBean rti = new RoleTableBean(c.getRolePKey());
					%>
						<div class="d-flex flex-row border rounded" style="border: none !important;">
				  			<div class="p-0 w-25">
				  				<%@page import="java.io.File" %>
				  			    <%	String contPicPath = "/Uploads/Profiles/Pics/" + c.getAccountPKey();
					  				File f = new File(Main.context.getRealPath(contPicPath));
					  				//System.out.println(f.length());
					  	        	if (!f.exists() || f.length() == 0) // Display default if file is empty or non-existent
					  	        		contPicPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
					  	        	else
					  	        		contPicPath = request.getContextPath() + contPicPath; %>
								<img src="<%= contPicPath %>" class="img-thumbnail border-0" />
				  			</div>
				  			<div class="pl-3 pt-2 pr-2 pb-2 w-75 border-left">
			  					<h4 class="text-primary"><a href="<%= request.getContextPath() + "/profile?id=" + c.getAccountPKey() %>" ><%= p.getName() %> </a></h4>
			  					<h5 class="text-info"><%= rti.getTitle() %></h5>
							</div>
						</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<div class="col-sm-7">
			<div class="row">
				<p class="gameViewDescription"><%= g.getDesc() %></p>
			</div>
			<div class="row gameViewDetails">
				<label class="gameViewLabels" for="jamYear">Jam Year:</label>
				<p class="gameViewValues" id="jamYear">Submitted for the <%= e.getTitle() %> jam.</p>
			</div>
			<div class="row gameViewDetails">
				<div class="col-sm-12 gameViewDetailCols">
					<label class="gameViewLabels" for="mutators">Mutators:</label>
				</div>
				<div class="col-sm-12 gameViewDetailCols">
					<%
					try
					{
						for(Mutator m : g.getMutators())
						{
						%>
							<p class="gameViewValues" id="mutators"><%= m.getTitle() %> - <%= m.getDesc() %></p>
						<%
						}
					}
					catch (Exception ex)
					{
						ex.printStackTrace();
					}
					%>
				</div>
			</div>
			<div class="row gameViewDetails">
				<label class="gameViewLabels" for="platforms">Platforms:</label>
				<% for (Platform p : g.getSystems()) { %>
					<p class="gameViewValues" id="platforms"><%= p.getTitle() %><%= p != g.getSystems().get(g.getSystems().size()-1) ? ",&nbsp" : "" %></p>
				<%}%>
			</div>
			<div class="row gameViewDetails">
				<label class="gameViewLabels" for="tools">Tools:</label>
				<% for (Tool t : g.getTools()) { %>
					<p class="gameViewValues" id="tools"><%= t.getTitle() %><%= t != g.getTools().get(g.getTools().size()-1) ? ",&nbsp" : "" %></p>
				<%}%>
			</div>
			<div class="row gameViewDetails">
				<div class="col-sm-12 gameViewDetailCols">
					<label class="gameViewLabels" for="screenshots">Screenshots:</label>
				</div>
				<div id="screenshots" class="carousel slide" data-ride="carousel">
					<%
						FolderReader fr = new FolderReader(MEDIA_PATH + "/Screenshots/" + g.getId());
						String[] carouselItems = fr.getFileList();
						if (carouselItems != null) {
					%>
							<ol class="carousel-indicators">
					<%
							for (int x = 0; x < carouselItems.length; x++) {
								if (x == 0) {
					%>
									<li data-target="#screenshots" data-slide-to="0" class="active"></li>
					<%
								}
								else {
					%>
									<li data-target="#screenshots" data-slide-to=x></li>
					<%
								}
							}
					%>
							</ol>
					<%
						}
					%>
				  	<div class="carousel-inner">
				  		<%
							if (carouselItems != null)
							{
						%>
								<div class="carousel-item active">
						<%
								for(int i = 0; i < carouselItems.length; i++) {
									if (i != 0) {
						%>
										<div class="carousel-item">
						<%
									}
						%>
								      	<img class="d-block w-100" src="<%= MEDIA_PATH_FULL %>/Screenshots/<%= g.getId() %>/<%= carouselItems[i] %>" alt="First slide">
								    </div>
						<%
								}
							}
						%>
					  	<a class="carousel-control-prev" href="#screenshots" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
					  	</a>
					  	<a class="carousel-control-next" href="#screenshots" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
					  	</a>
					</div>
				</div>
			</div>
			<div class="row gameViewDetails">
				<label class="gameViewLabels" for="tools">Play Now:</label>
				<p class="gameViewValues" id="tools"><a id="websiteBtn" href="<%= g.getLink() %>" class="nav-link" onclick="return false;"><%= g.getLink() %></a></p>
				
			</div>
	</div>
</div>
<script>
	//Check game link for regular expression including drive.google.com or itch.io
	$("#websiteBtn").click(function(){
		var pat1 = new RegExp("(https://)*(drive.google.com)+");
		var pat2 = new RegExp("(https://)*(itch.io)+");
		var danger = true;
		var link = $("#websiteBtn").html();

		var result = pat1.exec(link);
		var result2 = pat2.exec(link);
		if(result != null || result2 != null){
			danger = false;
		}
		if(danger){
			$("#externalLinkWarningModal").modal("show");
		} else {
			window.location = $("#websiteBtn").attr("href");
		}
		
	});
</script>
</body>
</html>