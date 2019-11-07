<div id="allNavBar">
	<%@page import = "utils.Utils" %>
	
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
	    <ul class="navbar-nav navbar-right">
		    <%	if (session.getAttribute("accountPKey") == null) { %>
		    	<li><button id="loginBtn" class="btn btn-link my-2 my-sm-0" name="login"><a id="loginBtn" href="#loginModal" class="trigger-btn" data-toggle="modal">Login</a></button></li>
		    <%	} else { %>
		    	<li>
		    		<button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    			<%= session.getAttribute("accountEmail") %>
		    		</button>
		    		<div id="profileDropdown" class="dropdown-menu dropdown-menu-right">
		    			<a id="addGameBtn" href="#newGameModal" class="dropdown-item" data-toggle="modal">Submit Game</a>
		    			<a class="dropdown-item" href="<%= request.getContextPath() %>/profile/view?id=<%= session.getAttribute("accountPKey").toString() %>">My Profile</a>
		    			<div class="dropdown-divider"></div>
		    			<form style="padding: .25rem 0;"class="dropdown-item" action = "<%= request.getContextPath() %>/accountServlet" method = "post">
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
	
	
	<%@include file="subNavbar.jsp" %>
</div>
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
							<input id="validationPass1" type="password" class="form-control" name="password" placeholder="Password" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
							<input id="validationPass2" type="password" class="form-control" name="password2" placeholder="Confirm" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$">
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

<!-- New Game Modal HTML -->
<div id="newGameModal" class="modal fade">
	<div class="newGameMod modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add New Game</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%= request.getContextPath() %>/accountServlet" method = "post">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control addGameField" name="title" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid game title</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control addGameField" name="description" placeholder="Description" required></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <input type="file" class="custom-file-input" id="validatedCustomFile" required>
						    <label class="form-control addGameField custom-file-label" for="validatedCustomFile">Choose Icon...</label>
						    <div class="invalid-feedback">Please upload a valid icon</div>
					    </div>
				  	</div>
					
					
					<!--
					Need to add a for loop here to loop through all the available mutators for the current event!
					Waiting on backend to complete that before adding to frontend! 
					 -->
					<fieldset class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-exclamation"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Mutators</legend>
					      	<div class="col-sm-8 checkForms">
						        <div class="form-check">
					          		<input class="form-check-input" type="checkbox" id="mutatorCheck1">
					        		<label class="form-check-label" for="gridCheck1">
						          		Save ocean
					        		</label>
					        	</div>
					        	<div class="form-check">
						          	<input class="form-check-input" type="checkbox" id="mutatorCheck1">
					        		<label class="form-check-label" for="gridCheck1">
						          		No violence
					        		</label>
					        	</div>
					        	<div class="form-check">
					          		<input class="form-check-input" type="checkbox" id="mutatorCheck1">
					        		<label class="form-check-label" for="gridCheck1">
					          			3 color palette
					        		</label>
					        	</div>
					      	</div>
					    </div>
				    </fieldset>
				    
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <input type="file" class="custom-file-input" id="validatedCustomFile2" required>
						    <label class="form-control addGameField custom-file-label" for="validatedCustomFile2">Choose Screenshot(s)...</label>
						    <div class="invalid-feedback">Please upload a valid screenshot(s)</div>
					    </div>
				  	</div>
				  	
				  	<fieldset class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-apple"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">System(s)</legend>
						    <div class="col-sm-8 checkForms">
							    <div class="form-check form-check-inline">
								  	<input class="form-check-input" type="checkbox" id="windowsOSCheckbox1" value="windowsOption">
								  	<label class="form-check-label" for="windowsOSCheckbox1">Windows</label>
								</div>
								<div class="form-check form-check-inline">
								  	<input class="form-check-input" type="checkbox" id="macOSCheckbox2" value="macOption">
								  	<label class="form-check-label" for="macOSCheckbox2">Mac</label>
								</div>
								<div class="form-check form-check-inline">
								  	<input class="form-check-input" type="checkbox" id="linuxOSCheckbox" value="linuxOption">
								  	<label class="form-check-label" for="linuxOSCheckbox">Linux</label>
								</div>
							</div>
			  			</div>
		  			</fieldset>
				  	
				  	<div class="form-group">
				  		<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Tools</legend>
					  		<div class="col-sm-8">
						      	<select class="custom-select mr-sm-2" id="inlineFormCustomSelect" required aria-required="true">
							        <option></option>
						        	<option value="1">One</option>
						        	<option value="2">Two</option>
						        	<option value="3">Three</option>
						      	</select>
					    	</div>
			    		</div>
				  	</div>
				  	
				  	<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Credits</legend>
					      	<div class="col-sm-8">
								<input type="text" class="form-control creditField" name="credit" placeholder="Name">
							</div>
						</div>
					</div>
				  	
					<div class="form-group">
						<button type="submit" name="loginButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
