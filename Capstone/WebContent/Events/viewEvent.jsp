<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script src="<%= request.getContextPath() %>/js/events.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/style.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/navStyle.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Styles/subNavStyle.css">

<%@page import="beans.Event" %>
<%
	Event display = (Event)request.getAttribute("event");
%>
<%@include  file="/Common/navbar.jsp" %>

<!-- Display Event -->
<div id="current-event">
	<h1 class="event-title"><b><%= display.getTitle() %></b></h1><br>
	<h3 class="event-theme"><%= display.getTheme() %></h3><br>
	<div id="event-description"><%= display.getDescription() %></div><br>
	<h5>From <%= display.getStartDate() %> to <%= display.getEndDate() %></h5>
</div>

<form class="was-validated" action="<%= request.getContextPath() %>/EventServlet" method = "post">
	<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
				<input type="text" class="form-control modalFields" name="title" value="<%= display.getTitle() %>" required>
				<div class="invalid-feedback">Please enter a valid event theme</div>
				<div class="valid-feedback">Looks good!</div>
			</div>
		</div>
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
				<input type="text" class="form-control modalFields" name="theme" value="<%= display.getTheme() %>" required>
				<div class="invalid-feedback">Please enter a valid event theme</div>
				<div class="valid-feedback">Looks good!</div>
			</div>
		</div>
		<div class="form-group">
			<div class="input-group">
				<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
				<textarea class="form-control modalFields" id="eventDescription" name="eventDescription" required><%= display.getDescription() %></textarea>
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
			<div class="form-group">
			<button type="submit" name="newEventButton" class="btn btn-primary btn-block btn-lg">Submit</button>
		</div>
	</form>