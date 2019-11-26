<%@page import="java.io.Console"%>
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/gameViewStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	
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
	<%
		while (i.hasNext())
		{
			Event e = i.next();
	%>
			<div class="container gamesContainer">
				<h3 style="color: black; width: 100%; text-align: center;"><%= e.getTitle() %>: <%= e.getTheme() %></h3>
			</div>
			<div id="event<%= e.getKey() %>" class="container">
				<p>Loading games...</p>
				<script type="text/javascript"> displayEventGames(<%= e.getKey() %>); </script>
			</div>
	<%
		}
	%>
	<% if (request.getRequestURI().equals(request.getContextPath()+"/Games/"))  { %>
    <div id="createGameModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Create Game</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form class="needs-validation" action="<%= request.getContextPath() %>/accountServlet" method = "post">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input id="validationEmail" type="email" class="form-control" name="email" placeholder="Email" required="required">
							</div>
							<label>You can use letters, numbers & periods</label>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-lock"></i></span>
								<input id="validationPass1" type="password" class="form-control" name="password" placeholder="Password" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
								<input id="validationPass2" type="password" class="form-control" name="password2" placeholder="Confirm" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
							</div>
							<label>Use 8 or more characters with a mix of letters, numbers & symbols</label>
						</div>
						<div class="form-group">
							<button type="submit" name="registerButton" class="btn btn-primary btn-block btn-lg">Register</button>
						</div>
					</form>
				</div>
				<div class="modal-footer"><a href="#loginModal" data-toggle="modal" data-target="#loginModal" data-dismiss="modal">Sign in instead</a></div>
			</div>
		</div>
	</div>
	<%}%>
</body>
</html>