<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
	//if(!Account.isAdmin(request.getSession())) {
	//	response.sendRedirect(request.getContextPath());
	//}
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
</style>
<body>
	<%@include file="/Common/navbar.jsp"%>
	<%@page import="database.Account"%>
	<%@page import="java.io.BufferedReader" %>
	<%@page import="java.io.FileReader" %>
	<%@page import="java.io.IOException" %>
	<br>
	<h4 style="width: fit-content; text-align: center; margin: 0 auto;">Analytics</h4>
	<br>
	<select class="graph-select" id="data-select"></select>
	<div id="graph-container" class="graph-container"></div>
</body>
<script>
	var formattedData = [];
	
	function getWebsiteName(n) {
		var matches = n.match(/^https?\:\/\/(?:www\.)?([^\/:?#]+)(?:[\/:?#]|$)/i);
		if(matches)
			return(matches[1]);
		
		return "No Referer";
	}
	
	function containsElement(arr, w, d) {
		for(var i = 0; i < arr.length; i++) {
			if(arr[i].Referer == w && arr[i].Date == d)
				return i;
		}
		return -1;
	}
	
	function formatDate(d) {
		var dArr = d.split("/");
		return dArr[2] + "-" + dArr[0] + "-01";
		//return new Date(dArr[2], dArr[0], 01);
		//return new Date(dArr[2] + "-" + dArr[0] + "-01");
	}

	//go through csv to setup data
	d3.csv("activities.csv", function(data) {
		data.forEach(function(d) {
				var da = formatDate(d["AccessDate"]);
				var i = containsElement(formattedData, getWebsiteName(d["Referer"]), da);
				if(d["RSVPdEventPKey"] != "" && d["AccessDate"] != "") {
					if(i == -1) {
						formattedData.push({Referer: getWebsiteName(d["Referer"]), Date: da, RSVPs: 1});
					}
					else {
						formattedData[i].RSVPs += 1;
					}
				}
		});
				// descending order
				formattedData.sort(function (a, b) {
		    		if (a.Date > b.Date) {
		        		return 1;
		    		}
		    		if (b.Date > a.Date) {
		        		return -1;
		    		}
		    		return 0;
				});
				console.log(formattedData);
				//console.log(formattedData[1].Dates.length);
				displayGraph();
	});
	
	function displayGraph() {
		//var parseDate = d3.timeFormat("%m-%Y");
		var totalRSVPs = [];
		formattedData.forEach(function(d) {
			d.Date = new Date(d.Date);
			totalRSVPs.push(+d.RSVPs);
		});
		
		totalRSVPs.sort();
		
		var margin = {top: 30, right: 20, bottom: 30, left: 50},
	    width = 310 - margin.left - margin.right,
	    height = 310 - margin.top - margin.bottom;
		
		var sum = d3.nest().key(function(d) {return d.Referer;}).entries(formattedData);
		allKeys = sum.map(function(d){return d.key});
		
		var svgGraph = d3.select("#graph-container")
						 .selectAll("uniqueChart")
						 .data(sum)
						 .enter()
						 .append("svg")
						 .attr("width", width + margin.left + margin.right)
						 .attr("height", height + margin.top + margin.bottom)
						 .append("g")
						 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		var x = d3.scaleTime()
	    		  .domain(d3.extent(formattedData, function(d) { return d.Date; }))
	    		  .range([ 0, width ]);
		//var x = d3.scaleTime().domain([d3.min(domainDates), d3.max(domainDates)]).range([0, width]);
		svgGraph.append("g").attr("transform", "translate(0," + height + ")").call(d3.axisBottom(x).ticks(5));
		
		var y = d3.scaleLinear()
	    		  .domain([0, d3.max(formattedData, function(d) { return +d.RSVPs; })])
	    		  .range([ height, 0 ]);
		//var y = d3.scaleLinear().domain([0, d3.max(domainRSVPs)]).range([height, 0]);
		svgGraph.append("g").call(d3.axisLeft(y).ticks(5).tickValues(totalRSVPs));
		
		svgGraph.append("path").attr("fill", "none")
				.attr("stroke", "blue")
				.attr("stroke-width", 1.2)
				.attr("d", function(d) {
					return d3.line()
							 .x(function(d) { return x(d.Date); })
							 .y(function(d) { return y(+d.RSVPs); })
							 (d.values)
				});
		
		svgGraph.append("text")
				.attr("text-anchor", "start")
				.attr("y", -5)
				.attr("x", 0)
				.text(function(d){ return(d.key)})
				.style("fill", "blue");
	}
</script>
</html>