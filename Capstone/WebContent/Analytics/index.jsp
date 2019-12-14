<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
	if(!Account.isAdmin(request.getSession())) {
		response.sendRedirect(request.getContextPath());
	}

	List<Map<String, Object>> aQuery = Database.executeQuery("SELECT COUNT(AccountPKey), EventPKey FROM Attendees GROUP BY EventPKey");
	String[][] eventCounts = new String[aQuery.size()][2];
	for(int i = 0; i < aQuery.size(); i++) {
		String eventKey = aQuery.get(i).get("EventPKey").toString();
		String cKey = aQuery.get(i).get("COUNT(AccountPKey)").toString();
		List<Map<String, Object>> eQuery = Database.executeQuery("SELECT Title FROM Events WHERE PKey=" + eventKey);
		String title = eQuery.get(0).get("Title").toString();
		eventCounts[i] = new String[2];
		eventCounts[i][0] = title;
		eventCounts[i][1] = cKey;
		//System.out.println(eventCounts[i][0]);
	}
	
	//build list of repeat attendees
	aQuery = Database.executeQuery("SELECT COUNT(AccountPKey), EventPKey FROM (SELECT * FROM Attendees WHERE AccountPKey IN (SELECT AccountPKey FROM Attendees GROUP BY AccountPKey HAVING COUNT(AccountPKey) > 1)) GROUP BY EventPKey");
	String[][] eventRepeatCounts = new String[aQuery.size()][2];
	for(int i = 0; i < aQuery.size(); i++) {
		String eventKey = aQuery.get(i).get("EventPKey").toString();
		List<Map<String, Object>> eQuery = Database.executeQuery("SELECT Title FROM Events WHERE PKey=" + eventKey);
		eventRepeatCounts[i] = new String[2];
		eventRepeatCounts[i][0] = eQuery.get(0).get("Title").toString();
		eventRepeatCounts[i][1] = aQuery.get(i).get("COUNT(AccountPKey)").toString();
	}
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://d3js.org/d3.v4.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<title>Analytics</title>
<style>
svg {
    font-family: Sans-Serif, Arial;
    display: inline-block;
    margin: 0 auto;
}
.line {
  stroke-width: 2;
  fill: none;
}

.axis path {
  stroke: white;
}

.text {
  font-size: 12px;
}

.x.axis line {
    stroke: white !important;
}

.title-text {
  font-size: 12px;
}
</style>
</head>
<style>
.graph-container {
	margin: 0 auto;
	background-color: white;
}

.graph-select {
	margin: 0 auto;
}

.head {
	width: fit-content;
	text-align: center;
	margin: 0 auto;
}

.analysis-table {
	width: fit-content;
	margin: 0 auto;
	text-align: center;
}
</style>
<body>
	<%@include file="/Common/navbar.jsp"%>
	<%@page import="database.Account"%>
	<%@page import="database.Database"%>
	<%@page import="java.io.BufferedReader" %>
	<%@page import="java.io.FileReader" %>
	<%@page import="java.io.IOException" %>
	<br>
	<h4 class="head">Analytics</h4>
	<br>
	<div class="head">RSVPs Overtime (From Different Referrers)</div>
	<div id="graph-container" class="graph-container"></div>
	<br>
	<hr class="my-2" style="background-color: #3b3b3b">
	<div class="head">Other Data</div>
	<br>
	<div id="total-table" class="analysis-table"></div>
	<br>
	<div id="percent-change-table" class="analysis-table"></div>
	<br>
	<div id="event-data-table" class="analysis-table"></div>
	<br>
</body>
<script>
var eventCounts = new Array();
var eventRepeatCounts = new Array();
<%  
for (int i = 0; i < eventCounts.length; i++) {  
%>  
	eventCounts[<%= i %>] = [];
	eventCounts[<%= i %>].push("<%=eventCounts[i][0]%>");
	eventCounts[<%= i %>].push("<%=eventCounts[i][1]%>");
<%}%> 

<%  
for (int i = 0; i < eventRepeatCounts.length; i++) {  
%>  
	eventRepeatCounts[<%= i %>] = [];
	eventRepeatCounts[<%= i %>].push("<%=eventRepeatCounts[i][0]%>");
	eventRepeatCounts[<%= i %>].push("<%=eventRepeatCounts[i][1]%>");
<%}%>
</script>
<script src="analyzeData.js"></script>
</html>