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
	
	<style>
		.overlay {
			position: absolute;
			bottom: 0;
			left:0;
			background: rgb(0,0,0);
			background: rgba(0,0,0,0.5);
			color: #f1f1f1;
			width: 100%;
			transition: .5s ease;
			opacity: 0;
			color: white;
			font-size: 20px;
			padding: 20px;
			text-align: center;
		}
		.card:hover .overlay {
			opacity: 1;
		}
		#current-event img{
			height: 500px;
			width: 100%;
			object-fit: none;
			overflow: hidden;
			object-position: relative;
		}
	</style>
	
	<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/eventStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
	<script>
		function changePageColor() {
		   $(".mainNavItems").find(".active").removeClass("active");
		   $("#eventsButton").addClass("active");
		}
	</script>
	<title>Events</title>
</head>
<body onload="changePageColor()">
	<%@include  file="/Common/navbar.jsp" %>
	<%@include file="/Events/newEventModal.jsp" %>
	<%@include file="/Events/eventsDisplayModal.jsp" %>
	<%@page import="beans.EventTableBean" %>
	<%@page import="beans.Event" %>
	<%@page import="database.Mutator" %>
	<%@page import="database.Database" %>
	<%@page import="project.Main" %>
	<%@page import="java.util.ArrayList" %>

	
	<%
	eventTable = new EventTableBean();
	Event current = null;
	Event future = null;
	ArrayList<Event> past = new ArrayList<Event>();
	
	try{
		current = eventTable.getCurrentEvent();
		future = eventTable.getFutureEvent();
		past = eventTable.getPastEvents();
		
	} catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	<!-- Current Event -->
	<%
	if(current.IsPublic()) {
	%>
	<div class="container eventContainer rainbowBorder">
		<div id="current-event" class="event">
			<img src="<%= request.getContextPath() %>/Uploads/Events/HeaderImages/<%= current.getKey() %>_header.png" class="rounded" style="max-width: 100%; max-height: 100%;"/>
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
					<%@include file="/components/RSVPButton.jsp" %>
					<button type="button" id="event-schedule-button" class="btn btn-warning">Event Schedule</button>
					<a href="https://discord.gg/6EZqkXh"><i class="fab fa-discord fa-3x" style="color: #7289da;"></i></a>
				</div>
				<div class="row rounded" id="event-schedule-description" style="width: 100%; margin: auto; padding: auto; display:none;">
					<h6><%= current.getSchedule() %></h6>
				</div>
			</div>
		</div>
		
	</div>
	<%
	} else {
	%>
	<div class="container eventContainer">
		<h1 style="width: -webkit-fit-content;margin: auto;">No Current Event</h1>
	</div>
	<%
	}
	%>
	<!-- Future Event -->
	<% if (future != null && future.IsPublic()) { %>
	<div class="container eventContainer">
		<div id="future-event" class="event">
		<img src="<%= request.getContextPath() %>/Uploads/Events/HeaderImages/<%= future.getKey() %>_header.png" style="max-width: 100%; max-height: 100%;"/>
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
	
	<script>
		function goLeft() {
			var leftPos = $('.scrolling-wrapper').scrollLeft();
			$(".scrolling-wrapper").animate({scrollLeft: leftPos - 313}, 500);
		}
		function goLeftOpacity() {
			$("#goLeftIcon").css('opacity', '0.6');
		}
		function goLeftOpacityOff() {
			$("#goLeftIcon").css('opacity', '1.0');
		}
		function goRight() {
			var leftPos = $('.scrolling-wrapper').scrollLeft();
			$(".scrolling-wrapper").animate({scrollLeft: leftPos + 313}, 500);
		}
		function goRightOpacity() {
			$("#goRightIcon").css('opacity', '0.6');
		}
		function goRightOpacityOff() {
			$("#goRightIcon").css('opacity', '1.0');
		}
	</script>
	
	<!-- Past Events -->
	<%if(!past.isEmpty()) {%>
	<div class="container eventContainer" style="max-width: 1400px;">
		<div id="past-events">
			<h1 style="width: fit-content; margin: auto; margin-bottom: 50px;">Past Events</h1>
			<button onclick="goLeft()" onmousedown="goLeftOpacity()" onmouseup="goLeftOpacityOff()" style="position: relative; top: 209.5px; float: left;"><i id="goLeftIcon" class="fas fa-chevron-circle-left fa-7x"></i></button>
			<button onclick="goRight()" onmousedown="goRightOpacity()" onmouseup="goRightOpacityOff()" style="position: relative; top: 209.5px; float: right;"><i id="goRightIcon" class="fas fa-chevron-circle-right fa-7x"></i></button>
			<div class="container scrolling-wrapper">				
				<%
				for(Event event : past){
				%>
					<div class="card dark" style="margin: auto; height: 505px; width: 18rem;">
						<div class="pastEventsImgContainer" style="width: 286px; height: 160px;">
							<img src="<%= request.getContextPath() %>/Uploads/Events/HeaderImages/<%= event.getKey() %>_header.png" class="card-img-top" alt="Game Icon" style="width: 286px; height: 160px; object-fit: contain; background-color: black; margin-top: -48px;">
						</div>
						<div class="card-body dark" style="margin-top: -48px;">
							<h5 class="card-title" style="height: 4.5rem;"><%= event.getTitle() %></h5>
							<h6 class="card-subtitle mb-2 text-muted" style="height: 4.5rem;">Theme: <%= event.getTheme() %></h6>
							<p class="card-text" style="position: absolute; bottom: 20px;">[<%= event.getStartDate() %>] - [<%= event.getEndDate() %>]</p>
						</div>
						<div class="overlay">
					  		<button onclick="window.location.href='<%= request.getContextPath()+"/Events/pastEvent.jsp?event="+event.getKey() %>'" class="btn btn-primary">Check it out</button>
					  	</div>
					</div>
				<% } %>
			</div>
		</div>
	</div>
	
	<div id="toastDiv"></div>
	<%} %>
</body>
<script>
$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
$('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
$('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});

$(document).ready(function(){

	$("#event-schedule-button").click(function(){
		$("#event-schedule-description").toggle();
	});
});
</script>
</html>