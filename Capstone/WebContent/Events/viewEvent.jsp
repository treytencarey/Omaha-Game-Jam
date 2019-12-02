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
		</div>
	</div>
</div>

<form class="was-validated mw-50" autocomplete="off" action="<%=request.getContextPath()%>/EventServlet" method = "post" enctype="multipart/form-data" onsubmit="return datecheck();">
	<input autocomplete="false" type="hidden" type="text" style="display:none;" />
	<input type="hidden" id="toDelete" name="toDelete" value="no"></input>
	
	<input type="hidden" value="<%=display.getKey()%>" name="PKey" />
	
	<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
				<input type="text" class="form-control modalFields" name="title" value="<%=display.getTitle()%>" required>
				<div class="invalid-feedback">Please enter a valid event theme</div>
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
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
				<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" required><%=display.getDescription()%></textarea>
				<div class="invalid-feedback">Please enter a valid description</div>
				<div class="valid-feedback">Looks good!</div>
			</div>
		</div>
		
		<div class="input-group">
			<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
			<input type="file" class="custom-file-input" name="eventImage" id="eventImage" />
			<label class="form-control modalFields custom-file-label" for="eventImage">Choose Image</label>
		</div>
	  	
	  	<div class="input-group multiplValueFields items" style="display: inline-block;">
			<button type="button" class="add_field_button">Add Mutator</button>
				<%
					if(!display.getMutators().isEmpty()){
							for(Mutator mutator : display.getMutators()){
				%>
					<div class="form-group">
						<input type='text' class='form-control modalFields' name='mutator' value='<%= mutator.getTitle() %>' />
						<input type='text' class='form-control modalFields' name='mutatorDescription' value='<%= mutator.getDesc() %>' />
						<a href="#" class="remove_field"><i class="fa fa-times"></i></a>
					</div>
				<%
					}
				}
				%>
			
				<script>
					$(document).ready(function() {
						var max_fields = 20;
					    var wrapper = $(".items");
					    var add_button = $(".add_field_button");
					    	 
					    var x = 1; 
					    $(add_button).click(function(e){ 
						    e.preventDefault();
						    if(x < max_fields){ 
							    x++; 
							    $(wrapper).append(
								    '<div class="form-group">' +
								    	"<input type='text' class='form-control modalFields' name='mutator' placeholder='Mutator' />" +
										"<input type='text' class='form-control modalFields' name='mutatorDescription' placeholder='Mutator Description' />" +
								   		'<a href="#" class="remove_field"><i class="fa fa-times"></a></div>'
							    ); 
						    }
					    });
					    	 
					    $(wrapper).on("click",".remove_field", function(e){ //user click on remove field
					    e.preventDefault(); $(this).parent('div').remove(); x--;
					    })
				  });
					    
			 </script>
		</div>
			
  		<div class="row">
	  		<div class="form-group eventDates col-sm-6">
    	  		<input class="input-group form-control datePicker" id="startDate" name="startDate" value="<%= display.getStartDate() %>" type="text" required/>
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
    	  		<input class="input-group form-control datePicker" id="endDate" name="endDate" value="<%= display.getEndDate() %>" type="text" required/>
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
	     
	    <div class="form-group col-sm-6">
    	  	Make Public: <input type="checkbox" id="visibility" name="visibility" <% if(display.IsPublic()) {%> checked <% } %> />
    	</div>
    	
		<div class="form-group">
			<button onclick="return checkChange()" class="btn btn-primary">Submit Changes</button>
			<button onclick="return checkRemove();" class="btn btn-primary" id="deleteEventButton" style="background-color: red;">Delete Event</button>
		</div>
	</form>
	<script>
		var bodyField;
		loadEditor();
	
		function loadEditor() { 
			bodyField = new nicEditor({fullPanel: true}).panelInstance("eventDescription");
			$("eventDescription").width("100%");
			$('.nicEdit-panelContain').parent().css({width:'100%', padding:"0"});
		    $('.nicEdit-panelContain').parent().next().css({width:'100%', padding:"5px"});
		    $('.nicEdit-main').css({width:'100%', padding:"0", minHeight:"80px"});
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
			confirm("Submit changes?");
		}
	</script>
	</body>
</html>