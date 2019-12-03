<% 	if (session.getAttribute("uploadFilePath") != null) { %>
		<%@page import="database.Files" %>
		<% int PKey = Files.setSessionNextUploadFile(session, session.getAttribute("uploadFilePath").toString()); %>
		<% if (session.getAttribute("uploadInputOnly") == null) { %>
			<% if (session.getAttribute("uploadIncludeForm") != null) { %>
			<form <%= (session.getAttribute("uploadID") != null) ? "id='" + session.getAttribute("uploadID").toString() + "'" : "" %> action="${pageContext.request.contextPath}/filesServlet" method="post" enctype="multipart/form-data">
			<% } %>
				<label style="width: 100%; color: black;" for="<%= session.getAttribute("uploadInputID") == null ? "file" + String.valueOf(PKey) : session.getAttribute("uploadInputID") %>" class="custom-file-upload">
					<i class="fa fa-cloud-upload"></i> Custom Upload
				</label>
		<% } %>
				<input style="width: unset; opacity: 1; margin-left: 10px;" id="<%= session.getAttribute("uploadInputID") == null ? "file" + String.valueOf(PKey) : session.getAttribute("uploadInputID") %>" name="file<%= PKey %>" type="file" <%= session.getAttribute("uploadInputAttributes") != null ? session.getAttribute("uploadInputAttributes") : "" %> <% if (session.getAttribute("uploadInputOnly") == null) { %> onchange="document.getElementById('uploadSubmit').click();" <% } %>/>
		<% if (session.getAttribute("uploadInputOnly") == null) { %>
				<button id="uploadSubmit"></button>
			<% if (session.getAttribute("uploadIncludeForm") != null) { %>
			</form>
			<% } %>
		<% } %>
<% 	}
	session.setAttribute("uploadFilePath", null);			// The file path for the uploader MUST BE GIVEN for it to work.
	session.setAttribute("uploadIncludeForm", null);		// (OPTIONAL) Set to any value to include the upload's own form. Leave blank to not use form.
	session.setAttribute("uploadID", null);					// (OPTIONAL) The ID of the form, if uploadIncludeForm is set.
	session.setAttribute("uploadInputOnly", null);			// (OPTIONAL) Use only the input, no form or labels. Overrides uploadIncludeForm.
	session.setAttribute("uploadInputID", null);			// (OPTIONAL) The ID of the input. Creates a new ID if none given.
	session.setAttribute("uploadInputAttributes", null);	// (OPTIONAL) The attributes of the input.
%>