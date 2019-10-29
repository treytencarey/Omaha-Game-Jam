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
	
</head>
<style>

	img {
		width: inherit;
	}
 	.news-container {
 		width:75%; 
 		margin:0 auto;
 	}
 	
 	.list-group .list-group-item-action {
 		background-color: #222;
		color: #e6e6e6;
		border-color: #e6e6e6;
 	}
 	
 	
 	.list-group-item-action:hover {
 		background-color: #3b3b3b;
 	}
 	
 	.img-container {
 		object-fit: cover;
 		max-width: 20%;
 		min-width: 20%;
 		overflow: hidden;
 		display: flex;
 		float:left;
 	}
 	
 	.news-text {
 		padding-left: 27%;
 	}
 	
 	.date-text {
 		position:absolute;
 		bottom: 0;
 		right: 5px;
 		font-style: italic;
 	}
 	
 	@media only screen and (max-width: 800px) {
 		.img-container {
 			max-width: 40%;
 			min-width: 40%;
 		}
 		
 		.news-text {
 			display: inline-block;
 		}
}
</style>
<body>
	<%@include  file="../navbar.jsp" %>
	<div style="text-align: center;">
		<h4>News</h4>
		<br>
	</div>
	<div class="list-group news-container">
		<a href="#" class="list-group-item list-group-item-action">
			<div class="img-container">
				<img class="img-fluid rounded" src="<%= request.getContextPath() %>/images/smallimgtest.png"/>
			</div>
			<div class="news-text">
				<div class="d-flex mb-3 justify-content-between">
					<h4>TEST HEADING TEST HEADING TEST HEADING TEST HEADING</h4>
				</div>
				<p>test text test text test text test text test text test text test text test text</p>
				<small class="date-text">October 20th, 2019</small>
			</div>
		</a>
		<a href="#" class="list-group-item list-group-item-action">
			<div class="img-container">
				<img class="img-fluid rounded" src="<%= request.getContextPath() %>/images/cancer.jpeg"/>
			</div>
			<div class="news-text">
				<div class="d-flex mb-3 justify-content-between">
					<h4>TEST HEADING TEST HEADING TEST HEADING TEST HEADING</h4>
				</div>
				<p>test text test text test text test text test text test text test text test text</p>
				<small class="date-text">October 20th, 2019</small>
			</div>
		</a>
	</div>
</body>
</html>