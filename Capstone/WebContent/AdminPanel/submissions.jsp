<div id="gameSubmissionsDisplayModal" class="modal fade">
	<div class="modal-dialog modal-xl modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Game Submissions</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<hr>
			<div class="modal-body">
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
				
				<% session.setAttribute("tableSQL", "" +
					"SELECT " +
						"(SELECT Title FROM Events WHERE PKey=g.EventPKey) AS Event, " +
						"(SELECT '<a target=''_blank'' href=''" + request.getContextPath() + "/profile?id='||g.SubmitterPKey||'''>'||(SELECT Email FROM Accounts WHERE PKey=g.SubmitterPKey)||'</a>') AS Submitter, " + 
						"(SELECT '<a target=''_blank'' href=''" + request.getContextPath() + "/game?id='||g.PKey||'''>'||g.Title||'</a>') AS Title, " +
						"(SELECT '<a target=''_blank'' href='''||g.PlayLink||'''>'||g.PlayLink||'</a>') AS Link, " +
						"(SELECT '" + 
						"	<div class=''custom-control custom-switch''>" +
						"		<input type=''checkbox'' class=''custom-control-input'' id=''switch'||g.PKey||''' onchange=''onPublicSwitchChanged(this)'' '||(SELECT CASE WHEN (g.IsPublic == 1) THEN 'checked' ELSE '' END)||'> " +
						"		<label class=''custom-control-label'' for=''switch'||g.PKey||'''>Visible</label> " +
						"	</div>'" +
						") AS Public " +
					"FROM Games g ORDER BY g.PKey DESC"); %>
				<%@include file="/components/sqlTable.jsp" %>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>