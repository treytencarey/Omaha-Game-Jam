<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/newsStyle.css">
</head>
<style>
.zoom {
	transition: transform .2s; /* Animation */
	margin: 0 auto;
}

.zoom:hover {
  transform: scale(1.05);
}

.archive-item:hover {
	background-color: #3b3b3b
}

.archive-img-container {
	max-width: 15%;
	height: 8vw;
	max-height: 15%;
	object-fit: cover;
}
</style>
<body>
	<%@include  file="/Common/navbar.jsp" %>
	<%@page import="beans.News" %>
	<%@page import="project.Main" %>
	<h4 style="text-align: center;">News Archive</h4>
	<h4 style="text-align: center;"><%= request.getParameter("year") %></h4>
	<br>
	<div class="dropdown text-center" style="align: center;">
  		<button style="background-color: #0377FC; border-color: #0377FC;" class="btn btn-secondary dropdown-toggle" type="button" id="yearDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    	Select Year
  		</button>
  		<div class="dropdown-menu" aria-labelledby="yearDropdown">
  			<% for(int i = (int)request.getAttribute("maxYear"); i >= (int)request.getAttribute("minYear"); i--) { %>
		    <a class="dropdown-item" href="<%= request.getContextPath() %>/News/Archive?year=<%= i %>"><%= i %></a>
		    <% } %>
  		</div>
	</div>
	   	<ul class="list-unstyled">
	   	<hr class="my-2" style="background-color: #3b3b3b">
	<% News[] newsPosts = (News[])request.getAttribute("newsPosts"); 
	   for(int i = newsPosts.length - 1; i >= 0; i--) { %>
	   		<a href="<%= request.getContextPath() %>/News/view?id=<%= newsPosts[i].getKey() %>">
	  			<li class="media archive-item">
		    		<img class="mr-3 archive-img-container" src="<%= request.getContextPath() %>/images/spoopy.png">
		    		<div class="media-body align-self-center">
		      		<h6 class="mt-0 mb-1"><%= newsPosts[i].getTitle() %></h6>
		      		<%= newsPosts[i].getHeader() %>
	    			</div>
	  			</li>
  			</a>
  			<hr class="my-2" style="background-color: #3b3b3b">
	<% } %>
	<% if(newsPosts.length == 0) { %>
	<h5 style="text-align: center;">No News Articles Found for <%= request.getParameter("year") %></h4>
	<% } %>
		</ul>
</body>
</html>