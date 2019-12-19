<%@page import="beans.EventTableBean"%>
<%@page import="beans.Event"%>
<%@page import="database.Database"%>
<%@page import="project.Main"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections" %>
<%
	EventTableBean eTable = new EventTableBean();
	ArrayList<Event> listEvents = new ArrayList<Event>();
	ArrayList<Event> pEvents = eTable.getPastEvents();

	Collections.reverse(pEvents);
	listEvents.add(eTable.getCurrentEvent());
	for (int i = 0; i < pEvents.size(); i++) {
		listEvents.add(pEvents.get(i));
	}
	
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
						<select class="browser-default custom-select" name="galleryEvent" id="galleryEventKey">
							<%
								for (int i = 0; i < listEvents.size(); i++) {
									if (i == 0) {
							%>
							<option value="<%=listEvents.get(i).getKey()%>" selected><%=listEvents.get(i).getTitle()%></option>
							<%
								} else {
							%>
							<option value="<%=listEvents.get(i).getKey()%>"><%=listEvents.get(i).getTitle()%></option>
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