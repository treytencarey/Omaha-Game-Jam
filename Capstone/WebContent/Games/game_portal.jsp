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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function displayEventGames(eventId) {
	let xhttp;
 	let message; // The HTML to put inside the event div.
	if (eventId == "") {
		document.getElementById("txtHint").innerHTML = "";
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
		document.getElementById("event".concat(eventId)).innerHTML = message;
	};

	xhttp.open("GET", "<%= request.getContextPath() %>/gamepull?event="+eventId, true);
	xhttp.send();
}
</script>
</head>
<body>
<%
while (i.hasNext())
{
	Event e = i.next();
%>
<h1><%= e.getTitle() %>: <%= e.getDescription() %></h1>
<div id="event<%= e.getKey() %>">
	<p>Loading games...</p>
	<script type="text/javascript"> displayEventGames(<%= e.getKey() %>); </script>
</div>
<%
}
%>

</body>
</html>