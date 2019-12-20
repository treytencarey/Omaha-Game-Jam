<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>

<div id="changeSiteDescriptionModal" class="modal fade">
	<div class="modal-dialog modal-login newMods modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Site Description</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<hr>
			<div class="modal-body">
				<form action="<%= request.getContextPath() %>/AlterSiteServlet" method="post">
					<div class="form-group">
						<div class="input-group">
							<textarea class="form-control modalFields" id="siteDescription" name="siteDescription" placeholder="Site Description"></textarea>
						</div>
					</div>
					<div class="form-group">
						<button type="submit" name="changeSiteDescBtn" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
				
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
var mainBodyField;
loadEditor();

function loadEditor() { 
	mainBodyField = new nicEditor({fullPanel: true}).panelInstance("siteDescription");
	$("siteDescription").width("100%");
	$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
}
</script>