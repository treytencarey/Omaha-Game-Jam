<%@page import="database.Account" %>
<%@page import="beans.EventTableBean" %>
<%@page import="beans.Event" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.ParseException" %>
<%@page import="java.text.SimpleDateFormat" %>

<nav id="subNavBar" class="navbar navbar-expand navbar-light bg-light">
<!-- Check if user is logged in -->
<%	if (session.getAttribute("accountPKey") != null) { %>
	  <div class=" navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav ml-auto">
	    
	    <!-- Check if user is admin -->
	    <% if(Account.isAdmin(request.getSession())) { %>
	    	<li class="nav-item indvTabs">
			  		<a class="nav-link" href="<%=request.getContextPath()%>/AdminPanel">Admin Panel</a>
			</li>
			
			<!-- Check if user is on Events page -->
	    	<% if (request.getRequestURI().equals(request.getContextPath()+"/Events/"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="addEventBtn" href="#newEventModal" class="nav-link" data-toggle="modal">Add Event</a>
		      </li>
		      <li class="nav-item indvTabs">
		        <a id="viewEventsBtn" href="#eventsDisplayModal" class="nav-link" data-toggle="modal">View Events</a>
		      </li>
	      	<%}%>
	      	
	      	<!-- Check if user is on Gallery page -->
	    	<% if (request.getRequestURI().equals(request.getContextPath()+"/Gallery/index.jsp"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="addPhotoBtn" href="#addGalleryPhotoModal" class="nav-link" data-toggle="modal">Add Photo(s)</a>
		      </li>
	      	<%}%>
	      	
	      	<!-- Check if user is on News page -->
	    	<% if (request.getRequestURI().equals(request.getContextPath()+"/News/"))  { %>
		      <li class="nav-item indvTabs">
		        <a id="addArticleBtn" href="#newNewsArticleModal" class="nav-link" data-toggle="modal">Add Article</a>
		      </li>
	      	<%}%>
	    <%}%>
				
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
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/Games/"))  { 
	      		EventTableBean etb = new EventTableBean();
	      		Event curE = etb.getCurrentEvent();
	      		Date start = new SimpleDateFormat("MM/dd/yyyy").parse(curE.getStartDate());
	      		Date end = new SimpleDateFormat("MM/dd/yyyy").parse(curE.getEndDate());
	      		Calendar c = Calendar.getInstance();
	      		c.setTime(start);
	      		c.add(Calendar.DATE, -1);
	      		start = c.getTime();
	      		c = Calendar.getInstance();
	      		c.setTime(end);
	      		c.add(Calendar.DATE, 1);
	      		end = c.getTime();
	      		
	      		System.out.println(start+" - "+end);
	      		Date current = new Date();
	      			if(current.before(end) && current.after(start)){ 
	      				System.out.println("Event happening");
	      				} 
	      			else{
	      				System.out.println("Event not happening");
	      					}
	      	%>
		      <li class="nav-item indvTabs">
		        <a id="addGameBtn" href="#newGameModal" class="nav-link" data-toggle="modal">Submit Game</a>
		      </li>
	      	<%}%>
	      	<% if (request.getRequestURI().equals(request.getContextPath()+"/Games/view_game.jsp")) { %>
	      	  <%@page import="database.Game" %>
	      	  <% if (session.getAttribute("accountPKey") != null && new Game(Integer.parseInt(request.getParameter("id").toString())).getSubmitter() == Integer.parseInt(session.getAttribute("accountPKey").toString())) { %>
			      <li class="nav-item indvTabs">
			      	<a id="editGameBtn" href="#newGameModal" class="nav-link" data-toggle="modal">Edit Game</a>
			      </li>
			  <% } %>
	      	<%}%>
	    </ul>
	  </div>
<%	} %>
</nav>