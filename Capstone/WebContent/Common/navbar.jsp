<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
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
		    		<button id="accountBtn" type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
	<%@include file="/Common/loginRegisterModal.jsp" %>
	<%@include file="/Games/newGameModal.jsp" %>
<%}%>