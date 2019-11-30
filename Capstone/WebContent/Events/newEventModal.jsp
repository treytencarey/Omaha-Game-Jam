<div id="newEventModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Create New Event</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" autocomplete="off" action="<%= request.getContextPath() %>/EventServlet" method="post" enctype="multipart/form-data" onsubmit="return datecheck();" >
					<input type="hidden" name="hidden" type="text" style="display:none;" />
					
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
					
					<div class="input-group">
						<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						<input type="file" class="custom-file-input" name="eventImage" id="eventImage" required/>
						<label class="form-control modalFields custom-file-label" for="eventImage">Choose Image</label>
						<div class="invalid-feedback">Please upload a valid image</div>
						<div class="valid-feedback">Looks good!</div>
					</div>
					
				  	<div class="form-group multiplValueFields">
						<div class="input-group newEventMutators">
							<span class='input-group-addon icons'><i class='fa fa-exclamation'></i></span>
							<input type='text' class='form-control modalFields' name='mutator' placeholder='Mutator' />
							<input type='text' class='form-control modalFields' name='mutatorDescription' placeholder='Mutator Description' />
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
					    
					    /*$(function(){
					    	  $(".add-mutator").on('click', function(){
					    	    var ele = $(this).closest('.multiplValueFields').clone(true);
					    	    $(this).closest('.multiplValueFields').after(ele);
					    	    $(this).remove();
					    	  })
					    	})
					    */
					    </script>
					</div>
					
			  		<div class="row">
				  		<div class="form-group eventDates col-sm-6">
			    	  		<input class="input-group form-control datePicker" id="startDate" name="startDate" placeholder="MM/DD/YYY" type="text" required/>
						    <script>
							    $(document).ready(function(){
							      var date_input=$('input[name="startDate"]'); //our date input has the name "date"
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
							      var date_input=$('input[name="endDate"]'); //our date input has the name "date"
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
<script>
console.log(new Date());
function datecheck(){
	var sd = document.getElementById('startDate').value;
	var ed = document.getElementById('endDate').value;
	
	var sdparts = sd.split('/');
	var edparts = ed.split('/');
	
	const st = new Date(sdparts[2],sdparts[0],sdparts[1]);
	const et = new Date(edparts[2],edparts[0],edparts[1]);
	if(st < et){
		return true;
	}
	else{
		alert("End date must come after start date.");
		return false;
	}	
}
</script>