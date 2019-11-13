<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/newsStyle.css">
</head>

<body>
	<%@include  file="../navbar.jsp" %>
	<%@page import="database.News" %>
	<%@page import="project.Main" %>
	<% int[] postKeys = News.getMostRecentNewsPostsKeys();
	   News[] recentNews = new News[postKeys.length];
	   for(int i = 0; i < recentNews.length; i++) {
		   recentNews[i] = new News(postKeys[i]);
	   }
	%>
	
	<h4 class="page-text">News</h4>
	<br>
	<div class="btn-group" role="group" style="align: center;">
		<button type="button" class="btn btn-secondary" id="show-news-btn">News</button>
		<button type="button" class="btn btn-secondary">All Posts</button>
		<button type="button" class="btn btn-secondary">Events</button>
	</div>
	<div class="container h-100" style="text-align: center;">
		<div class="row mt-2 justify-content-center">
		<% for(int i = 0; i < recentNews.length; i++) { %>
				<div class="card">
					<a href="#"><img class="card-img-top zoom" src="<%= request.getContextPath() %>/images/spoopy.png"/></a>
			  		<div class="card-body dark">
			  			<small><%= recentNews[i].getDate() %></small>
			  			<a href="#"><h5 class="card-title"><%= recentNews[i].getTitle() %></h5></a>
			  			<p class="card-text"><%= recentNews[i].getBody(request.getContextPath(), i) %></p>
			  		</div>
		  		</div>
		<% } %>
	  	</div>
	</div>
	
	<div id="add-article-modal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" style="color: black;">Add News Article</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form action="<%= request.getContextPath() %>/newsServlet" method = "post">
						<div class="form-group">
							<h5 style="color: black;">Title:</h5>
							<div class="input-group">
								<input class="form-control" name="article-title-input" required="required" placeholder="Article Title">
							</div>
							<br>
							<h5 style="color: black;">Body:</h5>
							<div class="input-group">
								<textarea class="form-control" name="article-title-input" required="required" placeholder="Article Body" style="height: 300px;"></textarea>
							</div>
							<div class="custom-checkbox">
  								<input type="checkbox" class="custom-control-input" id="is-public-checkbox" checked>
  								<label class="custom-control-label" for="is-public-checkbox">Make Public</label>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" name="post-article-button" class="btn btn-primary btn-block btn-lg">Post Article</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<hr class="my-2" style="background-color: #3b3b3b">
	<a href="#"><h6 style="text-align:center;">Older Posts</h6></a>
</body>
<script>
	$("#add-article-btn").click(function (e) {
		$("#add-article-modal").modal("show");
	})
</script>
</html>