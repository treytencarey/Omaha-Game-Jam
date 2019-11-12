<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<script src="https://kit.fontawesome.com/62f9f1cacb.js" crossorigin="anonymous"></script>
  	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
	<script>
		$(document).ready(function(){
			$("#add-image").click(function(){
				$(".event-images").append("<input type='file' style='border: 1px solid black'  /><br>");
			});	
		});
		
		$(document).ready(function(){
			$("#add-mutator").click(function(){
				$(".event-mutators").append("<input type='text' class='mutator' style='border: 1px solid black; width: 75px;' /><input type='text' class='mutator-description' style='border: 1px solid black; width: 200px;' /><br>");
			});
		});
		
		$(document).ready(function(){
			$(".datepicker").datepicker();
		});
		
		var bodyField;
		loadEditor();

		function loadEditor() { 
			bodyField = new nicEditor({fullPanel: true}).panelInstance("eventDescription");
			$("eventDescription").width("100%");
			$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
		    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
		    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
		
	</script>
	
</head>
<body>
	<%@include  file="../navbar.jsp" %>
	<div style="text-align: center;">
		Admin Panel<br><br>
		
		<h3><b>Event Options:   </b></h3>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newEventModal">Create Event</button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#">Edit Event</button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#">Display Mutators</button>
		
	</div>
</body>
</html>