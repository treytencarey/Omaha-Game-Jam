<style>
body {margin: 0;}

ul.userbar {
  display: block;
  list-style-type: none;
  margin: 0;
  padding: 2px 2px;
  overflow: hidden;
  background-color: #002bdc;
  color: #bfbfbf;
}

ul.userbar li {display: inline-block;}

ul.userbar li a {
  color: white;
  text-align: center;
  text-decoration: none;
}

ul.userbar li.right {float:right;}

ul.userbar li a:hover {text-decoration: underline;}

@media screen and (max-width: 600px) {
  ul.userbar li {float: none;}
}
</style>
  <% if (session.getAttribute("accountPKey") == null) { %>
<ul class="userbar">
  <li>You are not logged in. | <a>Log in</a> or <li><a>Register</a></li>
</ul>
  <% } else { %>
<ul class="userbar">
  <li>Logged in as <%= session.getAttribute("accountEmail") %> | <form style="display:inline-block" action = "accountServlet" method = "post"><button name="logout"><a>Logout</a></button></form></li>
  <li class="right"><a>Submit a Game</a> | <a>My Profile</a></li>
</ul>
<% } %>