<%@page import="pack.mail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pack.DbConnector"%>
<%
	
	String key = request.getParameter("r");
	
	String user = request.getParameter("k");
	
	String filename = request.getParameter("t");
	
	String mails = null;
	
	Connection con = DbConnector.getConnection();
	Statement st = con.createStatement();
	Statement st1 = con.createStatement();
	
	ResultSet rs = st1.executeQuery("select * from regpage where userid='" + user+ "'");
	
	if (rs.next()) {
		
		mails = rs.getString("mail");
		
		mail.mailsend(key, mails, filename);
		
		response.sendRedirect("adminpage.jsp?mail=public key send sucess..!");
	
	} else {
	
		response.sendRedirect("adminpage.jsp?mailf=public key send fails..!");
	}
	
%>