<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="constants.ProfileConstants, beans.ProfileBean"%>
<%
	ProfileBean pp = (ProfileBean) pageContext.getAttribute(ProfileConstants.PROFILE);
	String ppp = (String) pageContext.getAttribute(ProfileConstants.PIC_PATH);

	if (pp == null)
		pp = new ProfileBean();
%>

<script src="pictureUploadPreview.js"></script>

<div id="editProfileModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Edit Profile</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%=request.getContextPath()%>/profile_edit" method="post" enctype="multipart/form-data" onsubmit="return isPicValid();">
					<input type="hidden" name="id" value="<%= pp.getId() %>">

					<!-- Simple pic upload -->
					<div class="form-group">
						<div class="input-group">
							<img id="picPrev" src="<%=ppp%>" onload="validatePic();" onerror="invalidatePic();"> <span class="input-group-addon icons"><i class="fa fa-user"></i></span> Select profile pic: <input type="file" name="pic" onchange="previewPic(this, 'picPrev');">
							<div class="invalid-feedback">Please select a valid image file</div>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-envelope"></i></span> <input type="email" class="form-control modalFields" name="email" placeholder="Email" value="<%=session.getAttribute("accountEmail")%>" required disabled>
							<div class="invalid-feedback">Please enter a valid email</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-user"></i></span> <input type="text" class="form-control modalFields" name="name" placeholder="Full Name" value="<%=pp.getName()%>" required>
							<div class="invalid-feedback">Please enter a valid name</div>
						</div>
					</div>
					<!--
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-phone"></i></span> <input type="text" class="form-control modalFields" name="phoneNumber" placeholder="Phone Number" value="(402) 867-5309" required disabled>
							<div class="invalid-feedback">Please enter a valid phone number</div>
						</div>
					</div>
					  -->
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-info"></i></span> <input type="text" class="form-control modalFields" name="bio" placeholder="Bio" value="<%=pp.getBio()%>">
							<div class="invalid-feedback">Please enter a bio</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-link"></i></span> <input type="text" class="form-control modalFields" name="site" placeholder="Website" value="<%=pp.getWebsite()%>">
							<div class="invalid-feedback">Please enter a website</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-code"></i></span>
							<textarea class="form-control modalFields" name="skills" placeholder="Skills"><%=pp.getSkills()%></textarea>
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

<script type="text/javascript">
	let picValid = false;
	function validatePic() {
		picValid = true;
		console.log("valid!");
	}
	function invalidatePic() {
		picValid = false;
		console.log("INvalid!");
	}
	function isPicValid() {
		if (! picValid)
			alert("Please select a valid image file");
		return picValid;
	}
</script>