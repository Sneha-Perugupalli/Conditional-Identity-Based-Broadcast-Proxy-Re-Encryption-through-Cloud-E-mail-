<!DOCTYPE HTML>
<%@page import="pack.DbConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>

<head>
<title>Conditional-Identity</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css" href="style/style.css" />

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div id="logo_text">
					<br /> <br /> <font size="5"><a href="index.html"><span
							class="logo_colour">Conditional Identity-Based Broadcast Proxy Re-Encryption and Its Application to Cloud Email
								</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">

					<li class="selected"><a href="adminpage.jsp">Home</a></li>
					<li><a href="view.jsp">View Data Details</a></li>
					<li><a href="viewreq.jsp">View User Request</a></li>
					<li><a href="attackresults.jsp">View Attacker Info</a></li>
					<li><a href="logout.jsp">Logout</a></li>

				</ul>
			</div>
		</div>
		<div id="content_header"></div>
		<div id="site_content">
			<div id="sidebar_container">
				<br /> <br /> <br /> <br />
				<div class="sidebar">
					<div class="sidebar_top"></div>
					<div class="sidebar_item">
						<h3>Useful Links</h3>
						<ul>
							<li ><a  href="adminpage.jsp">Home</a></li>
							<li ><a  href="view.jsp">View Data Details</a></li>
							<li ><a  href="viewreq.jsp">View User Request</a></li>
							<li ><a  href="attackresults.jsp">View Attacker Info</a></li>
							<li ><a  href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				
				<br/><br/><br/><br/>
				
				<table style="width: 100%; border-spacing: 0;">
					<tr>
						<th>User ID</th>
						<th>Attack Count</th>
						<th>Status</th>
						<th>DeActivate</th>
					</tr>
					
					<%
						String userType="user";
							
						Connection con=DbConnector.getConnection();
						ResultSet rs=con.createStatement().executeQuery("select * from attacker where usertype='"+userType+"'");
							
						while(rs.next())
						{
					%>
						<tr>
							<td><%=rs.getString("userid")%></td>
							<td><%=rs.getString("count")%></td>
							<td><%=rs.getString("status")%></td>
							<td><a href="attackresults.jsp?userid=<%=rs.getString("userid")%>">De-Activate</a></td>
						</tr>	
					<%		
						}
					%>
				</table>	
				
				<%
					String userID=request.getParameter("userid");
					
					String status="disable";
					
					if(userID!=null)
					{
						con.createStatement().executeUpdate("update attacker set status='"+status+"' where userid='"+userID+"'");
					}
				%>			
			</div>
		</div>
		<br /> <br /> <br /> <br />
		<div id="content_footer"></div>
		<div id="footer">
			<p></p>
		</div>
	</div>
</body>
</html>
