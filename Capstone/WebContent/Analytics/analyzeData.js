//gets a URL and uses regex to turn it into format "x.com / x.net / x.org etc."
//@param n - the URL of the website
//@return - the formatted website string
function getWebsiteName(n) {
	var matches = n.match(/^https?\:\/\/(?:www\.)?([^\/:?#]+)(?:[\/:?#]|$)/i);
	if (matches)
		return (matches[1]);

	return "No Referrer";
}

// checks given array to see if the Referrer (w) and date (d) match an element
// in
// it
// @param arr - array to check
// @param w - Referrer/website
// @param d - date
// @return - the index of the element in the array if it is found, -1 if it is
// not found
function containsElement(arr, w, d) {
	for (var i = 0; i < arr.length; i++) {
		if (arr[i].Referrer == w && arr[i].Date == d)
			return i;
	}
	return -1;
}

// gets the date and formats it into YYYY-MM-01 (we only care about month and
// year, so day is just set to 01)
// @param d - the date to format
// @return - the formatted date
function formatDate(d) {
	var dArr = d.split("/");
	return dArr[2] + "-" + dArr[0] + "-01";
}

function getThisMonthAndYear(arr, da) {
	var currentDate = new Date();
	var dateSplit = da.split("-");
	arr[0] += 1;
	// this year
	if(dateSplit[0] == currentDate.getFullYear()) {
		arr[2] += 1;
		
		// this month
		if(dateSplit[1] == currentDate.getMonth() + 1)
			arr[1] += 1;
	}
		
	return arr;
}

function percentageChange(arr) {
	var oldNum = arr[0];
	var newNum = arr[1];
	if(oldNum == 0)
		oldNum = 1;
	var v = newNum - oldNum;
	var out = ((v / oldNum) * 100);
	if(out > 0)
		return "+" + out + "%";
	
	return out + "%";
}

function checkYear(arr, date) {
	// last year
	if(date.split("-")[0] == new Date().getFullYear() - 1)
		arr[0] += 1;
	
	// current year
	if(date.split("-")[0] == new Date().getFullYear())
		arr[1] += 1;
	
	return arr;
}

function getEventData() {
	var out = [];
	out.push(["EVENT", "TOTAL RSVPs", "REPEAT RSVPs"]);
	var revCounts = eventCounts.reverse();
	var revRepeats = eventRepeatCounts.reverse();
	for(var i = 0; i < revCounts.length; i++) {
		var eName = revCounts[i][0];
		var total = revCounts[i][1];
		var repeats = 0;
		for(var j = 0; j < revRepeats.length; j++) {
			if(revCounts[i][0] == revRepeats[j][0]) {
				repeats = revRepeats[j][1];
				break;
			}
		}
		
		out.push([eName, total, repeats]);
	}
	
	return out;
}

var graphData = [];
var totalRSVPs = [ 0, 0, 0 ]; // respectively: all-time, this month, this year
var totalLogins = [ 0, 0, 0 ]; // respectively: all-time, this month, this year
var totalVisits = [ 0, 0, 0 ]; // respectively: all-time, this month, this year
var yearlyVisits = [ 0, 0 ]; // respectively: last year, this year
var yearlyRSVPs = [ 0, 0 ]; // respectively: last year, this year
var yearlyLogins = [ 0, 0 ]; // respectively: last year, this year

// go through csv to setup data
d3.csv("activities.csv", function(data) {
	data.forEach(function(d) {
				var da = formatDate(d["AccessDate"]);
				// track visits and account logins
				totalVisits = getThisMonthAndYear(totalVisits, da);
				
				// yearly visits
				yearlyVisits = checkYear(yearlyVisits, da);
				
				if (d["AccountPKey"] != "") {
					totalLogins = getThisMonthAndYear(totalLogins, da);
					yearlyLogins = checkYear(yearlyLogins, da);
				}
				
				// push data into format {Referrer, # of RSVPs} to feed into
				// line
				// graphs
				// only count data where the user has RSVP'd during a session
				if (d["RSVPdEventPKey"] != "" && d["AccessDate"] != "" && d["AccountPKey"] != "") {
					var i = containsElement(graphData,
							getWebsiteName(d["Referer"]), da);
					
					totalRSVPs = getThisMonthAndYear(totalRSVPs, da);
					yearlyRSVPs = checkYear(yearlyRSVPs, da);
					
					if (i == -1) {
						graphData.push({
							Referrer : getWebsiteName(d["Referer"]),
							Date : da,
							RSVPs : 1
						});
					} else {
						graphData[i].RSVPs += 1;
					}
				}
			});

	// order list
	graphData.sort(function(a, b) {
		if (a.Date > b.Date) {
			return 1;
		}
		if (b.Date > a.Date) {
			return -1;
		}
		return 0;
	});

	// setup table data
	var yearlyVisitsPercentChange = percentageChange(yearlyVisits);
	var yearlyRSVPsPercentChange = percentageChange(yearlyRSVPs);
	var yearlyLoginsPercentChange = percentageChange(yearlyLogins);
	
	var totalTableInputs = [ [" ", "This Month:", "This Year:", "All-Time:" ],
							 [ "Site Visits:", totalVisits[1], totalVisits[2], totalVisits[0] ],
							 [ "Logins:", totalLogins[1], totalLogins[2], totalLogins[0] ],
							 [ "RSVPs:", totalRSVPs[1], totalRSVPs[2], totalRSVPs[0] ] ];
	
	var percentChangeTableInputs = [ [ "Site Visits Percentage Change (Last Year vs. This Year):", yearlyVisitsPercentChange ],
									 [ "RSVPs Percentage Change (Last Year vs. This Year):", yearlyRSVPsPercentChange ],
									 [ "Logins Percentage Change (Last Year vs. This Year):", yearlyLoginsPercentChange ] ];
	
	var eventDataInputs = getEventData();

	// display results
	var tableWidth = 210;
	displayGraph();
	displayTables("total-table", tableWidth, totalTableInputs);
	displayTables("percent-change-table", tableWidth, percentChangeTableInputs);
	displayTables("event-data-table", tableWidth, eventDataInputs);
});

function displayTables(di, tableWidth, dataArr) {
	var tableDiv = document.getElementById(di);

	var table = document.createElement('TABLE');
	table.border = 2;

	var tableBody = document.createElement('TBODY');
	table.appendChild(tableBody);

	for (var i = 0; i < dataArr.length; i++) {
		var tr = document.createElement('TR');
		tableBody.appendChild(tr);

		for (var j = 0; j < dataArr[i].length; j++) {
			var td = document.createElement('TD');
			td.width = tableWidth;
			td.appendChild(document.createTextNode(dataArr[i][j]));
			tr.appendChild(td);
		}
	}

	tableDiv.appendChild(table);
}

function displayGraph() {
	graphData.forEach(function(d) {
		d.Date = new Date(d.Date);
	});

	var margin = {
		top : 30,
		right : 20,
		bottom : 30,
		left : 50
	}, width = 310 - margin.left - margin.right, height = 310 - margin.top
			- margin.bottom;

	var sum = d3.nest().key(function(d) {
		return d.Referrer;
	}).entries(graphData);
	allKeys = sum.map(function(d) {
		return d.key
	});

	var svgGraph = d3.select("#graph-container").selectAll("uniqueChart").data(
			sum).enter().append("svg").attr("width",
			width + margin.left + margin.right).attr("height",
			height + margin.top + margin.bottom).append("g").attr("transform",
			"translate(" + margin.left + "," + margin.top + ")");

	var x = d3.scaleTime().domain(d3.extent(graphData, function(d) {
		return d.Date;
	})).range([ 0, width ]);
	svgGraph.append("g").attr("transform", "translate(0," + height + ")").call(
			d3.axisBottom(x).ticks(4));

	var y = d3.scaleLinear().domain([ 0, d3.max(graphData, function(d) {
		return +d.RSVPs;
	}) ]).range([ height, 0 ]);
	svgGraph.append("g").call(d3.axisLeft(y).ticks(5));

	svgGraph.append("path").attr("fill", "none").attr("stroke", "blue").attr(
			"stroke-width", 1.2).attr("d", function(d) {
		return d3.line().x(function(d) {
			return x(d.Date);
		}).y(function(d) {
			return y(+d.RSVPs);
		})(d.values)
	});

	svgGraph.append("text").attr("text-anchor", "start").attr("y", -5).attr(
			"x", 0).text(function(d) {
		return (d.key)
	}).style("fill", "blue");
}