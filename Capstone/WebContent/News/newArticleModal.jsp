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
							<input type="text" class="form-control modalFields" name="newsTitle" placeholder="Title" maxlength="80" required>
							<div class="invalid-feedback">Please enter a valid title.</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control modalFields" name="newsHeader" placeholder="Subtitle" maxlength="80" required>
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
						    <input type="file" class="custom-file-input" id="newsFile" name="newsFile" accept="image/png,image/gif,image/jpeg" onchange="Newsfilevalidation()" required>
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
<script>
Newsfilevalidation = () => {
    const file = document.getElementById("newsFile");
    if(file.files.length > 0){
        for(const i = 0; i <= file.files.length - 1; i++){

            const filesize = file.files.item(i).size;
            const fisz = Math.round((filesize/1024));
            if(fisz > 2048){
                alert("File too Big, please select a new file less than 2mb");
                document.getElementById("newsFile").value = null;
            }
        }
    }
}
</script>