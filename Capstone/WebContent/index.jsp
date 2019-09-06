<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
</head>
<body>
	<%@include  file="Nav.jsp" %>
	<div style="text-align: center;">
		<b style="font-size: 1.5em;">Login or Register</b><br/>
		<%	if (session.getAttribute("accountPKey") == null) { %>
				<form action = "accountServlet" method = "post">
					<div style="display: inline-block;">
						<a>Username:</a><br/><br/>
						<a>Password:</a><br/><br/>
						<br/>
						<br/>
					</div>
					<div style="display: inline-block;">
						<input type = "text" style="border: 1px solid #ece6e8;" name = "email"><br/><br/>
						<input type = "password" style="border: 1px solid #ece6e8;" name = "password" /><br/><br/>
						<button name="loginButton">Login</button>
						<button name="registerButton">Register</button>
					</div>
				</form>
		<%	} else { %>
				<form action = "accountServlet" method = "post">
					<button name="logout">Logout</button>
				</form>
		<%	} %>
	</div>
</body>
</html>