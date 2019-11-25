<%@page import="java.util.Map" %>
<%@page import="database.Database" %>
<div id="newGameModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Add New Game</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" id="gameUpload">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control modalFields" name="title" placeholder="Title" required>
							<div class="invalid-feedback">Please enter a valid game title</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control modalFields" name="description" placeholder="Description" required></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <% session.setAttribute("uploadFilePath", "Uploads/temp/gamesub_0" + session.getAttribute("accountPKey")); %>
                          	<% session.setAttribute("uploadInputOnly", true); %>
                          	<% session.setAttribute("uploadInputID", "validatedCustomFile1"); %>
                          	<% session.setAttribute("uploadInputAttributes", "class='custom-file-input' required"); %>
                            <%@include file="../components/upload.jsp" %>
							<label class="form-control modalFields custom-file-label" for="validatedCustomFile1">Choose Icon...</label>
						    <div class="invalid-feedback">Please upload a valid icon</div>
					    </div>
				  	</div>


					<!--
					Need to add a for loop here to loop through all the available mutators for the current event!
					Waiting on backend to complete that before adding to frontend!
					 -->
					<fieldset class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-exclamation"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Mutators</legend>
					      	<div class="col-sm-8 checkForms">
					      		<% 	int v = 0;
					      			for (Map<String, Object> mutator : Database.executeQuery("SELECT Title, PKey FROM Mutators WHERE EventPKey=(SELECT EventPKey FROM ActiveEvent LIMIT 1)")) { %>
								        <div class="form-check">
							          		<input class="form-check-input" type="checkbox" id="mutatorCheck<%= v %>" name="mutatorCheck<%= v %>" value="<%= mutator.get("PKey") %>">
							        		<label class="form-check-label" for="mutatorCheck<%= v %>">
								          		<%= mutator.get("Title") %>
							        		</label>
							        	</div>
							    <% 		v++;
							    	} %>
					      	</div>
					    </div>
				    </fieldset>

					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <% session.setAttribute("uploadFilePath", "Uploads/temp/gamesub_1" + session.getAttribute("accountPKey")); %>
                          	<% session.setAttribute("uploadInputOnly", true); %>
                          	<% session.setAttribute("uploadInputID", "validatedCustomFile2"); %>
                          	<% session.setAttribute("uploadInputAttributes", "class='custom-file-input' required multiple"); %>
                            <%@include file="../components/upload.jsp" %>
						    <label class="form-control modalFields custom-file-label" for="validatedCustomFile2">Choose Screenshot(s)...</label>
						    <div class="invalid-feedback">Please upload a valid screenshot(s)</div>
					    </div>
				  	</div>

				  	<fieldset class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-apple"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">System(s)</legend>
						    <div class="col-sm-8 checkForms">
						    	<%	int n = 0;
						    		for (Map<String, Object> platform : Database.executeQuery("SELECT Name, PKey FROM Platforms")) { %>
									    <div class="form-check form-check-inline">
										  	<input class="form-check-input" type="checkbox" id="platformCheck<%= n %>" name="platformCheck<%= n %>" value="<%= platform.get("PKey") %>">
										  	<label class="form-check-label" for="platformCheck<%= n %>"><%= platform.get("Name") %></label>
										</div>
								<%		n++;
									} %>
							</div>
			  			</div>
		  			</fieldset>

				  	<div class="form-group">
				  		<div class="input-group">
						    <span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Tools</legend>
					      	<input type="text" name="tools" value="" style="display: none;">
						    <select multiple class="form-control modalFields" id="toolsSelect" name="toolsSelect" required>
						    	<%	int y = 0;
									for (Map<String, Object> tool : Database.executeQuery("SELECT Name, PKey FROM Tools")) { %>
										<option value="<%= tool.get("PKey") %>"><%= tool.get("Name") %></option>
								<%		y++;
									} %>
					    	</select>
				    	</div>
				  	</div>
				  	<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-wrench"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">Credits</legend>
					      	<div class="col-sm-8">
								<!-- <input type="text" class="form-control creditField" name="credit" placeholder="Name"> -->
							</div>
						</div>
					</div>

					<div class="form-group">
						<button type="submit" name="newGameButton" class="btn btn-primary btn-block btn-lg">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<form id="gameSubmit" style="display: none;" action="<%= request.getContextPath() %>/gameServlet" method="post"><input name="gameSubmitAfterFiles"/><button id="gameSubmitButton"></button></form>
<% session.setAttribute("servlet", "filesServlet"); %>
<% session.setAttribute("form", "#gameUpload"); %>
<% session.setAttribute("beforeSubmitJS", "" +
	"var v = ''; " +
	"$('#toolsSelect > :selected').each(function() { " +
	"	v += $(this).val() + ','; " +
	"}); " +
	"document.getElementsByName('tools')[0].value = v;"); %>
<% session.setAttribute("successJS", "$('#gameSubmitButton').click();"); %>
<% session.setAttribute("multipart", true); %>
<%@include file="../components/ajax.jsp" %>