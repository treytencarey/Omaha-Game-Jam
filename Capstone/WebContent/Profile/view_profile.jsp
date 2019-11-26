<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="beans.ProfileBean, beans.GameTableBean, beans.GameBean, beans.Event, beans.EventTableBean, java.util.Map, java.util.ArrayList, java.util.Iterator"%>

<%
	ProfileBean p = (ProfileBean) request.getAttribute("Profile");
	String email = (String) request.getAttribute("Email");
	EventTableBean et = (EventTableBean) request.getAttribute("AttendedEvents");
	GameTableBean gt = (GameTableBean) request.getAttribute("Games");
	Map<String, ArrayList<String>> r = (Map<String, ArrayList<String>>) request.getAttribute("Roles");
	String picPath = (String) request.getAttribute("PicPath");
	Boolean canEdit = (Boolean) request.getAttribute("CanEdit");
	// Set the page context so editProfileModal can also access these attributes.
	pageContext.setAttribute("Profile", p);
	pageContext.setAttribute("PicPath", picPath);
	// For external_link_warning_modal
	pageContext.setAttribute("Website", p.getWebsite());
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
</head>
<body>
	<%@include file="/Common/navbar.jsp"%>
	<%@include file="/Common/external_link_warning_modal.jsp"%>
	<%
		if (canEdit.booleanValue()) {
	%>
	<%@include file="/Profile/editProfileModal.jsp"%>
	<a class= "btn btn-primary" id="editProfileBtn" href="#editProfileModal" class="nav-link" data-toggle="modal">Edit Profile</a>
	<%
		}
	%>

	<div class="container emp-profile">
		<form action="edit">
			<div class="row">
				<div class="col-md-4">
					<div class="profile-img">
						<img src="<%=picPath%>" alt="" />
					</div>
				</div>
				<div class="col-md-6">
					<div class="profile-head">
						<h5>
							<%=p.getName()%>
						</h5>
						<h6>
							<%=p.getBio()%>
						</h6>
						
						<%
						Iterator<Event> ei = et.getEvents().iterator();
						while (ei.hasNext())
						{
							Event e = ei.next();
						%>
						<a class="btn btn-primary" href="<%= request.getContextPath() %>/event?id=<%= e.getKey() %>"><%= e.getTitle() %></a>
						<%
						}
						%>
						
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item"><a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">About</a></li>
							<li class="nav-item"><a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Games</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="profile-work">
						<p>WEBSITE</p>
						<a id="websiteBtn" href="#externalLinkWarningModal" class="nav-link" data-toggle="modal"><%=p.getWebsite()%></a>
						<br />
						<p>SKILLS</p>
						<%=p.getSkills()%>
					</div>
				</div>
				<div class="col-md-8">
					<div class="tab-content profile-tab" id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
							<div class="row">
								<div class="col-md-6">
									<label>Name</label>
								</div>
								<div class="col-md-6">
									<p><%=p.getName()%></p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<label>Email</label>
								</div>
								<div class="col-md-6">
									<p><%= email %></p>
								</div>
							</div>
						</div>
						<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
							<div class="container">
								<div class="row">
									<div class="row">
										<%
											if (gt.getGames().size() < 1)
											{
										%>
											<h5><%= p.getName() %> currently has no contributions.</h5>
										<%
											}
											for(GameBean g : gt.getGames())
											{
												String gameLink = request.getContextPath() + "/game?id=" + g.getId();
												String gamePicPath = request.getContextPath() + "/Uploads/Games/Thumbnails/" + g.getId();
										%>
										<div class="col-lg-3 col-md-4 col-xs-6 thumb">
											<a class="thumbnail" href="<%= gameLink %>" data-image-id=""> <img class="img-thumbnail" src="<%= gamePicPath %>" alt="<%= g.getTitle() %>"></a>
											<%= g.getTitle() %>
											<ul>
											<%
												ArrayList<String> roles = r.get(g.getId());
												Iterator<String> i = roles.iterator();
												while (i.hasNext())
												{
											%>
												<li><%= i.next() %></li>
											<%	
												}
											%>
											</ul>
										</div>
										<%		
											}
										%>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
