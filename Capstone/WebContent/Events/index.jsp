<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="utils.FolderReader" %>

<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/v4-shims.css">
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/eventStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
</head>
<body>
	<%@include  file="/Common/navbar.jsp" %>
	<%@include file="/Events/newEventModal.jsp" %>
	<%@page import="beans.EventTableBean" %>
	<%@page import="beans.Event" %>
	<%@page import="database.Database" %>
	<%@page import="project.Main" %>
	<%@page import="java.util.ArrayList" %>

	
	<%
	FolderReader fr = new FolderReader("/images/eventImages");
	EventTableBean eventTable = new EventTableBean();
	Event current = null;
	Event future = null;
	ArrayList<Event> past = null;
	
	try{
		current = eventTable.getCurrentEvent();
		future = eventTable.getFutureEvent();
		past = eventTable.getPastEvents();
	} catch(Exception e){
		//Do nothing for now
	}
	
	%>
	<!--
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
		</div>
		 -->
	<!-- Current Event -->

	<div class="container eventContainer rainbowBorder">
		<div id="current-event" class="event">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
					<h1 class="currentEventHeader">Current Event</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Title:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= current.getTitle() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Theme:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= current.getTheme() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Description:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= current.getDescription() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">When:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;">From <%= current.getStartDate() %> to <%= current.getEndDate() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
					<button type="button" id="rsvp-button" class="btn btn-info">RSVP</button>
					<button type="button" id="event-schedule-button" class="btn btn-warning">Event Schedule</button>
					<a href=""><i class="fab fa-discord fa-3x" style="color: #7289da;"></i></a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Future Event -->
	<% if (!future.getTitle().equals("Unavailable")) { %>
	<div class="container eventContainer">
		<div id="future-event" class="event">
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
					<h1 class="currentEventHeader">Future Event</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Title:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= future.getTitle() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Theme:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= future.getTheme() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Description:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%= future.getDescription() %></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">When:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;">From <%= future.getStartDate() %> to <%= future.getEndDate() %></h3>
				</div>
			</div>
		</div>
	</div>
	<% }%>
	
	<!-- Past Events -->
	<div class="container eventContainer" style="max-width: 1400px;">
		<div id="past-events">
			<h1 style="width: fit-content; margin: auto;">Past Events</h1>
			<div class="container">
				<%
				int eventCounter = 0;
				for(Event event : past){
					if (eventCounter%3==0) {
				%>
					<div class="row mt-5 justify-content-center">
					<% } %>
						<div class="card card-custom col-sm-3" style="margin: auto; height: 500px;">
							<img src="../images/its_spherical.jpg" class="card-image-top" style="width: 100%;" alt="Card image">
							<div class="card-body dark">
						  		<h5 class="card-title"><%= event.getTitle() %></h5>
						  		<h6 class="card-subtitle mb-2 text-muted"><%= event.getTheme() %></h6>
						  		<p class="card-text"><%= event.getDescription() %></p>
						  		<p class="card-text" style="position: absolute; bottom: 20px;"><%= event.getStartDate() %></p>
						  	</div>
						</div>
					<% if (eventCounter%3==2) { %>
					</div>
					<% } eventCounter++;
					}%>
			</div>
		</div>
	</div>
</body>
</html>