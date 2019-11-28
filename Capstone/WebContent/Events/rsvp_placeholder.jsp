<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="database.Database,beans.Event, beans.EventTableBean" %>
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
	EventTableBean et = new EventTableBean();
	Event ec = et.getCurrentEvent();
	List<Map<String, Object>> results = Database.executeQuery("SELECT COUNT(*) FROM Attendees WHERE AccountPKey=" + apk + " AND EventPKey=" + ec.getKey());
	if (results.size() == 0) // Error contacting DB?
		throw new NullPointerException();
	
	String count = results.get(0).get("COUNT(*)").toString();
	if (count.equals("0"))
	{
		//INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (1, 1);
		String query = String.format("INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (%s, %s);", apk, ec.getKey());
		System.out.println(query);
		if (Database.executeUpdate(query).length() == 0)
		{
%>
You're now registered for <%= ec.getTitle() %>!
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