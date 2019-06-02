
<%
	request.getSession().invalidate();
	
	response.sendRedirect("index.html");
	
%>