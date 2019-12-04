<%@page import="java.util.Map" %>
<%@page import="database.Database" %>
<%@page import="database.Game" %>
<%@page import="beans.EventTableBean" %>
<% 
Game game = null;
if (request.getParameter("id") != null)
	game = new Game(Integer.parseInt(request.getParameter("id").toString()));
%>
<div id="newGameModal" class="modal fade">
	<div class="modal-dialog modal-login newMods">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"><%= game == null ? "Add New Game" : "Edit Game" %></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form class="was-validated" id="gameUpload">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-gamepad"></i></span>
							<input type="text" class="form-control modalFields" name="title" placeholder="Title" value="<%= game != null ? game.getTitle() : "" %>" required>
							<div class="invalid-feedback">Please enter a valid game title</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-comment"></i></span>
							<textarea class="form-control modalFields" name="description" placeholder="Description" required><%= game != null ? game.getDesc() : "" %></textarea>
							<div class="invalid-feedback">Please enter a valid description</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-link"></i></span>
							<input type="url" class="form-control modalFields" name="title" placeholder="Link" value="<%= game != null ? game.getLink() : "" %>" required>
							<div class="invalid-feedback">Please enter a valid URL</div>
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-upload"></i></span>
						    <% session.setAttribute("uploadFilePath", "Uploads/temp/gamesub_0" + session.getAttribute("accountPKey")); %>
                          	<% session.setAttribute("uploadInputOnly", true); %>
                          	<% session.setAttribute("uploadInputID", "validatedCustomFile1"); %>
                          	<% session.setAttribute("uploadInputAttributes", "class='custom-file-input' " + (game != null ? "" : "required")); %>
                            <%@include file="../components/upload.jsp" %>
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
					      			for (Map<String, Object> mutator : Database.executeQuery("SELECT m.Title, m.PKey" + (game != null ? ", (SELECT CASE WHEN m.PKey IN (SELECT MutatorPKey FROM GameMutators WHERE GamePKey=" + game.getId().toString() + ") THEN 'checked' ELSE '' END) AS Checked" : "") + " FROM Mutators m WHERE m.EventPKey=" + String.valueOf(new EventTableBean().getCurrentEvent().getKey()))) { %>
								        <div class="form-check">
							          		<input class="form-check-input" type="checkbox" id="mutatorCheck<%= v %>" name="mutatorCheck<%= v %>" value="<%= mutator.get("PKey") %>" <%= game != null ? mutator.get("Checked") : "" %>>
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
                          	<% session.setAttribute("uploadInputAttributes", "class='custom-file-input' multiple " + (game != null ? "" : "required")); %>
                            <%@include file="../components/upload.jsp" %>
						    <div class="invalid-feedback">Please upload a valid screenshot(s)</div>
					    </div>
				  	</div>

				  	<fieldset class="form-group">
						<div class="input-group">
							<span class="input-group-addon icons"><i class="fa fa-apple"></i></span>
					      	<legend class="col-form-label col-sm-2 pt-0 checkLabel">System(s)</legend>
						    <div class="col-sm-8 checkForms">
						    	<%	int n = 0;
						    		for (Map<String, Object> platform : Database.executeQuery("SELECT p.Name, p.PKey" + (game != null ? ", (SELECT CASE WHEN p.PKey in (SELECT PlatformPKey FROM GamePlatforms WHERE GamePKey=" + game.getId().toString() + ") THEN 'checked' ELSE '' END) AS Checked" : "") + " FROM Platforms p")) { %>
									    <div class="form-check form-check-inline">
										  	<input class="form-check-input" type="checkbox" id="platformCheck<%= n %>" name="platformCheck<%= n %>" value="<%= platform.get("PKey") %>" <%= game != null ? platform.get("Checked") : "" %>>
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
									for (Map<String, Object> tool : Database.executeQuery("SELECT t.Name, t.PKey" + (game != null ? ", (SELECT CASE WHEN t.PKey in (SELECT ToolPKey FROM GameTools WHERE GamePKey=" + game.getId().toString() + ") THEN 'selected' ELSE '' END) AS Selected" : "") + " FROM Tools t")) { %>
										<option value="<%= tool.get("PKey") %>" <%= game != null ? tool.get("Selected") : "" %>><%= tool.get("Name") %></option>
								<%		y++;
									} %>
					    	</select>
				    	</div>
				  	</div>
					<div class="input-group items" style="display: inline-block;">
				  		<div class="row">
				  			<div class="col-sm-1">
				  				<span style="margin-left: 5px;" class="input-group-addon icons"><i class="fa fa-user"></i></span>
				  			</div>
				  			<div class="col-sm-11">
				  				<div class="authorFields">
						
							    </div>
								<button style="width: 100%; margin: auto; margin-top: 8px; margin-bottom: 30px;" type="button" class="add_author_button">Add Author</button>								
								
							    <script>
							    $(document).ready(function() {
							    	var max_fields = 20; //maximum input boxes allowed
							    	var wrapper = $(".authorFields"); //Fields wrapper
							    	var add_button = $(".add_author_button"); //Add button ID
							    	 
							    	var x = 1; //initlal text box count
							    	$(add_button).click(function(e){ //on add input button click
								    	e.preventDefault();
								    	if(x < max_fields){ //max input box allowed
									    	x++; //text box increment
									    	$(wrapper).append(
										    	'<div class="form-group">' +
										    		'<div class="row">' +
										    			'<div class="col-sm-6" style="padding-bottom: 0px;">' +
										    				"<input type='text' class='form-control modalFields' name='author' placeholder='Author' required/>" +
									    				'</div>' +
									    				'<div class="col-sm-6" style="padding-bottom: 0px;">' +
															"<input type='text' class='form-control modalFields' name='authorRole' placeholder='Role' required/>" +
														'</div>' +
													'</div>' +
										    		'<a href="#" class="remove_field" style="color: red; margin-left: 10px;">Remove Author</a>' +
									    		'</div>'
									    	); //add input box
								    	}
							    	});
							    	 
							    	$(wrapper).on("click",".remove_field", function(e){ //user click on remove field
							    		e.preventDefault(); $(this).parent('div').remove(); x--;
							    	})
							    	});
							    
							    </script>
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
<form id="gameSubmit" style="display: none;" action="<%= request.getContextPath() %>/gameServlet" method="post"><input name="gameSubmitAfterFiles"/><% if (game != null) { %><input name="PKey" value="<%= game.getId() %>"> <% } %><button id="gameSubmitButton"></button></form>
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