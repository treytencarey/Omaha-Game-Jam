<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	<%@include  file="navbar.jsp" %>

	<% try { %>
		<% Profile p = new Profile(Integer.parseInt(request.getParameter("id"))); %>
		<%@include file="components/editProfileModal.jsp" %>

		<div class="container emp-profile">
            <form action="edit">
                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-img">
                        	<%@page import="java.io.File" %>
                        	<% 	profileImgPath = "/Uploads/Profiles/Pics/" + request.getParameter("id");
                            	if (!new File(Main.context.getRealPath(profileImgPath)).exists())
                        			profileImgPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
                            	else
                            		profileImgPath = request.getContextPath() + profileImgPath;
                        	%>
                            <img src="<%= profileImgPath %>" alt=""/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="profile-head">
                                    <h5>
                                        <%= p.getName() %>
                                    </h5>
                                    <h6>
                                        <%= p.getBio() %>
                                    </h6>
                                    <p class="proile-rating">Attending Game Jam 2019 : <span>Yes</span></p>
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">About</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Games</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-work">
                            <p>WORK LINK</p>
                            <a href="<%= p.getWebsite() %>">Website Link</a><br/>
                            <p>SKILLS</p>
                            <%
                            	skills = p.getSkills().split("\n");
	                            for(String s : skills) {
                           	%>
	                            	<a href=""><%= s %></a><br/>
                           	<%
	                            }
                            %>
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
                                                <p><%= p.getName() %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Email</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><%= session.getAttribute("accountEmail") %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Phone</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p>123 456 7890</p>
                                            </div>
                                        </div>
                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            	<div class="container">
									<div class="row">
										<div class="row">
								            <div class="col-lg-3 col-md-4 col-xs-6 thumb">
								                <a class="thumbnail" href="#" data-image-id="">
								                    <img class="img-thumbnail"
								                         src="https://i.imgur.com/3Ry6Cvl.jpg"
								                         alt="Doom">
								                </a>
								            </div>
								            <div class="col-lg-3 col-md-4 col-xs-6 thumb">
								                <a class="thumbnail" href="#" data-image-id="">
								                    <img class="img-thumbnail"
								                         src="http://icons.iconarchive.com/icons/papirus-team/papirus-apps/512/minecraft-icon.png"
								                         alt="Minecraft">
								                </a>
								            </div>
								            <div class="col-lg-3 col-md-4 col-xs-6 thumb">
								                <a class="thumbnail" href="#" data-image-id="">
								                    <img class="img-thumbnail"
								                         src="https://images-na.ssl-images-amazon.com/images/I/519is%2BiWW%2BL.png"
								                         alt="Pong">
								                </a>
								            </div>
								        </div>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>


	<% } catch (Exception e) { %>
		<% Profile p = new Profile(); %>
		<%@include file="components/editProfileModal.jsp" %>
		<% if (request.getParameter("id").equals(session.getAttribute("accountPKey"))) { %>
			<div class="container emp-profile">
	    		<div class="row">
	    			<h3 style="color: black; width: 100%; text-align: center;">No profile has been created for this account yet.</h3>
    			</div>
            </div>
	<% }
	} %>
</body>
</html>
