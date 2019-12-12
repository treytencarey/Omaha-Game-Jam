<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
<style>
.modal-body {
    position: relative;
    overflow-y: auto;
    padding: 15px;
}
</style>
<div id="newEventModal" class="modal fade">
	<div class="modal-dialog modal-md modal-login newMods">
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
							<div class="invalid-feedback">Please enter a valid event title</div>
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
							<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" placeholder="Description"></textarea>
						</div>
					</div>
					
					<div class="input-group">
						<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						<input type="file" style="width: unset; opacity: 1; margin-left: 10px;" class="custom-file-input" name="eventImage" id="eventImage" required/>
						<div class="invalid-feedback">Please upload a valid image</div>
						<div class="valid-feedback">Looks good!</div>
					</div>
					
				  	<div class="input-group items" style="display: inline-block;">
				  		<div class="row">
				  			<div class="col-sm-1">
				  				<span style="margin-left: 5px;" class="input-group-addon icons"><i class="fa fa-flask"></i></span>
				  			</div>
				  			<div class="col-sm-11">
				  				<div class="mutatorFields">
						
							    </div>
								<button style="width: 100%; margin: auto;" type="button" class="add_field_button">Add Mutator</button>
				  			</div>
				  		</div>
					</div>
					
					<br><br>
				    <h3>Event Schedule</h3>
				    <div class="form-group">
						<div class="input-group">
							<textarea class="form-control modalFields" id="eventSchedule" name="eventSchedule" placeholder="Schedule"></textarea>
						</div>
					</div>
					
			  		<div class="row">
				  		<div class="form-group eventDates col-sm-6">
			    	  		<input class="input-group form-control datePicker" id="startDate" name="startDate" placeholder="MM/DD/YYY" type="text" required/>
				  		</div>
				  		<div class="form-group eventDates col-sm-6">
			    	  		<input class="input-group form-control datePicker" id="endDate" name="endDate" placeholder="MM/DD/YYY" type="text" required/>
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
var eventBodyField;
var scheduleBodyField;
loadEditor();

function loadEditor() { 
	eventBodyField = new nicEditor({fullPanel: true}).panelInstance("eventDescription");
	scheduleBodyField = new nicEditor({fullPanel: true}).panelInstance("eventSchedule");
	$("eventDescription").width("100%");
	$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
}

$(document).ready(function() {
	var max_fields = 20; //maximum input boxes allowed
	var wrapper = $(".mutatorFields"); //Fields wrapper
	var add_button = $(".add_field_button"); //Add button ID
	 
	var x = 1; //initlal text box count
	$(add_button).click(function(e){ //on add input button click
    	e.preventDefault();
    	if(x < max_fields){ //max input box allowed
	    	x++; //text box increment
	    	$(wrapper).append(
		    	'<div class="form-group">' +
		    		'<div class="row">' +
		    			'<div class="col-sm-6" style="padding-bottom: 0px;">' +
		    				"<input type='text' class='form-control modalFields' name='mutator' placeholder='Mutator' required/>" +
	    				'</div>' +
	    				'<div class="col-sm-6" style="padding-bottom: 0px;">' +
							"<input type='text' class='form-control modalFields' name='mutatorDescription' placeholder='Description' required/>" +
						'</div>' +
					'</div>' +
		    		'<a href="#" class="remove_field" style="color: red; margin-left: 10px;">Remove Mutator</a>' +
	    		'</div>'
	    	); //add input box
    	}
	});
	 
	$(wrapper).on("click",".remove_field", function(e){ //user click on remove field
		e.preventDefault(); $(this).parent('div').remove(); x--;
	})
	});
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
  
$('.modal').on('show.bs.modal', function () {
    $(this).find('.modal-body').css({
           width:'auto', //probably not needed
           height:'auto', //probably not needed 
           'max-height':'100%'
    });
});

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