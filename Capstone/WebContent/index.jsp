<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="database.Database, beans.Event, beans.EventTableBean" %>

<%
// This should be moved into a servlet, but this'll have to do for now
EventTableBean et = new EventTableBean();
Event ce = et.getCurrentEvent();
String rsvpd = Database.executeQuery("SELECT COUNT(*) FROM Attendees WHERE EventPKey=" + ce.getKey()).get(0).get("COUNT(*)").toString();
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
	
	<script>
		function changePageColor() {
		   $(".mainNavItems").find(".active").removeClass("active");
		   $("#homeButton").addClass("active");
		}
	</script>
	<title>Home</title>
</head>
<!-- A lot of this page is hard-coded at the moment as a sort of proof of concept -->
<!-- Admins will be able to update the homepage in the future -->

<body onload="changePageColor()">
	<%@include file="Common/navbar.jsp" %>
	<%@page import="java.util.List" %>
	<%@page import="java.util.Map" %>
	<%@page import="beans.News" %>
	<%@page import="utils.Utils" %>
	<%@include file="/AdminPanel/changeSiteDescriptionModal.jsp" %>
		<%
	if(ce.IsPublic()) {
	%>
		<div class="mainEventParent">
			<img class="mainEventImg rounded" src="<%= request.getContextPath() %>/Uploads/Events/HeaderImages/<%= ce.getKey() %>_header.png" style="height:100%; width:100%;"/>
	  	</div>
	  	
	  	<div class="jumbotron aboutSection" style="margin-top: 50px;">
	  		<h1 class="display-5">UPCOMING EVENT: <%= ce.getTitle() %></h1>
	  		<hr class="my-2" style="background-color: #3b3b3b">
	  		<div style="font-size: 18px">
	  			<p><%= ce.getStartDate() %> - <%= ce.getEndDate() %></p>
	  			<p style="font-size: 15px"><%=rsvpd %> other Jammers have RSVP'd for this Jam.</p>
	  			<div class="row">
		  			<form action="./Events" style="margin-left: auto; margin-right: 10px;">
		  				<input id="detailsBtn" type="submit" class="btn btn-primary" href="./Events" value="Details">
					</form>
		  			<div style="margin-right: auto; margin-left: 10px;">
		  				<%@include file="/components/RSVPButton.jsp" %>
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
	
  	
  	<div class="pagePadding"></div>
  	
  	<!-- Container for other recent news articles -->
  	<%     int[] postKeys = News.getMostRecentNewsPostsKeys(3, 0, 1); 
		   News[] recentNews = new News[postKeys.length];
	   	   for(int i = 0; i < recentNews.length; i++) {
		   		recentNews[i] = new News(postKeys[i]);
	       } %>
		<div class="container" style="text-align: center;">
	  		<div class="row justify-content-center">
	  			<% for(int i = 0; i < recentNews.length; i++) { %>
	  				<div class="col-sm">
						<div class="card">
							<a href="<%=request.getContextPath()%>/News/view?newsid=<%=recentNews[i].getKey()%>"><img class="card-img-top zoom" src="<%= request.getContextPath() + "/Uploads/News/Photo/" + recentNews[i].getKey() + "_header.png" %>"/></a>
						  		<div class="card-body dark">
						  			<a href="<%= request.getContextPath() %>/News/view?newsid=<%= recentNews[i].getKey() %>"><h5 class="card-title"><%=recentNews[i].getTitle() %></h5></a>
						  			<p class="card-text"><%=recentNews[i].getHeader() %></p>
						  		</div>
					  	</div>
				  	</div>
			  	<% } %>
		  	</div>
  		</div>
  	
	<div class="jumbotron aboutSection">
  		<h1 class="display-5">About Omaha Game Jam</h1>
  		<hr class="my-2" style="background-color: #3b3b3b">
  		<div style="font-size: 18px;">
  			<h6><%= Utils.SiteDescription() %></h6>
  		</div>
  		<%	if (session.getAttribute("accountPKey") == null) { %>
  			<p class="lead" id="registerNowButton">
    			<a class="btn btn-primary btn-med" style="cursor: pointer;" onclick="showRegisterModal()" role="button">Register Now!</a>
  			</p>
  		<% } else if(Account.isAdmin(request.getSession())){%>
		  	<button id="changeAboutBtn" type="submit" class="btn btn-primary" data-target="#changeSiteDescriptionModal" data-toggle="modal">Change Site Description</button>
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
	<div id="toastDiv"></div>
</html>