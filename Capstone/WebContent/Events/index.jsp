<style>
#event-header {
	height: auto;
	width: 80%;
	margin: 0 auto;
	text-align: center;
}
#event-info button {
	background-color: red;
}
#carouselExampleIndicators {
	height: auto;
}
</style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="utils.FolderReader" %>

<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
</head>
<body>
	<%@include  file="../navbar.jsp" %>
	<%@include file="../components/newEventModal.jsp" %>
	<%@page import="database.Event" %>
	<%@page import="database.Database" %>
	<%@page import="project.Main" %>
	<%@page import="java.util.ArrayList" %>
	<%@page import="java.util.List" %>
	<%@page import="java.util.Map" %>
	
	<div style="text-align: center;">
	<%
	FolderReader fr = new FolderReader("/images/eventImages");
	Event current = new Event();
	int pkey = -1;
	
	List<Map<String, Object>> query = Database.executeQuery("SELECT EventPKey FROM ActiveEvent WHERE IsPublic=\'" + 0 + "\'");
	if(!query.isEmpty()){
		pkey = Integer.parseInt(query.get(0).get("EventPKey").toString());
	}
	if(pkey != -1)
		current = new Event(pkey);
	%>
	<div id="event-header">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					<%
					for(int i = 1; i < fr.getFileList().length; i++) {
					%>
						<li data-target="#carouselExampleIndicators" data-slide-to=<%= i %>></li>
					<%
					}
					%>
				</ol>
				<div class="carousel-inner rounded" style="height: 35%;">
					<%
					String[] carouselItems = fr.getFileList();
					%>
					<div class="carousel-item mh-100 active">
					<img class="d-block w-100 img-responsive" src="../images/eventImages/<%= carouselItems[0] %>" alt="Slide 1">
					</div>
					<%
					for(int i = 1; i < carouselItems.length; i++) {
					%>
					<div class="carousel-item mh-100">
						<img class="d-block w-100 img-responsive" src="../images/eventImages/<%= carouselItems[i] %>" alt="Slide <%= i + 1 %>">
					</div>
					<%
					}
					%>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleIndicators"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
			<br><br>
		<div id="event-info">
			<h1 id="event-name"><b><%= current.getTitle() %></b></h1><br>
			<h2 id="event-subheadinfo"><%= current.getTheme() %></h2><br>
			<div id="event-description"><%= current.getDescription() %></div><br>
			<h3>From <%= current.getStartDate() %> to <%= current.getEndDate() %></h3>
			<button type="button" id="rsvp-button">RSVP</button>
			<button type="button" id="event-schedule-button">Event Schedule</button>
			<button type="button" id="discord-button">Developer Discord</button>
		</div>
	</div>
	<br><br>
	<h1>Past Events</h1>
	</div>

	<div class="container">
		<div class="row mt-5 justify-content-center">
	<%
	List<Map<String, Object>> events = Database.executeQuery("SELECT * FROM Events WHERE PKey != (SELECT MAX(PKey) FROM Events)");
	if(!events.isEmpty()){
		for(Map<String, Object> pastEvent : events){
			
			Event eventCard = new Event(Integer.parseInt(pastEvent.get("PKey").toString()));
	%>
			<div class="card card-custom mx-2 mb-3" style="max-width:350px;">
				<img src="../images/its_spherical.jpg" class="card-image-top" alt="Card image">
				<div class="card-body dark">
		  			<h5 class="card-title"><%= eventCard.getTitle() %></h5>
		  			<h6 class="card-subtitle mb-2 text-muted"><%= eventCard.getTheme() %></h6>
		  			<p class="card-text"><%= eventCard.getDescription() %></p>
		  		</div>
		    </div>
				
		<%	
		}
	}
	%>
		</div>
	</div>
</body>
</html>