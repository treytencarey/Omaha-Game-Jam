<!-- Login Modal HTML -->
<div id="loginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Sign In</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div id="loginModalError" style="display: none;">
				<div style="text-align: center;">
					<a id="loginModalErrorMessage" style="color: red;">Error</a>
				</div>
			</div>
			<div class="modal-body">
				<form id="loginForm">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="email" class="form-control" name="email" placeholder="Email" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="password" class="form-control" name="password" placeholder="Password" required="required">
						</div>
					</div>
					<div class="form-group">
						<input name="loginButton" style="display: none;">
						<button id="modalLoginBtn" type="submit" class="btn btn-primary btn-block btn-lg">Sign In</button>
					</div>
					<p class="hint-text"><a href="#">Forgot Password?</a></p>
				</form>
			</div>
			<div class="modal-footer"><a id="registerModalLink" href="#registerModal" data-toggle="modal" data-target="#registerModal" data-dismiss="modal">Create account</a></div>
		</div>
	</div>
</div>
<% session.setAttribute("servlet", "accountServlet"); %>
<% session.setAttribute("form", "#loginForm"); %>
<%@page import="java.util.Arrays" %>
<% session.setAttribute("updates", Arrays.asList("#loginUL", "#subNavBar")); %>
<% session.setAttribute("successJS", "$('#loginModal').modal('hide');"); %>
<% session.setAttribute("errorJS", "document.getElementById('loginModalError').style.display='block'; document.getElementById('loginModalErrorMessage').innerText=request.responseText;"); %>
<%@include file="../components/ajax.jsp" %>

<!-- Register Modal HTML -->
<div id="registerModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Register</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div id="registerModalError" style="display: none;">
				<div style="text-align: center;">
					<a id="registerModalErrorMessage" style="color: red;">Error</a>
				</div>
			</div>
			<div class="modal-body">
				<form id="registerForm" class="needs-validation">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input id="validationEmail" type="email" class="form-control" name="email" placeholder="Email" required="required">
						</div>
						<label>You can use letters, numbers & periods</label>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input id="validationPass1" type="password" class="form-control" name="password" placeholder="Password" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
							<input id="validationPass2" type="password" class="form-control" name="password2" placeholder="Confirm" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
						</div>
						<label>Use 8 or more characters with a mix of letters, numbers & symbols</label>
					</div>
					<div class="form-group">
						<input name="registerButton" style="display: none;">
						<button id="registerBtn" type="submit" class="btn btn-primary btn-block btn-lg">Register</button>
					</div>
				</form>
			</div>
			<div class="modal-footer"><a href="#loginModal" data-toggle="modal" data-target="#loginModal" data-dismiss="modal">Sign in instead</a></div>
		</div>
	</div>
</div>
<% session.setAttribute("servlet", "accountServlet"); %>
<% session.setAttribute("form", "#registerForm"); %>
<% session.setAttribute("updates", Arrays.asList("#loginUL", "#subNavBar")); %>
<% session.setAttribute("successJS", "$('#registerModal').modal('hide');"); %>
<% session.setAttribute("errorJS", "document.getElementById('registerModalError').style.display='block'; document.getElementById('registerModalErrorMessage').innerText=request.responseText;"); %>
<%@include file="../components/ajax.jsp" %>