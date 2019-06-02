<%@page import="java.sql.Statement"%>
<%@page import="pack.DbConnector"%>
<%@page import="java.sql.Connection"%>
<%
	//file, name, key_, title, keyword, cat

	String sk = request.getParameter("key");
	String ti = request.getParameter("tit");
	String key = request.getParameter("keyword");
	String cat = request.getParameter("cat");

	Connection con = DbConnector.getConnection();
	Statement st = con.createStatement();
	int i = st.executeUpdate("update files set title ='" + ti
			+ "',keyword ='" + key + "', cat='" + cat
			+ "' where key_ = '" + sk + "' ");

	if (i != 0) {
		response.sendRedirect("adminpage.jsp?Updated sucess..!");
	} else {
		response.sendRedirect("adminpage.jsp?Updated fails..!");
	}
%>