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
  	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
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
	<%@page import="beans.EventTableBean" %>
	<%@page import="beans.Event" %>
	<%@page import="project.Main" %>
	<%@page import="java.util.ArrayList" %>
	
	<%
	Event current = new Event(request.getParameter("event"));
	%>
	<div class="container eventContainer rainbowBorder">
		<div id="current-event" class="event">
			<img src="<%= request.getContextPath() %>/Uploads/Events/HeaderImages/<%= current.getKey() %>_header.png" class="rounded" style="max-width: 100%; max-height: 100%;"/>
			<div class="row">
				<div class="col-sm-3"></div>
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
			
		</div>
	</div>
</body>
</html>