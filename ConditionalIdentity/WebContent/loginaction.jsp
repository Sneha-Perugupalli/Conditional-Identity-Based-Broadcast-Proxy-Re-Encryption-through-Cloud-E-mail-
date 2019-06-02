<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="pack.DbConnector"%>
<%@page import="java.sql.Connection"%>
<%
	String usr = request.getParameter("user");
	String pas = request.getParameter("pass");

	Connection con = DbConnector.getConnection();
	Statement st = con.createStatement();
	
	String utype=null;
	
	ResultSet rs = st
			.executeQuery(" select utype from regpage where userid='" + usr
					+ "' and pass='"+pas+"'");
	while(rs.next()) {
		
		utype=rs.getString("utype");
		
	} 
	
	if(usr.equals("admin") && pas.equals("admin"))
	{
		response.sendRedirect("adminhome.jsp");
	}
	else
	{
		ResultSet rs1=con.createStatement().executeQuery("select status from attacker where userid='"+usr+"'");
		
		String status=null;
		
		while(rs1.next())
		{
			status=rs1.getString("status");
		}
		
		if(status!=null)
		{
			if(status.equals("active"))
			{
				if(utype!=null)
				{
					request.getSession().setAttribute("me",usr);
					 
					if(utype.equals("owner"))
					{
						response.sendRedirect("adminpage.jsp");
					}
					else
					{
						response.sendRedirect("userpage.jsp");
					}
				}
				else {
					response.sendRedirect("userlog.jsp?msgg=fails");
				}
			}
			else
			{
				response.sendRedirect("userlog.jsp?msgg=account is blocked");
			}
		}
		else
		{
			response.sendRedirect("userlog.jsp?msgg=invalid user");
		}
	}
%>