<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
<style>
.modal-body {
    position: relative;
    overflow-y: auto;
    padding: 15px;
}
</style>
<div id="burstEmailModal" class="modal fade">
	<div class="modal-dialog modal-md modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Email Attendees</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
					<form class="was-validated" action="<%= request.getContextPath() %>/SendEmailServlet" method="get" >
					
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="email-subject" placeholder="Subject" required>
							<div class="invalid-feedback">Please enter something in the Subject field</div>
							<div class="valid-feedback">Looks good!</div>
						</div>
					</div>
					 
					<div class="form-group">
						<div class="input-group">
							<textarea class="form-control modalFields" id="email-body" name="email-body" placeholder="Body"></textarea>
						</div>
					</div>
					<h4>Your Email Credentials</h4>
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="email" placeholder="Email Address" required>
						</div>
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="password" placeholder="Email Password">
						</div>
					</div>
					<div style="color: red;">
						<p>Note if you have two-factor-authentication on your email account you will need to follow the steps detailed in the following url:</p>
						<br>
						<p>https://support.google.com/accounts/answer/185833</p>
						<br>
						<p>Once you are on the App Passwords section, for "Select the app and device you want to generate the app password for" under the "Select app" option
						 choose "Other" with some sort of memorable name. 
						Hit generate, and copy the app password for your device and paste it into the password field above. Write this password down somewhere it is how this 
						site will authenticate your email address when sending emails from now on.</p>
					</div>
					<div class="form-group">
						<button type="submit" name="newEventButton" class="btn btn-primary btn-block btn-lg">Send Email</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
var eventBodyField;
loadEditor();

function loadEditor() { 
	eventBodyField = new nicEditor({fullPanel: true}).panelInstance("email-body");
	$("email-body").width("100%");
	$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
}
</script>