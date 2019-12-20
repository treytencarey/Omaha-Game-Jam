<div id="changeCredentialsModal" class="modal fade">
	<div class="modal-dialog modal-login newMods modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Update Credentials</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<hr>
			<div class="modal-body">
				<form action="<%= request.getContextPath() %>/accountServlet" method="post" onsubmit="return checkPassword()">
					<input type="hidden" value="<%= session.getAttribute("accountPKey") %>" name="accountpkey" />
					<div class="form-group">
						<div class="input-group">
							<input type="text" name="newusername" placeholder="Email" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<input type="password" id="newpassword" name="newpassword" placeholder="Password" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<input type="password" id="verifypassword" name="verifypassword" placeholder="Verify Password" />
						</div>
					</div>
					<div class="form-group">
						<button type="submit" name="alterCredentialsBtn" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
				
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
	function checkPassword(){
		if(document.getElementById("newpassword").value == document.getElementById("verifypassword").value){
			return true;
		}
		alert("Passwords must match");
		return false;
	}
</script>