<nav id="subNavBar" class="navbar navbar-expand navbar-light bg-light">
<%	if (session.getAttribute("accountPKey") != null) { %>
	  <div class=" navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav ml-auto">
				<li class="nav-item indvTabs">
			  		<a class="nav-link" href="<%= request.getContextPath() %>/AdminPanel">Admin Menu</a>
				</li>
    		<% if (request.getRequestURI().equals(request.getContextPath()+"/profile") && request.getParameter("id").equals(session.getAttribute("accountPKey")))  { %>
		      <li class="nav-item indvTabs">
		      	<a id="editProfileBtn" href="#editProfileModal" class="nav-link" data-toggle="modal">Edit Profile</a>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/profile/edit"))  { %>
		      <li class="nav-item indvTabs">
		      	
		      	<form action="view">
                 	<input type="hidden" name="id" value="<%= session.getAttribute("accountPKey").toString() %>">
                 	<input type="submit" class="nav-link" name="btnAddMore" value="Guest View"/>
                </form>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/Games/"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="addGameBtn" href="#newGameModal" class="nav-link" data-toggle="modal">Submit Game</a>
		      </li>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Edit Game</a>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/Events/"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="addEventBtn" href="#newEventModal" class="nav-link" data-toggle="modal">Add Event</a>
		      </li>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Edit Event</a>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/News/"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="add-article-btn" href="#newNewsArticleModal" class="nav-link" data-toggle="modal">Add Article</a>
		      </li>
	      	<%}%>
	    </ul>
	  </div>
<%	} %>
</nav>