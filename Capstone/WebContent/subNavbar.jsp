<%	if (session.getAttribute("accountPKey") != null) { %>
	<nav id="subNavBar" class="navbar navbar-expand navbar-light bg-light">
	  <div class=" navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav ml-auto">
    		<% if (request.getRequestURI().equals("/Capstone/profile/view") && request.getParameter("id").equals(session.getAttribute("accountPKey")))  { %>
		      <li class="nav-item indvTabs">
		      	
           		<form action="edit">
		      		<input type="submit" class="nav-link" name="btnAddMore" value="Edit Profile"/>
		      	</form>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals("/Capstone/profile/edit"))  { %>
		      <li class="nav-item indvTabs">
		      	
		      	<form action="view">
                 	<input type="hidden" name="id" value="<%= session.getAttribute("accountPKey").toString() %>">
                 	<input type="submit" class="nav-link" name="btnAddMore" value="Guest View"/>
                </form>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals("/Capstone/Games/"))  { %>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Submit Game</a>
		      </li>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Edit Game</a>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals("/Capstone/Events/"))  { %>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Add Event</a>
		      </li>
		      <li class="nav-item indvTabs">
		        <a class="nav-link" href="#">Edit Event</a>
		      </li>
	      	<%}%>
	    </ul>
	  </div>
	</nav>
<%	} %>