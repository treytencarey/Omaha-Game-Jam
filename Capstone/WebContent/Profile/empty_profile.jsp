<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="beans.ProfileBean"%>
<%
ProfileBean p = new ProfileBean();
Boolean canEdit = (Boolean)request.getAttribute("CanEdit");
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/profileStyle.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">
</head>
<body>
	<%@include  file="/Common/navbar.jsp" %>
	<%@include file="/Profile/editProfileModal.jsp" %>
	
<%
if (canEdit.booleanValue())
{
%>
	<a id="editProfileBtn" href="#editProfileModal" class="nav-link" data-toggle="modal">Edit Profile</a>
<%
}
%>
Profile doesn't exist, yo!
</body>
</html>