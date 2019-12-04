<div id="newNewsArticleModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add News Article</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%= request.getContextPath() %>/NewsServlet" method = "post" enctype="multipart/form-data">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="newsTitle" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid title.</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="newsHeader" placeholder="Subtitle" required>
							<div class="invalid-feedback">Please enter a valid subtitle.</div>
						</div>
					</div>
					<div class="form-group">
							<span class="input-group-addon icons"><i class="fas fa-heading"></i></span>
							<textarea id="newsBody" name="newsBody"></textarea>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <input type="file" class="custom-file-input" id="newsFile" name="newsFile" accept="image/png,image/gif,image/jpeg" required>
						    <label class="form-control modalFields custom-file-label" for="newsFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image.</div>
					    </div>
				  	</div>
				  	<div class="form-group">
					  	<div class="form-check">
	  						<input class="form-check-input" type="checkbox" value="isPublicCheckbox" name="isPublicCheckbox" checked>
	  						<label class="form-check-label">
	    						Make Public
	  						</label>
						</div>
					</div>

					<div class="form-group">
						<button type="submit" id="newNewsArticleButton" name="newNewsArticleButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>