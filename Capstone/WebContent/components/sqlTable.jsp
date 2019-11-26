<% 	if (session.getAttribute("tableSQL") != null) { %>
		<%@page import="database.SqlTable" %>
		<% int PKey = SqlTable.setSessionNextSQLStatement(session, session.getAttribute("tableSQL").toString()); %>
		<div id="sqlTable<%= PKey %>">
		</div>
		<form id="sqlTableForm<%= PKey %>" style="display: none;">
			<input type="text" name="PKey" value="<%= PKey %>">
			<input type="text" id="sqlTablePage<%= PKey %>" name="page" value="1">
			<input type="text" name="sqlTable">
			<button type="submit" id="sqlTableSubmit<%= PKey %>"></button>
		</form>
		<script>
			function setSQLTablePage(PKey, page) {
				document.getElementById('sqlTablePage' + PKey).value = page;
				document.getElementById('sqlTableSubmit' + PKey).click();
				document.getElementById('sqlTable' + PKey).scrollIntoView();
			}
		</script>
		<% session.setAttribute("servlet", "sqlTableServlet"); %>
		<% session.setAttribute("form", "#sqlTableForm" + String.valueOf(PKey)); %>
		<% session.setAttribute("successJS", "document.getElementById('sqlTable" + String.valueOf(PKey) + "').innerHTML = data;"); %>
		<% session.setAttribute("errorJS", "document.getElementById('sqlTable" + String.valueOf(PKey) + "').innerHTML = request.responseText;"); %>
		<%@include file="/components/ajax.jsp" %>
		<script>
			setSQLTablePage(<%= PKey %>, 1);
			// When the page is refocused, refresh table elements (in case something was changed in a different tab).
			$(window).focus(function() {
			   setSQLTablePage(<%= PKey %>, document.getElementById('sqlTablePage<%= PKey %>').value);
			});
		</script>
<% 	}
	session.setAttribute("tableSQL", null);			// The SQL that the table is populated with.
	session.setAttribute("tableSQLPage", null);		// (OPTIONAL) The page that the table should be on.
%>