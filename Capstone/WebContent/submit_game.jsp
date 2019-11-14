<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="database.Game" %>

<%
//Game g = (Game)request.getAttribute("game");
int test = Integer.parseInt(request.getParameter("id"));
System.out.println(test);
Game g = new Game(1); 
/*
if (g == null)
{
	g = new Game();
}
*/
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit a Game</title>
</head>
<body>
<form action="submit" method="POST">
	Game Icon: <input type="image" src="/game/<%= 1 %>/profile.png"><br>
	Title: <input name="title" value="<%= g.getTitle() %>" ><br>
	Description: <textarea rows="3" name="desc"><%= g.getDesc() %></textarea><br>
	Mutators: <br>
		<input type="checkbox" name="mutators" value="Bike"> I have a bike<br>
		<input type="checkbox" name="mutators" value="Car"> I have a car<br>
		<input type="checkbox" name="mutators" value="Boat" checked> I have a boat<br> 

	<input type="submit" value="Update profile">
</form>
</body>
</html>