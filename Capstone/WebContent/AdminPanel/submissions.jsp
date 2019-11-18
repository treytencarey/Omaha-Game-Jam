<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/indexStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
</head>
<!-- A lot of this page is hard-coded at the moment as a sort of proof of concept -->
<!-- Admins will be able to update the homepage in the future -->

<body>
	<%@page import="java.util.List" %>
	<%@page import="java.util.Map" %>
	<%@page import="database.Database" %>
	<%@include  file="/Common/navbar.jsp" %>
	
	<% 	int TableLen = 20;
	 	int TablePage = 0;
		try {
			TablePage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page"))-1 : 0;
		} catch (Exception e) { }
		if (TablePage < 0)
			TablePage = 0;
	%>
	
	<!-- For changing public status -->
	<form style="display: none;" id="publicForm">
		<input name="publicPKey">
		<input name="publicChecked">
		<input name="publicChanged">
		<button id="publicButton"></button>
	</form>
	<% session.setAttribute("servlet", "gameServlet"); %>
	<% session.setAttribute("form", "#publicForm"); %>
	<%@include file="/components/ajax.jsp" %>
	<script>
		function onPublicSwitchChanged(elem) {
			document.getElementsByName("publicPKey")[0].value = elem.id.substr(6);
			document.getElementsByName("publicChecked")[0].value = elem.checked ? "1" : "0";
			document.getElementById("publicButton").click();
		}
	</script>
	
	<table class="table table-dark" id="submissionTable">
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">Event</th>
				<th scope="col">Submitter</th>
				<th scope="col">Title</th>
				<th scope="col">Link</th>
				<th scope="col">Public</th>
			</tr>
		</thead>
		<tbody>
			<% 	int row = 0;
				for (Map<String, Object> submission : Database.executeQuery("SELECT g.*, (SELECT Email FROM Accounts WHERE PKey=g.SubmitterPKey) AS Email, (SELECT Title FROM Events WHERE PKey=g.EventPKey) AS EventTitle FROM Games g ORDER BY PKey DESC LIMIT " + String.valueOf(TablePage*TableLen) + "," + String.valueOf(TableLen))) { %>
					<tr>
						<th scope="row"><%= TableLen*TablePage+(++row) %></th>
						<td><%= submission.get("EventTitle") %></td>
						<td><a href="<%= request.getContextPath() %>/profile?id=<%= submission.get("SubmitterPKey") %>"><%= submission.get("Email") %></a></td>
						<td><a href="<%= request.getContextPath() %>/game?id=<%= submission.get("PKey") %>"><%= submission.get("Title") %></a></td>
						<td><a href="<%= submission.get("PlayLink") %>"><%= submission.get("PlayLink") %></a></td>
						<td>
							<!-- Default switch -->
							<div class="custom-control custom-switch">
							  <input type="checkbox" class="custom-control-input" id="switch<%= submission.get("PKey") %>" onchange="onPublicSwitchChanged(this)" <% if (submission.get("IsPublic").toString().equals("1")) { %> checked <% } %>>
							  <label class="custom-control-label" for="switch<%= submission.get("PKey") %>">Visible</label>
							</div>
						</td>
					</tr>
			<% 	} %>
		</tbody>
	</table>
	<% int MaxCount = Integer.parseInt(Database.executeQuery("SELECT COUNT(*) AS Count FROM Games").get(0).get("Count").toString()); %>
	<a style="text-color: white;">Showing <%= TablePage*TableLen+1 %> to <%= (TablePage*TableLen+TableLen < MaxCount) ? TablePage*TableLen+TableLen : MaxCount %> of <%= MaxCount %> entries</a>
	<div style="content-align: center;">
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item <%= (TablePage == 0) ? "disabled" : "" %>">
		      <a class="page-link" href="<%= request.getContextPath() %>/AdminPanel/submissions.jsp?page=<%= TablePage %>" tabindex="-1">Previous</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/AdminPanel/submissions.jsp?page=<%= (TablePage == 0 || TablePage == 1) ? 1 : TablePage %>"><%= (TablePage == 0) ? "<b>1</b>" : (TablePage == 1) ? 1 : TablePage %></a></li>
		    <% if (TablePage > 0 || MaxCount > TableLen*(TablePage+1)) { %>
		    		<li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/AdminPanel/submissions.jsp?page=<%= (TablePage == 0) ? 2 : TablePage+1 %>"><%= (TablePage == 0) ? 2 : "<b>" + String.valueOf(TablePage+1) + "</b>" %></a></li>
		    <% 	}
		    	if (MaxCount >= TableLen*(TablePage+2)) {
		    %>
		    		<li class="page-item"><a class="page-link" href="<%= request.getContextPath() %>/AdminPanel/submissions.jsp?page=<%= (TablePage == 0) ? 3 : TablePage+2 %>"><%= (TablePage == 0) ? 3 : TablePage+2 %></a></li>
		    <% 	} %>
		    <li class="page-item <%= (MaxCount < TableLen*(TablePage+(TablePage == 0 ? 1 : 2))) ? "disabled" : "" %>">
		      <a class="page-link" href="<%= request.getContextPath() %>/AdminPanel/submissions.jsp?page=<%= TablePage+2 %>">Next</a>
		    </li>
		  </ul>
		</nav>
	</div>
</body>