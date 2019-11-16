<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.Database,beans.Event" %>

<%
// This should be moved into a servlet, but this'll have to do for now		
List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM ActiveEvent");
if (query.size() == 0)
	throw new NullPointerException();
Map<String, Object> ae = query.get(0);
int epk = Integer.parseInt(ae.get("EventPKey").toString());
		
Event event = new Event(epk);
session.setAttribute("ActiveEvent", event);
query = Database.executeQuery("SELECT COUNT(*) FROM Attendees WHERE EventPKey=" + epk);
int numOfUsers = Integer.parseInt(query.get(0).get("COUNT(*)").toString());
%>

<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/indexStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
</head>
<!-- A lot of this page is hard-coded at the moment as a sort of proof of concept -->
<!-- Admins will be able to update the homepage in the future -->

<body>
	<%@include file="Common/navbar.jsp" %>
	<%@page import="java.util.List" %>
	<%@page import="java.util.Map" %>
	<%@page import="beans.News" %>
	
	<div class="mainEventParent">
		<img class="mainEventImg rounded" src="./images/gamejam.png"/>
  	</div>
  	
  	<div class="jumbotron aboutSection" style="margin-top: 50px;">
  		<h1 class="display-5">UPCOMING EVENT: <%= event.getTitle() %></h1>
  		<hr class="my-2" style="background-color: #3b3b3b">
  		<div style="font-size: 18px">
  			<p><%= event.getStartDate() %> - <%= event.getEndDate() %></p>
  			<p style="font-size: 15px"><%=numOfUsers %> other Jammers have RSVP'd for this Jam.</p>
  			<div class="row">
	  			<form action="./Events" style="margin-left: auto; margin-right: 10px;">
	  				<input type="submit" class="btn btn-primary" href="./Events" value="Details">
				</form>
	  			<form action="Events/rsvp_placeholder.jsp" style="margin-right: auto; margin-left: 10px;">
			  	  	<input type="submit" class="btn btn-primary" value="RSVP">
			  	</form>
		  	</div>
  		</div>
  		<%	if (session.getAttribute("accountPKey") == null) { %>
  			<p class="lead">
    			<a class="btn btn-primary btn-med" style="cursor: pointer;" onclick="showRegisterModal()" role="button">Register Now!</a>
  			</p>
  		<% } %>
	</div>
  	
  	<div class="pagePadding"></div>
  	
  	<!-- Container for other recent news articles -->
  	<%     int[] postKeys = News.getMostRecentNewsPostsKeys(3, 0); 
		   News[] recentNews = new News[postKeys.length];
	   	   for(int i = 0; i < recentNews.length; i++) {
		   		recentNews[i] = new News(postKeys[i]);
	       } %>
		<div class="container h-100" style="text-align: center;">
	  		<div class="row mt-2 justify-content-center">
	  			<% for(int i = 0; i < recentNews.length; i++) { %>
					<div class="card">
						<a href="<%=request.getContextPath()%>/News/view?id=<%=recentNews[i].getKey()%>"><img class="card-img-top zoom" src="<%= request.getContextPath() %>/images/spoopy.png"/></a>
					  		<div class="card-body dark">
					  			<h5 class="card-title"><%=recentNews[i].getTitle() %></h5>
					  			<p class="card-text"><%=recentNews[i].getHeader() %></p>
					  		</div>
				  	</div>
			  	<% } %>
		  	</div>
  		</div>
  	
	<div class="jumbotron aboutSection">
  		<h1 class="display-5">About Omaha Game Jam</h1>
  		<hr class="my-2" style="background-color: #3b3b3b">
  		<div style="font-size: 18px">
  			<p>Omaha Game Jam is a free 2 day game development event where participants build games from scratch around a secret theme. At the end of dev time, everyone presents, plays, and votes on superlative awards. Individuals 18+ and teams are welcome!</p>
  		</div>
  		<%	if (session.getAttribute("accountPKey") == null) { %>
  			<p class="lead">
    			<a class="btn btn-primary btn-med" style="cursor: pointer;" onclick="showRegisterModal()" role="button">Register Now!</a>
  			</p>
  		<% } %>
	</div>
</body>
<footer class="page-footer font-small mdb-color darken-3">
	<div class="container">
		<div class="row justify-content-center">
	        <div class="mb-5 flex-center" style="text-align:center;">
	        	<p style="font-size: 22px; font-weight:bold;">Get in Touch</p>
	        	<hr class="my-2" style="background-color: #3b3b3b">
	        	RHO Interactive Entertainment<br>
	        	charles@rhointeractive.com<br>
	        	402-979-6894
	        </div>
		</div>
	</div>
</footer>
<script>
	function showRegisterModal() {
		$("#registerModal").modal("show");
	}
</script>
</html>