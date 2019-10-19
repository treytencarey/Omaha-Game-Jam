<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.Database" %>

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
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/indexStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
</head>
<!-- A lot of this page is hard-coded at the moment as a sort of proof of concept -->
<!-- Admins will be able to update the homepage in the future -->

<body>
	<%@include  file="navbar.jsp" %>
	
	<div class="mainEventParent">
		<img class="mainEventImg rounded" src="./images/gamejam.png"/>
		<div class="imgOverlay">
    		<div class="overlayTitle">Upcoming Event</div>
    		<div class="overlaySubtitle">November 6th 2019 - November 9th 2019</div>
    		<a class="btn btn-primary btn-med overlayBtn" href="#" role="button">Details</a>
    	</div>
  	</div>
  	
  	<div class="pagePadding"></div>
  	
  	<div class="container h-100" style="text-align: center;">
  		<div class="card-deck col-md-12">
			<div class="card">
				<a href="#"><img class="card-img-top" src="./images/cancer.jpeg"/></a>
			  		<div class="card-body dark">
			  			<h5 class="card-title">Game Jammer Creates Game That Cures Cancer</h5>
			  			<p class="card-text">"It's a miracle, the game is so good that the consequences of smoking cigarettes for decades just disappeared from my lungs." - Local Gamer</p>
			  		</div>
		  	</div>
		  	<div class="card">
			 	<a href="#"><img class="card-img-top" src="./images/squidward.jpg"/></a>
				<div class="card-body dark">
			  		<h5 class="card-title">2019 Game Awards</h5>
			  		<p class="card-text">See what awaits you if you're a good programmer.</p>
			  	</div>
		  	</div>
		  	<div class="card">
			 	<a href="#"><img class="card-img-top" src="./images/its_spherical.jpg"/></a>
				<div class="card-body dark">
			  		<h5 class="card-title">GameSphere Challenge</h5>
			  		<p class="card-text">In an upcoming event, Game Jammers will create a game for the GameSphere.</p>
			  	</div>
		  	</div>
	  	</div>
  	</div>
  	
	<div class="jumbotron aboutSection">
  		<h1 class="display-5">About Omaha Game Jam</h1>
  		<hr class="my-2" style="background-color: #3b3b3b">
  		<div style="font-size: 18px">
  			<p>Omaha Game Jam is a free 2 day game development event where participants build games from scratch around a secret theme. At the end of dev time, everyone presents, plays, and votes on superlative awards. Individuals 18+ and teams are welcome!</p>
  			<p style="font-size: 15px">There are currently <%=Database.executeQuery("SELECT COUNT(*) FROM Accounts").size() %> registered Game Jammers.</p>
  		</div>
  		<%	if (session.getAttribute("accountPKey") == null) { %>
  			<p class="lead">
    			<a class="btn btn-primary btn-med" href="#" role="button">Register Now!</a>
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
</html>