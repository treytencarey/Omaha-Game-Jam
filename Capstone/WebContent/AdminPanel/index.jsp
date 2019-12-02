<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
		if(!Account.isAdmin(request.getSession())) {
			response.sendRedirect(request.getContextPath()+"/index.jsp");
		}
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy");
	   	String currentYear = dtf.format(LocalDateTime.now());
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
</head>
<body>

	<%@include file="/Common/navbar.jsp" %>
	<%@include file="/Events/newEventModal.jsp" %>
	<%@include file="/Events/eventsDisplayModal.jsp" %>
	<%@include file="/News/newArticleModal.jsp" %>
	<%@include file="/Gallery/addGalleryPhotoModal.jsp" %>
	<%@include file="/AdminPanel/submissions.jsp" %>
	
	<%@page import="java.time.LocalDateTime" %>
	<%@page import="java.time.format.DateTimeFormatter" %>
	<%@page import="database.Account" %>
	
	
	<div style="text-align: center;">
		Admin Panel<br><br>
		
		<h3><b>Event Options:   </b></h3>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newEventModal">Create Event</button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#eventsDisplayModal">View Events</button>
		
		<h3><b>News Options:   </b></h3>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newNewsArticleModal">Create Article</button>
		<a href="<%= request.getContextPath() %>/News/Archive?year=<%= currentYear %>"><button type="button" class="btn btn-primary">View Articles</button></a>
		
		<h3><b>Gallery Options:   </b></h3>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addGalleryPhotoModal">Add Photo(s)</button>
		<a href="<%= request.getContextPath() %>/Gallery"><button type="button" class="btn btn-primary">View Gallery</button></a>
		
		<h3><b>Submissions:   </b></h3>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#gameSubmissionsDisplayModal">View Game Submissions</button>
	</div>
</body>
</html>