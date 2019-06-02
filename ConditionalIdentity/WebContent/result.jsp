<%@page import="java.io.File"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pack.DbConnector"%>

<%
		String r = request.getParameter("key").trim();

		Connection conn = DbConnector.getConnection();
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("select * from files where key_='"
									+ r + "'");
							
		if(rs.next()) {
								
			String f = rs.getString("name");
			
			response.sendRedirect("userdwnld?file="+f);
		}
		else
		{
			String userID=(String)request.getSession().getAttribute("me");
			
			conn.createStatement().executeUpdate("update attacker set count=count+1 where userid='"+userID+"'");
			
			response.sendRedirect("userpage.jsp?status=invalidkey");
			
		}
							
%>