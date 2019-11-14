<div id="newEventModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Create New Event</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" action="<%= request.getContextPath() %>/EventServlet" method = "post">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control modalFields" name="title" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid event theme</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control modalFields" name="theme" placeholder="Theme" required>
							<div class="invalid-feedback">Please enter a valid event theme</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" placeholder="Description" required></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group newEventImages">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							<input type="file" class="custom-file-input" name="eventImage" id="validatedCustomFile" required/>
						    <label class="form-control modalFields custom-file-label" for="validatedCustomFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image(s)</div>
					    </div>
					    <input type="button" value="Add another image" id="add-image" />
				  	</div>
				  	<div class="form-group">
						<div class="input-group newEventMutators">
							<span class='input-group-addon icons'><i class='fa fa-exclamation'></i></span>
							<input type='text' class='mutator' name='mutator' placeholder='Mutator' />
							<input type='text' class='mutatorDescription' placeholder='Description' />

						</div>
						<input type="button" value="Add another mutator" id="add-mutator" /><br><br>
					</div>

				  	<div class="form-group">
				  		<div class="input-group eventDates">
			    	  		<input id="datepicker" width="270" />
						    <script>
						        $('#datepicker').datepicker({
						            uiLibrary: 'bootstrap'
						        });
						    </script>
				  		</div>
				  	</div>

					<div class="form-group">
						<button type="submit" name="newEventButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>