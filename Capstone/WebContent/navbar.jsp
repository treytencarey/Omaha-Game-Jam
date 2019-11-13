<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />


<div id="allNavBar">
	<%@page import = "utils.Utils" %>
	<%@page import="database.Profile" %>
	<%@page import="project.Main" %>
	<%	Profile p;

		try {
			p = new Profile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
		} catch (Exception e) {
			p = new Profile();
		}
	%>

	<% session.setAttribute("curPage", request.getRequestURI() + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "")); %>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	  <a class="navbar-brand" href="<%= request.getContextPath() %>/">Omaha Game Jam</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="<%= request.getContextPath() %>/">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Events">Events</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Games">Games</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/Gallery">Gallery</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%= request.getContextPath() %>/News">News</a>
	      </li>
	    </ul>
	    <ul class="navbar-nav navbar-right" id="loginUL">
		    <%	if (session.getAttribute("accountPKey") == null) { %>
		    	<li><button id="loginBtn" class="btn btn-link my-2 my-sm-0" name="login"><a id="loginBtn" href="#loginModal" class="trigger-btn" data-toggle="modal">Login</a></button></li>
		    <%	} else { %>
		    	<li>
		    		<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    			<%= session.getAttribute("accountEmail") %>
		    		</button>
		    		<div id="profileDropdown" class="dropdown-menu dropdown-menu-right">
		    			<a id="addGameBtn" href="#newGameModal" class="dropdown-item" data-toggle="modal">Submit Game</a>
		    			<a class="dropdown-item" href="<%= request.getContextPath() %>/profile?id=<%= session.getAttribute("accountPKey").toString() %>">My Profile</a>
		    			<div class="dropdown-divider"></div>
		    			<form style="padding: .25rem 0;"class="dropdown-item" action = "<%= request.getContextPath() %>/accountServlet" method = "post">
							<!-- <a class="trigger-btn logInOutBtn" name="logout">Logout</a> -->
							<button id="logoutBtn" class="btn btn-link my-2 my-sm-0" name="logout">Logout</button>
						</form>
		    		</div>
		    	</li>
			<%	} %>
		</ul>
	  </div>
	</nav>


	<%@include file="subNavbar.jsp" %>
</div>
<% if (session.getAttribute("message") != null && session.getAttribute("message").toString().length() > 0) { %>
 	   <div style="display: block; margin: auto; text-align: center;">
 	   	${sessionScope.message}
 	   </div>
 	   <br/>
 <% 	session.setAttribute("message", "");
 } %>

<%	if (session.getAttribute("accountPKey") == null) { %>
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
							<button type="submit" class="btn btn-primary btn-block btn-lg">Sign In</button>
						</div>
						<p class="hint-text"><a href="#">Forgot Password?</a></p>
					</form>
				</div>
				<div class="modal-footer"><a href="#registerModal" data-toggle="modal" data-target="#registerModal" data-dismiss="modal">Create account</a></div>
			</div>
		</div>
	</div>
	<% session.setAttribute("servlet", "accountServlet"); %>
	<% session.setAttribute("form", "#loginForm"); %>
	<%@page import="java.util.Arrays" %>
	<% session.setAttribute("updates", Arrays.asList("#loginUL", "#subNavBar")); %>
	<% session.setAttribute("successJS", "$('#loginModal').modal('hide');"); %>
	<% session.setAttribute("errorJS", "document.getElementById('loginModalError').style.display='block'; document.getElementById('loginModalErrorMessage').innerText=request.responseText;"); %>
	<%@include file="components/ajax.jsp" %>

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
							<button type="submit" class="btn btn-primary btn-block btn-lg">Register</button>
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
	<%@include file="components/ajax.jsp" %>
<%}%>
