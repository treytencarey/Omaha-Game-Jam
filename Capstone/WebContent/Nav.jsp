<style>
body {margin: 0;}

.titleDivider {
     border-left:1px solid #38546d; 
     border-right:1px solid #16222c; 
     height:80px;
     position:absolute;
     right:249px;
     top:10px; 
}

ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

ul.topnav li {float: left;}

ul.topnav li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

ul.topnav li a:hover:not(.active) {background-color: #111;}

ul.topnav li a.active {background-color: #4CAF50;}

ul.topnav li.right {float: right;}

ul.topnav li.title {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  font-family: Arial;
  font-weight: bold;
}

@media screen and (max-width: 600px) {
  ul.topnav li.right, 
  ul.topnav li {float: none;}
}
</style>
<%@page import = "utils.Utils" %>

<% session.setAttribute("curPage", request.getRequestURI() + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "")); %>
<ul class="topnav">
  <li class="title">Omaha Game Jam</li>
  <li class="divider"></li>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="index.jsp">Events</a></li>
  <li><a href="index.jsp">Games</a></li>
  <li><a href="index.jsp">Gallery</a></li>
  <li><a href="index.jsp">Awards</a></li>
</ul>

<%@include  file="UserBar.jsp" %>

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
