<div id="editProfileModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Edit Profile</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<div class="profile-img">

                    	<%@page import="java.io.File" %>
                       	<% 	String absProfileImgPath = "/Uploads/Profiles/Pics/" + session.getAttribute("accountPKey");
                       		String profileImgPath = absProfileImgPath;
                           	if (!new File(Main.context.getRealPath(profileImgPath)).exists())
                       			profileImgPath = "https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg";
                           	else
                           		profileImgPath = request.getContextPath() + profileImgPath;
                       	%>
                        <img id="profile-img" style="width: 100%;" src="<%= profileImgPath %>" onError="this.src='https://middle.pngfans.com/20190511/as/avatar-default-png-avatar-user-profile-clipart-b04ecd6d97b1eb1a.jpg'"/>
                        <div>
							<% session.setAttribute("uploadFilePath", absProfileImgPath); %>
							<% session.setAttribute("uploadIncludeForm", true); %>
							<% session.setAttribute("uploadID", "profileUpload"); %>
							<%@include file="../components/upload.jsp" %>
							<% session.setAttribute("servlet", "filesServlet"); %>
							<% session.setAttribute("form", "#profileUpload"); %>
							<%@page import="java.util.Arrays" %>
							<% session.setAttribute("updates", Arrays.asList("#profile-img")); %>
							<% session.setAttribute("multipart", true); %>
							<%@include file="../components/ajax.jsp" %>
                        </div>
                    </div>
				<form class="was-validated" action="<%= request.getContextPath() %>/profileServlet" method = "post">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-user"></i></span>
							<input type="text" class="form-control modalFields" name="name" placeholder="Full Name" value="<%= p.getName() %>" required>
							<div class="invalid-feedback">Please enter a valid name</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-envelope"></i></span>
							<input type="email" class="form-control modalFields" name="email" placeholder="Email" value="<%= session.getAttribute("accountEmail") %>" required>
							<div class="invalid-feedback">Please enter a valid email</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-phone"></i></span>
							<input type="text" class="form-control modalFields" name="phoneNumber" placeholder="Phone Number" value="(402) 867-5309" required disabled>
							<div class="invalid-feedback">Please enter a valid phone number</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-info"></i></span>
							<input type="text" class="form-control modalFields" name="bio" placeholder="Bio" value="<%= p.getBio() %>">
							<div class="invalid-feedback">Please enter a bio</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-link"></i></span>
							<input type="text" class="form-control modalFields" name="site" placeholder="Website" value="<%= p.getWebsite() %>">
							<div class="invalid-feedback">Please enter a website</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-code"></i></span>
							<textarea class="form-control modalFields" name="skills" placeholder="Skills"><%
                            	String[] skills = p.getSkills().split("\n");
	                            for(String s : skills) {
                           	%><%= s %><%}%></textarea>
							<div class="invalid-feedback">Please enter a skill(s)</div>
						</div>
					</div>

					<div class="form-group">
						<button type="submit" name="update" class="btn btn-primary btn-block btn-lg">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>