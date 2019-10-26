<style>
#eventHeader {
	height: 400px;
	width: 100%;
	background-color: white;
}
</style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="utils.FolderReader" %>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="styles.css">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

<title>Event Page</title>
</head>
<body style="background-color: gray">

<% 
	FolderReader fr = new FolderReader("/images/eventImages");
%>

	<%@include file="Nav.jsp"%>
	<div id="eventHeader">
		
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
				<div class="carousel-inner">
					<% 
					String[] carouselItems = fr.getFileList();
					%>
					<div class="carousel-item active">
					<img class="d-block w-100 img-fluid" src="./images/eventImages/<%= carouselItems[0] %>" alt="Slide 1">
					</div>
					<%
					for(int i = 1; i < carouselItems.length; i++) { 
					%>
					<div class="carousel-item">
						<img class="d-block w-100 img-fluid" src="./images/eventImages/<%= carouselItems[i] %>" alt="Slide <%= i + 1 %>">
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
</body>
</html>