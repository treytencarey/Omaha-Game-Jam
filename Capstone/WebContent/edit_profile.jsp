<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
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

	<%@page import="database.Profile" %>
	<%@page import="project.Main" %>
	<%	Profile p;

		try {
			p = new Profile(Integer.parseInt(session.getAttribute("accountPKey").toString()));
		} catch (Exception e) {
			p = new Profile();
		}
	%>

	<div class="container emp-profile">

                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-img">

                        	<%@page import="java.io.File" %>
                        	<% 	String profileImgPath = "/Uploads/Profiles/Pics/" + session.getAttribute("accountPKey");
                            	if (!new File(Main.context.getRealPath(profileImgPath)).exists())
                        			profileImgPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
                            	else
                            		profileImgPath = request.getContextPath() + profileImgPath;
                        	%>
                            <img style="width: 100%;" src="<%= profileImgPath %>" alt=""/>
                            <div>
                                 <form action="/Capstone/filesServlet" method="post" enctype="multipart/form-data">
                                 	<label style="width: 100%; color: black;" for="file" class="custom-file-upload">
									    <i class="fa fa-cloud-upload"></i> Custom Upload
									</label>
									<input id="file" style="display: none;" class="file btn btn-lg btn-primary" name="file" type="file" onchange="this.form.submit()"/>
                                	<!-- <input id="image_uploads" class="file btn btn-lg btn-primary" type="file" name="image_uploads" onchange="this.form.submit()"/> -->
                                	<!-- <input class="btn btn-lg btn-primary" type="submit" value="Update"/> -->
                                </form>
                            </div>
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
                <form style="margin-top: 20px;" action="/Capstone/profileServlet" method="post">
	                <div class="row">
	                    <div class="col-md-4">
	                        <div class="profile-work">
	                            <p>WORK LINK</p>
	                            <a href="<%= p.getWebsite() %>">Website Link</a><br/>
	                            <p>SKILLS</p>
	                            <%
	                            	String[] skills = p.getSkills().split("\n");
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
	                                            	<input type="text" name="name" class="form-control" id="nameInput" value="<%= p.getName() %>">
	                                            </div>
	                                        </div>
	                                        <div class="row">
	                                            <div class="col-md-6">
	                                                <label>Bio</label>
	                                            </div>
	                                            <div class="col-md-6">
	                                            	<input type="text" name="bio" class="form-control" id="bioInput" value="<%= p.getBio() %>">
	                                            </div>
	                                        </div>
	                                        <div class="row">
	                                            <div class="col-md-6">
	                                                <label>Website</label>
	                                            </div>
	                                            <div class="col-md-6">
	                                            	<input type="text" name="site" class="form-control" id="bioInput" value="<%= p.getWebsite() %>">
	                                            </div>
	                                        </div>
	                                        <div class="row">
	                                            <div class="col-md-6">
	                                                <label>Skills</label>
	                                            </div>
	                                            <div class="col-md-6">
	                                            	<textarea class="form-control" id="skillsInput" name="skills" rows="5"><%= p.getSkills() %></textarea>
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
	                            <div style="float: right;">
		                            <% if (session.getAttribute("updateProfileMessage") != null && session.getAttribute("updateProfileMessage").toString().length() > 0) { %>
									 	   <div style="display: inline-block; margin-right: 20px; color: green;">
									 	   	${sessionScope.updateProfileMessage}
									 	   </div>
									 <% 	session.setAttribute("updateProfileMessage", "");
									 } %>
									 <input style="display: inline-block;" type="submit" class="btn btn-success" name="update" value="Save Profile">
								 </div>
	                        </div>
	                    </div>

	                </div>

                </form>
        </div>

</body>
</html>
