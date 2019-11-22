<div id="deleteNewsArticleModal" class="modal fade">
			<div class="modal-dialog modal-login newMods">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Delete This Article?</h4>
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<form class="was-validated" action="<%= request.getContextPath() %>/NewsServlet" method = "post">
							<input type="hidden" name="newsId" value="<%= n.getKey() %>" />
							<button type="submit" id="deleteNewsArticleButton" name="deleteNewsArticleButton" class="btn btn-danger btn-block btn-lg" style="background-color: red;">Delete</button>
						</form>
					</div>
				</div>
			</div>
		</div>