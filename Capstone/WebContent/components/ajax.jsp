<% 	if ( session.getAttribute("servlet") != null &&
		 session.getAttribute("form") != null	) { %>
		 <%@page import="java.util.List" %>
		<script>
			var $form = $("<%= session.getAttribute("form") %>");
			$form.submit(function(e) {
				e.preventDefault();
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
	session.setAttribute("servlet", null);
	session.setAttribute("form", null);
	session.setAttribute("updates", null);
	session.setAttribute("successJS", null);
	session.setAttribute("errorJS", null);
	session.setAttribute("multipart",null);
%>