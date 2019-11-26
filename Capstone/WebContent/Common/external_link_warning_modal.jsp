<%
String url = (String)pageContext.getAttribute("Website");
String vUrl;
if (! url.substring(0, 3).equals("http")) // Ensure website has "http" included.
	vUrl = "http://" + url;
else
	vUrl = url;
%>
<div id="externalLinkWarningModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">WARNING! External Link</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<p>You are about to leave InsertGameHere and visit an external website. Be aware that this website could be malicious, so please confirm the URL looks legitimate:</p>
				<h2><%= url %></h2>
			</div>
			<div class="modal-footer">
				<a class="btn btn-warning" href="<%= vUrl %>">Visit <%= url %></a>
				<button class="btn btn-primary" type="button" data-dismiss="modal" aria-hidden="true">Go back</button>
			</div>
		</div>
	</div>
</div>