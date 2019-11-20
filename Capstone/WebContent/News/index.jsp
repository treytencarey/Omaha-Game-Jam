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

<body>
	<%@include  file="/Common/navbar.jsp" %>
	<%@page import="beans.News" %>
	<%@page import="project.Main" %>
	<%@page import="java.util.Random" %>
	<%@page import="java.time.LocalDateTime" %>
	<%@page import="java.time.format.DateTimeFormatter" %>
	<%@include file="/News/newArticleModal.jsp" %>
	<% int[] postKeys = News.getMostRecentNewsPostsKeys(6, 0, 1);
	   News[] recentNews = new News[postKeys.length];
	   for(int i = 0; i < recentNews.length; i++) {
		   recentNews[i] = new News(postKeys[i]);
	   }
	   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy");
	   String currentYear = dtf.format(LocalDateTime.now());
	   String[] testImgs = {request.getContextPath() + "/images/squidward.jpg", request.getContextPath() + "/images/its_spherical.jpg", request.getContextPath() + "/images/cancer.jpeg" };
	%>
	
	<h4 class="page-text">Recent News</h4>
	<br>
	<div class="container" style="text-align: center;">
		<div class="row justify-content-center">
		<% for(int i = 0; i < recentNews.length; i++) { %>
				<div class="col-sm">
					<div class="card">
						<a href="<%= request.getContextPath() %>/News/view?id=<%= recentNews[i].getKey() %>"><img class="card-img-top zoom" src="<%= request.getContextPath() + "/Uploads/News/Photo/" + recentNews[i].getKey() + "_header.png" %>"/></a>
				  		<div class="card-body dark">
				  			<small><%= recentNews[i].getDate() %></small>
				  			<a href="<%= request.getContextPath() %>/News/view?id=<%= recentNews[i].getKey() %>"><h5 class="card-title"><%= recentNews[i].getTitle() %></h5></a>
				  			<p class="card-text"><%= recentNews[i].getHeader() %></p>
				  		</div>
			  		</div>
		  		</div>
		<% } %>
	  	</div>
	</div>

	<hr class="my-2" style="background-color: #3b3b3b">
	<a href="<%= request.getContextPath() %>/News/Archive?year=<%= currentYear %>"><h6 style="text-align:center;">View Older Posts</h6></a>
</body>
<script>
	var bodyField;
	loadEditor();
	
	function loadEditor() { 
		bodyField = new nicEditor({fullPanel: true}).panelInstance("newsBody");
		$("newsBody").width("100%");
		$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
        $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
        $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
	}
</script>
</html>