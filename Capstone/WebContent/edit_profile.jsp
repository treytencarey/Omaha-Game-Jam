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
	
	<link rel="stylesheet" href="styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
</head>
<body>
	<%@include  file="Nav.jsp" %>
	
	<form action="view">
		<input type="hidden" name="id" value="<%= session.getAttribute("accountPKey").toString() %>">
		<input style="border: 1px solid black;" type="submit" value="View as guest">
	</form>
	
	<h2>Profile info</h2>

	<%@page import="database.Profile" %>
	<%	Profile p;
		
		try {
			p = new Profile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
		} catch (Exception e) {
			p = new Profile();
		}
	%>
	Profile picture: <%@include  file="components/fileUpload/action_file.jsp" %><br>
	<form action="/Capstone/profileServlet" method="post">
		Name: <input style="border: 1px solid black;" name="name" value="<%= p.getName() %>" ><br>
		Bio: <textarea style="border: 1px solid black;" rows="3" name="bio"><%= p.getBio() %></textarea><br>
		Website: <input style="border: 1px solid black;" name="site" value="<%= p.getWebsite() %>"><br>
		Skills: <textarea style="border: 1px solid black;" rows="3" name="skills"><%= p.getSkills() %></textarea><br>
		<input style="border: 1px solid black;" type="submit" name="update" value="Update profile">
	</form>

</body>
</html>