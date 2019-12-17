<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/style.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/subNavStyle.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Styles/eventStyle.css">
</head>
<body>
<%@page import="beans.Event" %>
<%@page import="database.Mutator" %>
<%
	Event display = (Event)request.getAttribute("event");
%>
<%@include  file="/Common/navbar.jsp" %>

<!-- Display Event -->

<div class="container eventContainer rainbowBorder">
		<div id="current-event" class="event">
			<img src="<%=request.getContextPath()%>/Uploads/Events/HeaderImages/<%=display.getKey()%>_header.png" class="rounded" style="max-width: 100%; max-height: 100%;"/>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
					<h1 class="currentEventHeader">Event</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Title:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%=display.getTitle()%></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Theme:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%=display.getTheme()%></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">Description:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;"><%=display.getDescription()%></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<h3 style="float: right;">When:</h3>
				</div>
				<div class="col-sm-9">
					<h3 style="font-weight: 300;">From <%=display.getStartDate()%> to <%=display.getEndDate()%></h3>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-9">
					<button type="button" id="rsvp-button" class="btn btn-info">RSVP</button>
					<button type="button" id="event-schedule-button" class="btn btn-warning">Event Schedule</button>
					<a href=""><i class="fab fa-discord fa-3x" style="color: #7289da;"></i></a>
				</div>
			</div>
			<div class="row rounded" id="event-schedule-description" style="margin: auto; padding: auto; display:none;">
				<h6><%= display.getSchedule() %></h6>
			</div>
		</div>
	</div>
</div>

<div class="container eventContainer">
	<form class="was-validated" autocomplete="off" action="<%= request.getContextPath() %>/EventServlet" method="post" enctype="multipart/form-data" onsubmit="return datecheck();" >
		<input autocomplete="false" type="hidden" type="text" style="display:none;" />
		<input type="hidden" id="toDelete" name="toDelete" value="no"></input>
		
		<input type="hidden" value="<%=display.getKey()%>" name="PKey" />
		
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
				<input type="text" class="form-control modalFields" name="title" value="<%=display.getTitle()%>" required>
				<div class="invalid-feedback">Please enter a valid event title</div>
				<div class="valid-feedback">Looks good!</div>
			</div>
		</div>
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
				<input type="text" class="form-control modalFields" name="theme" value="<%=display.getTheme()%>" required>
				<div class="invalid-feedback">Please enter a valid event theme</div>
				<div class="valid-feedback">Looks good!</div>
			</div>
		</div>
		 <h3>Event Description</h3>
		<div class="form-group">
			<div class="input-group">
				<textarea class="form-control modalFields" id="eventDescription" name="eventDescription"><%=display.getDescription()%></textarea>
			</div>
		</div>
		
		<div class="input-group">
			<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
			<input type="file" style="width: unset; opacity: 1; margin-left: 10px;" class="custom-file-input" name="eventImage" id="eventImage" />
		</div>
		
	  	<div class="input-group items" style="display: inline-block;">
	  		<div class="row" style="width: 100%;">
	  			<div class="col-sm-1" style="max-width: 30px;">
	  				<span style="margin-left: 5px;" class="input-group-addon icons"><i class="fa fa-flask"></i></span>
	  			</div>
	  			<div class="col-sm-11">
	  				<div class="mutatorFields">
					<%
						if(!display.getMutators().isEmpty()){
								for(Mutator mutator : display.getMutators()){
					%>
						<div class="form-group">
				    		<div class="row">
				    			<div class="col-sm-6" style="padding-bottom: 0px;">
				    				<input type='text' class='form-control modalFields' name='mutator' value='<%= mutator.getTitle() %>' required/>
			    				</div>
			    				<div class="col-sm-6" style="padding-bottom: 0px;">
									<input type='text' class='form-control modalFields' name='mutatorDescription' value='<%= mutator.getDesc() %>' required/>
								</div>
							</div>
				    		<a href="#" class="remove_field" style="color: red; margin-left: 10px;">Remove Mutator</a>
			    		</div>
			    		<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
							<input type="file" style="width: unset; opacity: 1; margin-left: 10px;" class="custom-file-input" name="eventImage" id="eventImage" />
						</div>
					<%
						}
					}
					%>
			    </div>
				<button style="width: 100%; margin: auto;" type="button" class="add_field_button">Add Mutator</button>

			    <br><br>
			    <h3>Event Schedule</h3>
			    <div class="form-group">
					<div class="input-group">
						<textarea class="form-control modalFields" id="eventSchedule" name="eventSchedule" placeholder="Schedule"><%=display.getSchedule()%></textarea>
					</div>
				</div>
			    
	  			</div>
	  		</div>
		</div>
		<div class="input-group items" style="display: inline-block;">
	  		<div class="row" style="width: 100%;">
	  			<div class="col-sm-1" style="max-width: 30px;"></div>
		  		<div class="form-group eventDates col-sm-5">
	    	  		<input class="input-group form-control datePicker" id="startDate" name="startDate" value="<%=display.getStartDate()%>" type="text" required/>
		  		</div>
		  		
		  		<div class="form-group eventDates col-sm-5">
	    	  		<input class="input-group form-control datePicker" id="endDate" name="endDate" value="<%=display.getEndDate()%>" type="text" required/>
				    <script>
				    
					    
					</script>
		  		</div>
		    </div>
	    </div>
	    
	    <div class="input-group items" style="display: inline-block;">
		    <div class="row" style="width: 100%;">
			    <div class="col-sm-1" style="max-width: 30px;"></div>
			    <div class="form-group col-sm-6" style="margin-left: 10px;">
		    	  	Make Public: <input type="checkbox" id="visibility" name="visibility" <% if(display.IsPublic()) {%> checked <% } %> />
		    	</div>
	    	</div>
    	</div>
    	
		<div class="form-group">
			<button onclick="return checkChange()" class="btn btn-primary" id="submitEventButton">Submit Changes</button>
			<button onclick="return checkRemove();" class="btn btn-primary" id="deleteEventButton" style="background-color: red;">Delete Event</button>
		</div>
	</form>
</div>
	<script>
	
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
		    $("scheduleDescription").width("100%");
		}
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
		function checkRemove(){
			var remove = confirm("Are you sure you want to delete this event?");
			if(remove){
				document.getElementById('toDelete').value = "yes";
				return true;
			}
			else return false;
		}
		function checkChange(){
			var submit = confirm("Submit changes?");
			if(submit){
				return true;
			}
			else return false;
		}
		$(document).ready(function(){

			$("#event-schedule-button").click(function(){
				$("#event-schedule-description").toggle();
			});
		});
	</script>
	</body>
</html>