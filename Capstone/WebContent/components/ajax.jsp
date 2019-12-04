<% 	if ( session.getAttribute("servlet") != null &&
		 session.getAttribute("form") != null	) { %>
		 <%@page import="java.util.List" %>
		<script>
			var $form = $("<%= session.getAttribute("form") %>");
			$form.submit(function(e) {
				e.preventDefault();
				<% if (session.getAttribute("beforeSubmitJS") != null) { %>
					<%= session.getAttribute("beforeSubmitJS") %>
				<% } %>
				var params = {
					type: "POST",
					url: "${pageContext.request.contextPath}/<%= session.getAttribute("servlet") %>",
					<% if (session.getAttribute("multipart") != null) { %>
				        data: new FormData(this),
				        processData: false,
				        contentType: false,
				   	<% } else { %>
				   		data: $(this).serialize(),
				   	<% } %>
			        cache: false,
			        success: function (data){
			           <% if (session.getAttribute("updates") != null) {
			           	  	for (String update : (List<String>)session.getAttribute("updates")) { %>
		        	   			if ($('<%= update %>')[0].tagName == 'IMG') {
		        	   				$('<%= update %>')[0].src += '?_=' + new Date().getTime(); 
		        	   			} else {
		        	   				$('<%= update %>').replaceWith($('<%= update %>',data));
		        	   			}
		        	   <% 	}
			           	  } %>
			           	<% if (session.getAttribute("successJS") != null) { %>
							<%= session.getAttribute("successJS") %>
						<% } %>
		        	},
					error: function(request, status, error){
						<% if (session.getAttribute("errorJS") != null) { %>
							<%= session.getAttribute("errorJS") %>
						<% } %>
					}
				}
				$.ajax(params);
			});
		</script>
<% 	}
	session.removeAttribute("servlet");			// The servlet that is being triggered.
	session.removeAttribute("form");			// The form that is being submitted.
	session.removeAttribute("updates");			// (OPTIONAL) An Arrays.asList() of elements to update when the form is submitted.
	session.removeAttribute("beforeSubmitJS");	// (OPTIONAL) A String of JavaScript to run before the form is submitted.
	session.removeAttribute("successJS");		// (OPTIONAL) A String of JavaScript to run if the form submission is successful.
	session.removeAttribute("errorJS");			// (OPTIONAL) A String of JavaScript to run if the form submission is unsuccessful.
	session.removeAttribute("multipart");		// (OPTIONAL) The Ajax request should be sent as a multipart (for uploading files).
%>