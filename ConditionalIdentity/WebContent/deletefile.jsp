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
							class="logo_colour">
								Conditional Identity-Based Broadcast Proxy Re-Encryption and Its Application to Cloud Email</a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">
				
					<li class="selected"><a  href="adminpage.jsp">Home</a></li>
					<li ><a  href="view.jsp">View Data Details</a></li>
					<li ><a  href="deletefile.jsp">delete files</a></li>
					<li ><a  href="logout.jsp">Logout</a></li>	
					
				</ul>			</div>
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
							<li><a href="adminpage.jsp">Home</a></li>
							<li><a href="view.jsp">View Data Details</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">

				<br /> <br /> <br /> <br />

				<%
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DbConnector.getConnection();
				%>
				<form action="deletefile.jsp">
					
					<center><select name="filename" style="width:50%">
						<%
							String userid = (String) request.getSession().getAttribute("me");
						
							ResultSet rs = conn.createStatement().executeQuery(
									"select * from  files where userid='"
											+ userid + "'");

							while (rs.next()) {
								String filename = rs.getString("name");
						%>
						<option value="<%=filename%>"><%=filename%></option>
						<%
							}
						%>
					</select></center><br/>

					<center><input type="submit" value="Delete" /></center>
					
				</form>
				
				<%
					String filename=request.getParameter("filename");
				
					if(filename!=null)
					{
						conn.createStatement().executeUpdate(
								"delete from userfiles where filename='"+filename+"'");	
						
						conn.createStatement().executeUpdate(
								"delete from files where name='"+filename+"'");
						
						response.sendRedirect("adminpage.jsp?status=success");
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
