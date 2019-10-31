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
	.card {
		border: none;
		max-width: 50%;
		margin: 0 auto;
        float: none;
        margin-bottom: 10px;
	}
	
	.page-text {
		margin: 0 auto;
		text-align: center;
	}
	
	.card-text {
		text-overflow: ellipsis;
		user-select: none;
	}
	
	a {
		outline: none;
		color: inherit;
		text-decoration: none;
	}
	
	a:hover {
		outline: none;
		color: inherit;
	}
	
	.card-deck {
		margin: 0 auto;
        float: none;
        margin-bottom: 10px;
	}
	
	.card-img-top {
   		width: 100%;
   		height: 12vw;
   		max-height: 50%;
   		object-fit: cover;
	}
	
	.zoom {
  		transition: transform .2s; /* Animation */
  		margin: 0 auto;
	}

	.zoom:hover {
	  transform: scale(1.1);
	}
	
	.btn-group {
  		margin: auto;
  		display: flex;
  		flex-direction: row;
  		justify-content: center;
  		max-width:30%;
	}
	
	@media only screen and (max-width: 600px) {
 		.card {
 			max-width: 100%;
 		}
 		
 		.card-img-top {
 			height: 20vw;
	   		max-height: 70%;
		}
 	}
</style>
<body>
	<%@include  file="../navbar.jsp" %>
	<h4 class="page-text">News</h4>
	<br>
	<div class="btn-group" role="group" style="align: center;">
		<button type="button" class="btn btn-secondary" id="show-news-btn">News</button>
		<button type="button" class="btn btn-secondary">All Posts</button>
		<button type="button" class="btn btn-secondary">Events</button>
	</div>
	<div class="container h-100" style="text-align: center;">
		<div class="card-deck col-sm-12">
			<div class="card">
				<a href="#"><img class="card-img-top zoom" src="<%= request.getContextPath() %>/images/spoopy.png"/></a>
			  	<div class="card-body dark">
			  		<a href="#"><h5 class="card-title">TEST HEADING</h5></a>
			  		<p class="card-text">test text</p>
			  	</div>
		  	</div>
		  	<div class="card">
				<a href="#"><img class="card-img-top zoom" src="<%= request.getContextPath() %>/images/spoopy.png"/></a>
			  	<div class="card-body dark">
			  		<a href="#"><h5 class="card-title">TEST HEADING</h5></a>
			  		<p class="card-text">test text</p>
			  	</div>
		  	</div>
		  	<div class="card">
				<a href="#"><img class="card-img-top zoom" src="<%= request.getContextPath() %>/images/spoopy.png"/></a>
			  	<div class="card-body dark">
			  		<a href="#"><h5 class="card-title">TEST HEADING</h5></a>
			  		<p class="card-text">test text</p>
			  	</div>
		  	</div>
	  	</div>
	</div>
	
	<a href="#"><h6 style="text-align:center;">Older Posts</h6></a>
</body>
<script>
	$('#show-news-btn').click(function (e) {
		console.log("CLICKED");
	})
</script>
</html>