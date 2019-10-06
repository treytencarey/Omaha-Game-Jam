<form action="${pageContext.request.contextPath}<%= "/components/fileUpload/action_file_upload.jsp" + ((request.getQueryString() != null) ? "?" + request.getQueryString() : "") %>" method="post"
                        enctype="multipart/form-data">
	<input type="file" name="file" size="50" />
	<input type="submit" value="Upload File" <% if (session.getAttribute("uploadFileFunc") != null) { %> onclick="<%= session.getAttribute("uploadFileFunc").toString() %>()" <% } %> />
</form>