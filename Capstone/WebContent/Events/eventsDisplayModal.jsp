<%@page import="java.util.ArrayList" %>
<%@page import="beans.EventTableBean" %>
<%@page import="beans.Event" %>
<%@page import="database.Database"%>
<style>
table td{
	margin: 12px;
	padding: 12px;
}
table {
	border-collapse: separate;
	border-spacing: 10px;
	*border-collapse: expression('separate', cellSpacing = '10px');
}
</style>
<%
EventTableBean eventTable = new EventTableBean();

ArrayList<Event> futureEvents = eventTable.getFutureEvents();
ArrayList<Event> pastEvents = eventTable.getPastEvents();
%>


<div id="eventsDisplayModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Events</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<hr>
			<div class="modal-body">
				<h3>Future Events</h3>
				<table class="future-events">
					<tr>
						<th>Event Title</th>
						<th>Event Dates</th>
						<th>Options</th>
					</tr>
					<%
					for(Event event : futureEvents){
					%>
						<tr>
							<td><%= event.getTitle() %></td>
							<td><%= event.getStartDate() %> - <%= event.getEndDate() %></td>
							<td>
									<form action="<%= request.getContextPath() %>/ViewEventServlet" method = "post">
										<button type="submit" class="option" name="event-key" value="<%= event.getKey() %>" data-toggle="modal">Edit</button>
									</form>
									<form action="<%= request.getContextPath() %>/ViewEventServlet" method = "post">
										<button type="submit" class="option" name="event-key" value="<%= event.getKey() %>" data-toggle="modal">Schedule</button>
									</form>
							</td>
						</tr>
					<%}%>
				</table>
				<br><hr><br>
				
				<h3>Past Events</h3>
				<table class="past-events">
					<tr>
						<th>Event Title</th>
						<th>Event Dates</th>
						<th>Options</th>
					</tr>
					<%
					for(Event event : pastEvents){
					%>
						<tr>
							<td><%= event.getTitle() %></td>
							<td><%= event.getStartDate() %> - <%= event.getEndDate() %></td>
							<td>
									<form action="<%= request.getContextPath() %>/ViewEventServlet" method = "post">
										<button type="submit" class="option" name="event-key" value="<%= event.getKey() %>" data-toggle="modal">Edit</button>
									</form>
							</td>
						</tr>
					<%}%>
				</table>
			</div>
				
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>










