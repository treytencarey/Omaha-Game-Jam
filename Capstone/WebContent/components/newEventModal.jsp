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
							<div class="valid-feedback">Looks good!</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control modalFields" name="theme" placeholder="Theme" required>
							<div class="invalid-feedback">Please enter a valid event theme</div>
							<div class="valid-feedback">Looks good!</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" placeholder="Description" required></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
							<div class="valid-feedback">Looks good!</div>
						</div>
					</div>

					<div class="form-group multiplValueFields">
						<div class="input-group newEventImages">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							<input type="file" class="custom-file-input" name="eventImage" id="validatedCustomFile" required/>
						    <label class="form-control modalFields custom-file-label" for="validatedCustomFile">Choose Image(s)...</label>
						    <div class="invalid-feedback">Please upload a valid image(s)</div>
						    <div class="valid-feedback">Looks good!</div>
					    </div>
					    <input type="button" value="Add another image" class="add-image"/>
					    
					    <script>
					    $(function(){
					    	  $(".add-image").on('click', function(){
					    	    var ele = $(this).closest('.multiplValueFields').clone(true);
					    	    $(this).closest('.multiplValueFields').after(ele);
					    	    $(this).remove();
					    	  })
					    	})
					    </script>
				  	</div>
				  	<div class="form-group multiplValueFields">
						<div class="input-group newEventMutators">
							<span class='input-group-addon icons'><i class='fa fa-exclamation'></i></span>
							<input type='text' class='form-control modalFields' name='mutator' placeholder='Mutator' />
							<div class="valid-feedback">Looks good!</div>
						</div>
						<input type="button" value="Add another mutator" class="add-mutator" />
						
						
					    <script>
					    $(function(){
					    	  $(".add-mutator").on('click', function(){
					    	    var ele = $(this).closest('.multiplValueFields').clone(true);
					    	    $(this).closest('.multiplValueFields').after(ele);
					    	    $(this).remove();
					    	  })
					    	})
					    </script>
					</div>
					
			  		<div class="row">
				  		<div class="form-group eventDates col-sm-6">
			    	  		<input class="input-group form-control datePicker" id="startDate" name="startDate" placeholder="MM/DD/YYY" type="text" required/>
						    <script>
							    $(document).ready(function(){
							      var date_input=$('input[name="date1"]'); //our date input has the name "date"
							      var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
							      var options={
							        format: 'mm/dd/yyyy',
							        container: container,
							        todayHighlight: true,
							        autoclose: true,
							      };
							      date_input.datepicker(options);
							    })
							</script>
				  		</div>
				  		<div class="form-group eventDates col-sm-6">
			    	  		<input class="input-group form-control datePicker" id="endDate" name="endDate" placeholder="MM/DD/YYY" type="text" required/>
						    <script>
							    $(document).ready(function(){
							      var date_input=$('input[name="date2"]'); //our date input has the name "date"
							      var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
							      var options={
							        format: 'mm/dd/yyyy',
							        container: container,
							        todayHighlight: true,
							        autoclose: true,
							      };
							      date_input.datepicker(options);
							    })
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