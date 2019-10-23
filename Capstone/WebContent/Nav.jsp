<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">

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
        <a class="nav-link" href="/Capstone/Events.jsp">Events</a>
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
	    			<div class="dropdown-divider"></div>
	    			<form class="dropdown-item" action = "<%= request.getContextPath() %>/accountServlet" method = "post">
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
				<form action="<%= request.getContextPath() %>/accountServlet" method = "post">
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
				<form class="needs-validation" action="<%= request.getContextPath() %>/accountServlet" method = "post">
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
