<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="beans.GameBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<script>
function showEvent(str) {
  var xhttp;    
  if (str == "") {
    document.getElementById("txtHint").innerHTML = "";
    return;
  }
  xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("txtHint").innerHTML = this.responseText;
    }
  };
  xhttp.open("GET", "<%= request.getContextPath() %>/gamepull?event="+str, true);
  xhttp.send();
}
</script>
</head>
<body>

<form action=""> 
	<select name="customers" onchange="showEvent(this.value)">
		<option value="">Select a customer:</option>
		<option value="1">1</option>
		<option value="2 ">2</option>
		<option value="3">3</option>
	</select>
</form>
<br>
<div id="txtHint">Event games!</div>

</body>
</html>