<%@page import="java.util.ArrayList" %>
<%@page import="beans.EventTableBean" %>
<%@page import="beans.Event" %>
<%@page import="database.Database"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>

<%
EventTableBean eventTable = new EventTableBean();

ArrayList<Event> futureEvents = eventTable.getFutureEvents();
ArrayList<Event> pastEvents = eventTable.getPastEvents();
%>


<div id="mutatorssDisplayModal" class="modal fade">
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
						<th>Event</th>
						<th>Mutator</th>
						<th>Description</th>
					</tr>
					<%
					for(Event event : futureEvents){
						List<Map<String, Object>> query = 
							Database.executeQuery("SELECT * FROM Mutators WHERE EventPKey=\'"+event.getKey()+"\'");
					%>
						<tr>
							<td></td>
							<td><%= event.getStartDate() %> - <%= event.getEndDate() %></td>
							<td>
								<button>Edit</button>
								<button>View</button>
								<button>Publish</button>
								<button>Delete</button>
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
								<button>Edit</button>
								<button>View</button>
								<button>Publish</button>
								<button>Delete</button>
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