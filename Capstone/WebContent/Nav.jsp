<style>
#loginBtn {
  display: block;
  color: white;
  text-decoration: none;
  padding: 0px;
}
#logoutBtn {
  color: black;
  text-decoration: none;
  padding: 0px;
}
#profileDropdown {
  margin-right: 13px;
}
#validationPass1 {
	margin-right: 2px;
}
#validationPass2 {
	margin-left: 2px;
}
.modal-login {
	width: 350px;
}
.modal-login .modal-content {
	padding: 20px;
	border-radius: 5px;
	border: none;
}
.modal-login .modal-header {
	border-bottom: none;
       position: relative;
	justify-content: center;
}
.modal-login .close {
       position: absolute;
	top: -10px;
	right: -10px;
}
.modal-login h4 {
	color: #636363;
	text-align: center;
	font-size: 26px;
	margin-top: 0;
}
.modal-login .modal-content {
	color: #999;
	border-radius: 1px;
   	margin-bottom: 15px;
       background: #fff;
	border: 1px solid #f3f3f3;
       box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
       padding: 25px;
   }
.modal-login .form-group {
	margin-bottom: 20px;
}
.modal-login label {
	font-weight: normal;
	font-size: 13px;
}
.modal-login .form-control {
	min-height: 38px;
	padding-left: 5px;
	box-shadow: none !important;
	border-width: 0 0 1px 0;
	border-radius: 0;
}
.modal-login .form-control:focus {
	border-color: #ccc;
}
.modal-login .input-group-addon {
	max-width: 42px;
	text-align: center;
	background: none;
	border-width: 0 0 1px 0;
	padding-left: 5px;
	border-radius: 0;
}
.modal-login .btn {
    font-size: 16px;
    font-weight: bold;
	background: #19aa8d;
    border-radius: 3px;
	border: none;
	min-width: 140px;
    outline: none !important;
}
.modal-login .btn:hover, .modal-login .btn:focus {
	background: #179b81;
}
.modal-login .hint-text {
	text-align: center;
	padding-top: 5px;
	font-size: 13px;
}
.modal-login .modal-footer {
	color: #999;
	border-color: #dee4e7;
	text-align: center;
	margin: 0 -25px -25px;
	font-size: 13px;
	justify-content: center;
}
.modal-login a {
	color: #fff;
	text-decoration: underline;
}
.modal-login a:hover {
	text-decoration: none;
}
.modal-login a {
	color: #19aa8d;
	text-decoration: none;
}
.modal-login a:hover {
	text-decoration: underline;
}
.modal-login .fa {
	font-size: 21px;
}
i {
	margin-top: 10px;
}
</style>
<%@page import = "utils.Utils" %>

<% session.setAttribute("curPage", request.getRequestURI() + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "")); %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">Omaha Game Jam</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/Capstone/">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Events</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Games</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Gallery</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Awards</a>
      </li>
      <%	if (session.getAttribute("accountPKey") == null) { %>

      <%	} %>
    </ul>
    <ul class="navbar-nav navbar-right">
	    <%	if (session.getAttribute("accountPKey") == null) { %>
	    	<li><button id="loginBtn" class="btn btn-link my-2 my-sm-0" name="login"><a id="loginBtn" href="#loginModal" class="trigger-btn" data-toggle="modal">Login</a></button></li>
	    <%	} else { %>
	    	<li>
	    		<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    			<%= session.getAttribute("accountEmail") %>
	    		</button>
	    		<div id="profileDropdown" class="dropdown-menu dropdown-menu-right">
	    			<a class="dropdown-item" href="#">Submit Game</a>
	    			<a class="dropdown-item" href="/Capstone/profile/view?id=<%= session.getAttribute("accountPKey").toString() %>">My Profile</a>
	    			<% if(session.getAttribute("userClass") instanceof Admin) { %>
	    				<a class="dropdown-item" href="">Change Permissions</a>
	    			<% } %>
	    			<div class="dropdown-divider"></div>
	    			<form class="dropdown-item" action = "accountServlet" method = "post">
						<!-- <a class="trigger-btn logInOutBtn" name="logout">Logout</a> -->
						<button id="logoutBtn" class="btn btn-link my-2 my-sm-0" name="logout">Logout</button>
					</form>
	    		</div>
	    	</li>
				<!-- <form action = "accountServlet" method = "post">
					<a class="trigger-btn logInOutBtn" name="logout">Logout</a>
					<button id="logoutBtn" class="btn btn-link my-2 my-sm-0" name="logout">Logout</button>
				</form> -->
		<%	} %>
	</ul>
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>


<!-- <ul class="topnav">
  <li><a href="index.jsp">Home</a></li>
</ul> -->

<%@include file="UserBar.jsp" %>

<div style="text-align: center;"><a style="font-size: 2em;">${Utils.PROJNAME}</a></div>
<br/>
<br/>
<% if (session.getAttribute("message") != null && session.getAttribute("message").toString().length() > 0) { %>
 	   <div style="display: block; margin: auto; text-align: center;">
 	   	${sessionScope.message}
 	   </div>
 	   <br/>
 <% 	session.setAttribute("message", "");
 } %>

<!-- Login Modal HTML -->
<div id="loginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Sign In</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="accountServlet" method = "post">
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
						<button type="submit" name="loginButton" class="btn btn-primary btn-block btn-lg">Sign In</button>
					</div>
					<p class="hint-text"><a href="#">Forgot Password?</a></p>
				</form>
			</div>
			<div class="modal-footer"><a href="#registerModal" data-toggle="modal" data-target="#registerModal" data-dismiss="modal">Create account</a></div>
		</div>
	</div>
</div>

<!-- Register Modal HTML -->
<div id="registerModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Register</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="needs-validation" action="accountServlet" method = "post">
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
							<input id="validationPass1" type="password" class="form-control" name="password" placeholder="Password" required="required">
							<input id="validationPass2" type="password" class="form-control" name="password2" placeholder="Confirm" required="required">
						</div>
						<label>Use 8 or more characters with a mix of letters, numbers & symbols</label>
					</div>
					<div class="form-group">
						<button type="submit" name="registerButton" class="btn btn-primary btn-block btn-lg">Register</button>
					</div>
				</form>
			</div>
			<div class="modal-footer"><a href="#loginModal" data-toggle="modal" data-target="#loginModal" data-dismiss="modal">Sign in instead</a></div>
		</div>
	</div>
</div>
