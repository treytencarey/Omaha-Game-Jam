<%
String url = (String)pageContext.getAttribute("Website");
String vUrl;
if (url.indexOf("http") != 0) // Ensure website has "http" included.
	vUrl = "http://" + url;
else
	vUrl = url;
%>
<div id="externalLinkWarningModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" style="color: red;">WARNING! External Link</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body" style="color: black;">
				<p>You are about to leave InsertGameHere and visit an external website. Be aware that this website could be malicious, so please confirm the URL looks legitimate:</p>
				<h2 style="color: blue; font-style: italic; font-size: inherit;'"><%= url %></h2>
			</div>
			<div class="modal-footer">
				<a class="btn btn-warning" href="<%= vUrl %>" target="_blank">Continue to Site</a>
				<button class="btn btn-primary" type="button" data-dismiss="modal" aria-hidden="true">Go back</button>
			</div>
		</div>
	</div>
</div>