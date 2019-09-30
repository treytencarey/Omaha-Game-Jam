<style>
body {margin: 0;}

un.userbar {
  display: block;
  list-style-type: none;
  margin: 0;
  padding: 3px 3px;
  overflow: hidden;
  background-color: #002bdc;
  color: #bfbfbf;
}

un.userbar li {display: inline-block;}

un.userbar li a {
  color: white;
  text-align: center;
  text-decoration: none;
}

un.userbar li a:hover {text-decoration: underline;}

@media screen and (max-width: 600px) {
  ul.userbar li {float: none;}
}
</style>
<un class="userbar">
  <% if (session.getAttribute("accountPKey") == null) { %>
  You are not logged in. | <li><a href="index.jsp">Log in</a></li> or <li><a href="index.jsp">Register?</a></li>
  <% } else { %>
  Logged in as <%= session.getAttribute("accountEmail") %> | Logout
  <% } %>
</un>