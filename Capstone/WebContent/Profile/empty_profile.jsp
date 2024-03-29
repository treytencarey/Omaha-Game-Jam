<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="constants.ProfileConstants, beans.ProfileBean"%>
<%
	ProfileBean p = new ProfileBean();
	p.setId(request.getParameter("id"));
	Boolean canEdit = (Boolean) request.getAttribute(ProfileConstants.CAN_EDIT);
	pageContext.setAttribute(ProfileConstants.PROFILE, p);
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/profileStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<title>View Profile</title>
</head>
<body>
	<%@include file="/Common/navbar.jsp"%>
	<%
		if (canEdit.booleanValue()) {
	%>
	<%@include file="/Profile/editProfileModal.jsp"%>
		<nav id="subNavBar" class="navbar navbar-expand navbar-light bg-light">
			<div class=" navbar-collapse" id="navbarSupportedContent">
		    	<ul class="navbar-nav ml-auto">
		    		<li class="nav-item indvTabs">
						<a id="editProfileBtn" href="#editProfileModal" class="nav-link" data-toggle="modal">Edit Profile</a>
					</li>
				</ul>
			</div>
		</nav>
	<%
		}
	%>
	<div class="container emp-profile">
		<div class="row">
			<h3 style="color: black; width: 100%; text-align: center;">No profile has been created for this account yet.</h3>
		</div>
	</div>
</body>
</html>