<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="database.Database, database.Event" %>
   	<%@page import="java.util.List" %>
	<%@page import="java.util.Map" %>
   
<%
/**
* This is the start of the business logic for RSVPing.
* In the future, this should be put into a servlet, likely accessed through AJAX.
*/
try
{
	String apk = session.getAttribute("accountPKey").toString();
	List<Map<String, Object>> query = Database.executeQuery("SELECT COUNT(*) FROM Attendees WHERE AccountPKey=" + apk);
	if (query.size() == 0) // Error contacting DB?
		throw new NullPointerException();
	
	String count = query.get(0).get("COUNT(*)").toString();
	if (count.equals("0"))
	{
		//INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (1, 1);
		Event e = (Event)session.getAttribute("ActiveEvent");
		String q = String.format("INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (%s, %s);", apk, e.getKey());
		System.out.println(q);
		if (Database.executeUpdate(q).length() == 0)
		{
%>
You're now registered for <%= e.getTitle() %>!
<%
		}
		else
		{
%>
Error communicating with DB.
<%
		}
	}
	else
	{
%>
	You're already registered!
<%	
	}
}
catch (NullPointerException npe)
{
%>
You must log in or create an account first!
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>