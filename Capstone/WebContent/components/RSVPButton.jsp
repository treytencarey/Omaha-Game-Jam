<!-- Step 1. RSVP button -->
<form id="RSVPForm" style="display: none;">
	<input type="text" name="RSVPButton">
  	<input type="submit" class="btn btn-primary" value="RSVP" id="RSVPFormSubmit">
</form>
<button type="button" class="btn btn-primary" onclick="$('#RSVPFormSubmit').click();">RSVP</button>
<!-- Step 3. Once toast values are updated (from step 2), submit toast request. Update footer toast div with new values using AJAX. -->
<form id="RSVPToast" style="display: none;"><input type="text" id="RSVPToastTitle" name="RSVPToastTitle"><input type="text" id="RSVPToastMessage" name="RSVPToastMessage"><input type="submit" id="RSVPToastSubmit"></form>
<% session.setAttribute("servlet", "toastServlet"); %>
<% session.setAttribute("form", "#RSVPToast"); %>
<% session.setAttribute("successJS", "$('#toastDiv').html(data);"); %>
<%@include file="/components/ajax.jsp" %>
<!-- Step 2. Once the RSVP button is clicked, submit AJAX. Update toast values, then submit toast request -->
<% session.setAttribute("servlet", "EventServlet"); %>
<% session.setAttribute("form", "#RSVPForm"); %>
<% String RSVPToast = "$('#RSVPToastSubmit').click();"; %>
<% session.setAttribute("successJS", "$('#RSVPToastTitle').val('Success!'); $('#RSVPToastMessage').val(data); " + RSVPToast); %>
<% session.setAttribute("errorJS", "$('#RSVPToastTitle').val('Error RSVP\\'ing.'); $('#RSVPToastMessage').val(request.responseText); " + RSVPToast); %>
<%@include file="/components/ajax.jsp" %>