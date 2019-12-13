<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
	//if(!Account.isAdmin(request.getSession())) {
	//	response.sendRedirect(request.getContextPath());
	//}

	List<Map<String, Object>> query = Database.executeQuery("SELECT PKey, Title FROM Events");
	String events = "";
	for(int i = 0; i < query.size(); i++) {
		events = events + query.get(i).get("PKey").toString() + "-----" + query.get(i).get("Title").toString();
		if(i != query.size() -1 )
			events = events + "@@@";
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
	<div>
		<div id="total-table" class="analysis-table"></div>
		<div id="percent-change-table" class="analysis-table"></div>
	</div>
</body>
<script>
var eStr = "<%= events %>";
var evts = eStr.split("@@@");
var eventPKeys = [];
var eventTitles = [];

for(var i = 0; i < evts.length; i++) {
	var s = evts[i].split("-----");
	eventPKeys.push(s[0]);
	eventTitles.push(s[1]);
}

function getEventTitleFromKey(k) {
	for(var i = 0; i < eventPKeys.length; i++) {
		if(k == eventPKeys[i])
			return eventTitles[i];
	}
	
	return "";
}
</script>
<script src="analyzeData.js"></script>
</html>