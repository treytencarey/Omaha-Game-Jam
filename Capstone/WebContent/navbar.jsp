<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<div id="allNavBar">
	<%@page import = "utils.Utils" %>
	<%@page import="database.Profile" %>
	<%@page import="project.Main" %>

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
	<%@include file="components/loginRegisterModal.jsp" %>
	<%@include file="components/newGameModal.jsp" %>
<%}%>

<% if (request.getRequestURI().equals(request.getContextPath()+"/Events/") || request.getRequestURI().equals(request.getContextPath()+"/AdminPanel/"))  { %>
	<!-- New Event Modal HTML -->
	<div id="newEventModal" class="modal fade">
		<div class="modal-dialog modal-login newMods">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Create New Event</h4>
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">
					<form class="was-validated" action="<%= request.getContextPath() %>/accountServlet" method = "post">
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
								<input type="text" class="form-control modalFields" name="theme" placeholder="Theme" required>
								<div class="invalid-feedback">Please enter a valid event theme</div>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
								<textarea class="form-control modalFields" name="description" placeholder="Description" required></textarea>
								<div class="invalid-feedback">Please enter a valid description</div>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							    <input type="file" class="custom-file-input" id="validatedCustomFile" required>
							    <label class="form-control modalFields custom-file-label" for="validatedCustomFile">Choose Image(s)...</label>
							    <div class="invalid-feedback">Please upload a valid image(s)</div>
						    </div>
					  	</div>
					  	<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon icons"><i class="fa fa-exclamation"></i></span>
								<textarea class="form-control modalFields" name="mutator" placeholder="Mutator(s)" required></textarea>
								<div class="invalid-feedback">Please enter a valid mutator(s)</div>
							</div>
						</div>

						<div class="form-group">
							<button type="submit" name="newEventButton" class="btn btn-primary btn-block btn-lg">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<%}%>

<!-- New News Article Modal HTML -->
<div id="newNewsArticleModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add News Article</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%= request.getContextPath() %>/NewsServlet" method = "post">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fas fa-newspaper"></i></span>
							<input type="text" class="form-control modalFields" name="newsTitle" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid title.</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<input type="text" class="form-control modalFields" name="newsHeader" placeholder="Header" required>
							<div class="invalid-feedback">Please enter a valid header.</div>
						</div>
					</div>
					<div class="form-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<textarea id="newsBody" name="newsBody"></textarea>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <input type="file" class="custom-file-input" id="newsFile" required>
						    <label class="form-control modalFields custom-file-label" for="newsFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image.</div>
					    </div>
				  	</div>
				  	<div class="form-group">
					  	<div class="form-check">
	  						<input class="form-check-input" type="checkbox" value="isPublicCheckbox" name="isPublicCheckbox" checked>
	  						<label class="form-check-label">
	    						Make Public
	  						</label>
						</div>
					</div>

					<div class="form-group">
						<button type="submit" id="newNewsArticleButton" name="newNewsArticleButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
