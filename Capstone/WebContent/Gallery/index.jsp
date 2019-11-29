<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/galleryStyle.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.css">

</head>
<body>
	<%@include file="/Common/navbar.jsp"%>
	<%@include file="addGalleryPhotoModal.jsp"%>
	<%@include file="deleteGalleryPhotoModal.jsp"%>
	<%@page import="beans.EventTableBean"%>
	<%@page import="beans.Event"%>
	<%@page import="database.Database"%>
	<%@page import="project.Main"%>
	<%@page import="java.util.ArrayList"%>
	<%@page import="utils.FolderReader"%>

	<div class="admin-controls">
		<h5 style="text-align: center;">Admin Controls:</h5>
		<a id="addPhotoBtn" href="#addGalleryPhotoModal" class="btn btn-primary btn-med" style="cursor: pointer;" role="button" data-toggle="modal">Add Photo(s)</a>
	</div>
	<h4 style="text-align: center;">Gallery</h4>
	<br>
	<%
		final String MEDIA_PATH = "/Uploads/Gallery";
		final String MEDIA_PATH_FULL = request.getContextPath() + MEDIA_PATH;
		ArrayList<Event> events = (ArrayList<Event>) request.getAttribute("events");
		//get three latest events
		for (int i = events.size() - 1; i >= 0 && i != events.size() - 4; i--) {
	%>
	<div>
		<img class="main-event-img rounded" src="<%=request.getContextPath()%>/images/spoopy.png" />
	</div>
	<h5 style="text-align: center;"><%=events.get(i).getTitle()%></h5>
	<br>
	<div class="event-photos-container">
		<div class="row justify-content-center">
			<%
				FolderReader fr = new FolderReader(MEDIA_PATH + "/" + events.get(i).getKey());
					String[] galleryPhotos = fr.getFileList();
					if (galleryPhotos != null) {
						for (int j = 0; j < galleryPhotos.length; j++) {
			%>
			<div class="admin-delete-container">
				<a href="<%=MEDIA_PATH_FULL%>/<%=events.get(i).getKey()%>/<%=galleryPhotos[j]%>" data-toggle="lightbox" data-gallery="event-gallery"><img class="event-img zoom" src="<%=MEDIA_PATH_FULL%>/<%=events.get(i).getKey()%>/<%=galleryPhotos[j]%>"></a>
				<div class="delete-overlay">
					<a id="deleteGalleryPhotosButton" href="#deleteGalleryPhotoModal" class="btn btn-primary btn-med" style="cursor: pointer; background-color: red; border-color: red; margin: 0 auto;" role="button" data-toggle="modal" data-id="<%=galleryPhotos[j]%>@__eventId<%=i%>">Delete</a>
				</div>
			</div>
			<%
				}
					} else {
			%>
				No photos have been posted for this event.
			<%
				}
			%>
		</div>
	</div>
	<hr class="my-2" style="background-color: #3b3b3b">
	<%
		}
	%>
</body>
<script>
	$(document).on('click', '[data-toggle="lightbox"]', function(event) {
		event.preventDefault();
		$(this).ekkoLightbox();
	});

	$(document).on('click', '#deleteGalleryPhotosButton', function() {
		var dataId = $(this).attr('data-id')
		var filename = dataId.split("@__eventId")[0];
		var idx = dataId.split("@__eventId")[1];
		$(".modal-body #galleryFile").val(filename);
		$(".modal-body #galleryEvent").val(idx);
	});
</script>
</html>