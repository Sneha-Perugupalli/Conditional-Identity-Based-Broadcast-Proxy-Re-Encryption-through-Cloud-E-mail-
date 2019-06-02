
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pack.DbConnector"%>
<%
	String d = request.getQueryString();
	Connection connn = DbConnector.getConnection();
	Statement st = connn.createStatement();
	int i = st
			.executeUpdate("delete from request where id='" + d + "'");
	if (i != 0) {
		response.sendRedirect("adminpage.jsp?que=query executed..!");
	} else {
		response.sendRedirect("adminpage.jsp?que=query not executed..!");
	}
%>
