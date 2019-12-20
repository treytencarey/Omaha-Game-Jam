<%@page import="beans.EventTableBean" %>
<%@page import="beans.Event" %>
<%@page import="database.Profile" %>
<%@page import="database.Database"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.ArrayList" %>
<%
	Event current = new EventTableBean().getCurrentEvent();
	ArrayList<Profile> rsvpd = new ArrayList<Profile>();
	ArrayList<Profile> all = new ArrayList<Profile>();
	ArrayList<Integer> rsvpkeys = new ArrayList<Integer>();
	ArrayList<Integer> allpkeys = new ArrayList<Integer>();
	
	List<Map<String, Object>> query = Database.executeQuery("SELECT AccountPKey FROM Attendees WHERE EventPKey="+current.getKey());
	String accountPKey = query.get(0).get("AccountPKey").toString();
	
	//Get all rsvped profiles
	for(int i = 0; i < query.size(); i++){
		List<Map<String, Object>> query2 = Database.executeQuery("SELECT * FROM Accounts WHERE PKey="+query.get(i).get("AccountPKey").toString());
		Profile p;
		try{
			p = new Profile(Integer.parseInt(query2.get(0).get("PKey").toString()));
		} catch (Exception profE){
			p = new Profile();
			try{
				p.setName(query2.get(0).get("Email").toString());
			} catch (Exception accE){
				// No profile found and no account found. Should never happen.
				continue;
			}
		}
		rsvpd.add(p);
		rsvpkeys.add((int)query2.get(0).get("PKey"));
	}
	//Get all profiles
	List<Map<String, Object>> query3 = Database.executeQuery("SELECT * FROM Accounts");
	for(int i = 0; i < query3.size(); i++){
		Profile p;
		try{
			p = new Profile(Integer.parseInt(query3.get(i).get("PKey").toString()));
		} catch (Exception profE){
			p = new Profile();
			try{
				p.setName(query3.get(i).get("Email").toString());
			} catch (Exception accE){
				// No profile found and no account found. Should never happen.
				continue;
			}
		}
		all.add(p);
		allpkeys.add((int)query3.get(i).get("PKey"));
	}
%>

<div id="accountListModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Profiles</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<hr>
			<div class="modal-body">
				<button id="display-rsvp" class="btn btn-secondary">Show RSVPed Users</button>
				<button id="display-all" class="btn btn-secondary">Show All Users</button><br><hr><br>
				<div id="rsvpd" style="display:none;">
					<h3>RSVPed Users</h3>
					<table class="rsvpd-users">
						<tr>
							<th>Username</th>
						</tr>
						<%
						int j = 0;
						for(Profile profile : rsvpd){
						%>
							<tr>
								<td><a href="<%= request.getContextPath() + "/profile?id=" + rsvpkeys.get(j++) %>" ><%= profile.getName() %> </a></td>
							</tr>
						<%}%>
					</table>
					<br><hr>
				</div>
				
				<div id="all" style="display:none;">
					<h3>All Users</h3>
					<table class="rsvpd-users">
						<tr>
							<th>Username</th>
						</tr>
						<%
						int h = 0;
						for(Profile profile : all){
						%>
							<tr>
								<td><a href="<%= request.getContextPath() + "/profile?id=" + allpkeys.get(h++) %>" ><%= profile.getName() %> </a></td>
							</tr>
						<%}%>
					</table>
					<br>
				</div>
			</div>
				
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
	$("#display-rsvp").click(function(){
		$("#rsvpd").toggle();
	});
	$("#display-all").click(function(){
		$("#all").toggle();
	});
</script>