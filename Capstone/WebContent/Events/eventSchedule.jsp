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
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/eventStyle.css">
</head>
<body>
<%@include  file="/Common/navbar.jsp" %>
<%@page import="beans.Event" %>
<% Event event = (Event)request.getAttribute("event"); %>

<form class="was-validated mw-50" autocomplete="off" action="<%=request.getContextPath()%>/EventScheduleServlet" method = "post">
	<input autocomplete="false" type="hidden" type="text" style="display:none;" />
	<input type="hidden" value="<%=event.getKey()%>" name="EventPKey" />
	
	<h1>Schedule for <%= event.getTitle() %></h1>
    <div class="form-group">
		<div class="input-group">
			<textarea class="form-control modalFields" id="eventSchedule" name="eventSchedule" ></textarea>
		</div>
	</div>
    <button type="submit" class="add_field_button btn btn-primary">Submit</button>	  
</form>
</body>
<script>
var bodyField;
loadEditor();

function loadEditor() { 
	bodyField = new nicEditor({fullPanel: true}).panelInstance("eventSchedule");
	$("eventDescription").width("100%");
	$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
}
</script>
</html>
