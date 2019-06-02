<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DbConnector"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String cloudip = request.getParameter("cloudip");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection con = DbConnector.getConnection();
		Statement st = con.createStatement();
		
		con.createStatement().executeUpdate("insert into clouddetails values(null,'"+cloudip+"','"+username+"','"+password+"')");
		
		response.sendRedirect("adminhome.jsp?");
		
		
	%>
</body>
</html>