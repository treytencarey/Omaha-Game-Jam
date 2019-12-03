<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="beans.GameBean, beans.Event, beans.EventTableBean, java.util.Iterator" %>
<%
EventTableBean et = new EventTableBean();
Iterator<Event> i = et.getEvents().iterator();
%>

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
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/profileStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/viewNewsStyle.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function displayEventGames(eventId) {
	let xhttp;
 	let message; // The HTML to put inside the event div.
 	let divId = "event".concat(eventId);
 	
	if (eventId == "") {
		document.getElementById(divId).innerHTML = "";
		return;
	}
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) { // AJAX successful
			if (this.responseText === "") // No games found for this event.
				message = "<p>No games have been submitted yet.</p>";
			else // 1+ games found.
				message = this.responseText;
		} else { // AJAX unsuccessful
			message = "Error retrieving games.";
		}
		document.getElementById(divId).innerHTML = message;
	};

	xhttp.open("GET", "<%= request.getContextPath() %>/gamepull?event="+eventId, true);
	xhttp.send();
}
</script>
</head>
<body>

<%@include  file="/Common/navbar.jsp" %>
<%@include file="/Games/newGameModal.jsp" %>

<div class="container" style="text-align: center;">
	<%
	while (i.hasNext())
	{
		Event e = i.next();
		// if event start date is in the past...
	%>
	<h1><%= e.getTitle() %>: <%= e.getTheme() %></h1>
	<div id="event<%= e.getKey() %>" class="row" >
		<p>Loading games...</p>
		<script type="text/javascript"> displayEventGames(<%= e.getKey() %>); </script>
	</div>
	<%
	}
	%>
</div>
</body>
</html>