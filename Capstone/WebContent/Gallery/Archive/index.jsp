<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/newsStyle.css">
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
	<%@include file="/Common/navbar.jsp"%>
	<%@page import="beans.Event"%>
	<%@page import="beans.EventTableBean"%>
	<%@page import="project.Main"%>
	<%@page import="java.util.ArrayList"%>
	<%@page import="java.util.Collections"%>
	<h4 style="text-align: center;">Gallery Archive</h4>
	<br>
	<ul class="list-unstyled">
		<hr class="my-2" style="background-color: #3b3b3b">
		<%
			EventTableBean eventTable = new EventTableBean();
			ArrayList<Event> events = eventTable.getPastEvents();
			
			if(eventTable.getCurrentEvent().IsPublic())
				events.add(eventTable.getCurrentEvent());
		
			Collections.reverse(events);
			for (int i = 0; i < events.size(); i++) {
		%>
		<a href="<%=request.getContextPath()%>/Gallery?id=<%=events.get(i).getKey()%>">
			<li class="media archive-item"><img class="mr-3 archive-img-container" src="<%=request.getContextPath()%>/Uploads/Events/HeaderImages/<%= events.get(i).getKey() %>_header.png">
				<div class="media-body align-self-center">
					<h6 class="mt-0 mb-1"><%=events.get(i).getTitle()%></h6>
					<%=events.get(i).getTheme()%>
				</div></li>
		</a>
		<hr class="my-2" style="background-color: #3b3b3b">
		<%
			}
		%>
	</ul>
</body>
</html>