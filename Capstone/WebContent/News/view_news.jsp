<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://js.nicedit.com/nicEdit-latest.js"
	type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Styles/profileStyle.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Styles/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Styles/navStyle.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Styles/viewNewsStyle.css">
</head>
<body>
	<%@include file="/Common/navbar.jsp"%>

	<%@page import="beans.News"%>
	<%@page import="project.Main"%>

	<%
		try {
			int newsId = Integer.parseInt(request.getParameter("id"));
			News n = new News(newsId);
			request.setAttribute("newsTitle", n.getTitle());
			int[] postKeys = News.getMostRecentNewsPostsKeys(3, newsId, 1);
			News[] recentNews = new News[postKeys.length];
			for (int i = 0; i < recentNews.length; i++) {
				recentNews[i] = new News(postKeys[i]);
			}
	%>
	<div class="admin-controls">
		<h5>Admin Controls:</h5>
		<a id="editArticleBtn" href="#editNewsArticleModal" class="btn btn-primary btn-med" style="cursor: pointer;" role="button" data-toggle="modal">Edit Article</a>
		<a id="deleteArticleBtn" href="#deleteNewsArticleModal" class="btn btn-primary btn-med" style="cursor: pointer;" role="button" data-toggle="modal">Delete Article</a>
	</div>
	<div class="news-container">
		<div>
			<div style="text-align: center; font-style: italic; font-size: 12px;">
				Posted on
				<%=n.getDate()%></div>
			<img class="mainImg rounded"
				src="<%=request.getContextPath() + "/Uploads/News/Photo/" + n.getKey() + "_header.png"%>" />
			<h1 style="text-align: center;"><%= n.getTitle() %></h1>
			<br>
			<h4 style="text-align: center;"><%=n.getHeader()%></h4>
			<br>
			<div id="news-body" class="news-body"><%=n.getBody()%></div>
		</div>
	</div>
	<br>
	<h5 class="page-text">
		Recent News
		</h5>
		<!-- Container for other recent news articles -->
		<div class="container" style="text-align: center;">
			<div class="row justify-content-center">
				<%
					for (int i = 0; i < recentNews.length; i++) {
				%>
				<div class="col-sm">
					<div class="card">
						<a
							href="<%=request.getContextPath()%>/News/view?id=<%=recentNews[i].getKey()%>"><img
							class="card-img-top zoom"
							src="<%=request.getContextPath() + "/Uploads/News/Photo/" + recentNews[i].getKey() + "_header.png"%>" /></a>
						<div class="card-body dark">
							<h5 class="card-title"><%=recentNews[i].getTitle()%></h5>
							<p class="card-text"><%=recentNews[i].getHeader()%></p>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>

		<!-- Edit News Article Modal HTML -->
		<div id="editNewsArticleModal" class="modal fade">
			<div class="modal-dialog modal-login newMods">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Edit News Article</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<form class="was-validated"
							action="<%=request.getContextPath()%>/NewsServlet"
							method="post" enctype="multipart/form-data">
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon icons"><i
										class="fas fa-newspaper"></i></span> <input
										value="<%=n.getTitle()%>" type="text"
										class="form-control modalFields" name="newsTitle"
										placeholder="Title" required>
									<div class="invalid-feedback">Please enter a valid title.</div>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon icons"><i
										class="fas fa-heading"></i></span> <input
										value="<%=n.getHeader()%>" type="text"
										class="form-control modalFields" name="newsHeader"
										placeholder="Header" required>
									<div class="invalid-feedback">Please enter a valid
										header.</div>
								</div>
							</div>
							<div class="form-group">
								<span class="input-group-addon icons"><i
									class="fas fa-heading"></i></span>
								<textarea id="editNewsBody" name="newsBody"><%=n.getBody()%></textarea>
							</div>
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
								    <input type="file" class="custom-file-input" id="newsFile" name="newsFile">
								    <label class="form-control modalFields custom-file-label" for="newsFile">Choose Image(s)...</label>
								    <div>(Not uploading an image will keep it the same)</div>
					    		</div>
							</div>
							<div class="form-group">
								<div class="form-check">
									<input class="form-check-input" type="checkbox"
										value="isPublicCheckbox" name="isPublicCheckbox" checked>
									<label class="form-check-label"> Make Public </label>
								</div>
								<input type="hidden" name="newsId" value="<%=n.getKey()%>" />
							</div>

							<div class="form-group">
								<button type="submit" id="editNewsArticleButton"
									name="editNewsArticleButton"
									class="btn btn-primary btn-block btn-lg">Submit</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<%
			} catch (NullPointerException e) {
		%>
		<div class="row">
			<h3 style="width: 100%; text-align: center;">This isn't the news
				page you're looking for.</h3>
		</div>
		<%
			}
		%>
	
</body>
<script>
	var bodyField;
	loadEditor();

	function loadEditor() {
		bodyField = new nicEditor({
			fullPanel : true
		}).panelInstance("editNewsBody");
		$("editNewsBody").width("100%");
		$('.nicEdit-panelContain').parent().css({
			width : '100%',
			padding : "0"
		});
		$('.nicEdit-panelContain').parent().next().css({
			width : '100%',
			padding : "5px"
		});
		$('.nicEdit-main').css({
			width : '100%',
			padding : "0",
			minHeight : "80px"
		});
	}
</script>
</html>
