<%@page import="beans.EventTableBean"%>
<%@page import="beans.Event"%>
<%@page import="database.Database"%>
<%@page import="project.Main"%>
<%@page import="java.util.ArrayList"%>
<div id="deleteGalleryPhotoModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Delete Gallery Photo?</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%=request.getContextPath()%>/GalleryServlet" method="post" enctype="multipart/form-data">
					<input type="text" id="galleryFile" name="galleryFile" hidden/>
					<input type="text" id="galleryEvent" name="galleryEvent" hidden/>
					<button type="submit" id="deleteGalleryPhotosButton" name="deleteGalleryPhotosButton" class="btn btn-danger btn-block btn-lg" style="background-color: red;">Delete</button>
				</form>
			</div>
		</div>
	</div>
</div>