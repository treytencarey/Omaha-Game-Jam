<%@page import="beans.EventTableBean"%>
<%@page import="beans.Event"%>
<%@page import="database.Database"%>
<%@page import="project.Main"%>
<%@page import="java.util.ArrayList"%>
<%
	EventTableBean eTable = new EventTableBean();
	ArrayList<Event> listEvents = eTable.getPastEvents();
	request.setAttribute("listEvents", listEvents);
%>
<div id="addGalleryPhotoModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add Gallery Photo(s)</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%=request.getContextPath()%>/GalleryServlet" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<div class="input-group">
							<input type="file" class="custom-file-input" id="galleryUploads" name="galleryUploads" accept="image/png,image/gif,image/jpeg" required multiple> <label class="form-control modalFields custom-file-label" for="galleryUploads">Choose Image(s)...</label>
							<div class="invalid-feedback">Please upload a valid image.</div>
						</div>
					</div>
					<div class="form-group">
						<select class="browser-default custom-select" name="galleryEvent">
							<%
								for (int i = listEvents.size() - 1; i >= 0; i--) {
									if (i == listEvents.size() - 1) {
							%>
							<option value="<%= i %>" selected><%=listEvents.get(i).getTitle()%></option>
							<%
								} else {
							%>
							<option value="<%= i %>"><%=listEvents.get(i).getTitle()%></option>
							<%
								}
								}
							%>
						</select>
					</div>
					<div class="form-group">
						<button type="submit" id="addGalleryPhotosButton" name="addGalleryPhotosButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>