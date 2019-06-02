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

<script>
	function check() {
		var a = document.f.k.value;
		if (a == 0) {
			alert('Please Enter The Key..!');
			return false;
			document.getElementById("k").focus();
		}
	}
</script>


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

					<li class="selected"><a href="userpage.jsp">Home</a></li>
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
							<li><a href="userpage.jsp">Home</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				<div class="form_settings">
					<br /> <br /> <br />

					<%
						String my = session.getAttribute("me").toString();

						if (request.getParameter("dwn") != null) {
					%>
					<h3>Success fully download</h3>
					<%
						} else {
					%>
					<h3>
						Welcome to
						<%=my%></h3>
					<%
						}
					%>


					<%
						int i = 1;
						String f = null;
						String r = null;

						String key = request.getParameter("key");
						String owner = request.getParameter("owner");

						Connection conn = DbConnector.getConnection();
						Statement st1 = conn.createStatement();
						Statement st2 = conn.createStatement();
						Statement st3 = conn.createStatement();

						ResultSet rst = st1
								.executeQuery("select * from files where key_ = '" + key
										+ "'");

						if (rst.next()) {
							r = rst.getString("rank_");
							f = rst.getString("name");
							System.out.println("Present rank is" + r);
						}

						int rr = Integer.parseInt(r);

						int a = i + rr;

						String finala = a + "";

						int up = st2.executeUpdate("update files set rank_ ='" + finala
								+ "' where key_ = '" + key + "'");

						int isExist = 0;

						ResultSet myrs = conn.createStatement().executeQuery(
								"select count(*) from request where name='" + key
										+ "' and user='" + my + "' and filename='" + f
										+ "' and owner='" + owner + "'");

						while (myrs.next()) {
							isExist = myrs.getInt(1);
						}

						if (isExist == 0) {
							int req = st3
									.executeUpdate("insert into request(name,user,filename,owner)values('"
											+ key
											+ "','"
											+ my
											+ "','"
											+ f
											+ "','"
											+ owner
											+ "')");
						}
					%>

					<form name="f" action="result.jsp" method="get"
						onsubmit="return check()">

						<p>
							<span>File Name : </span><input class="contact" type="text"
								value="<%=f%>" readonly="readonly" />
						</p>
						<br />
						<p>
							<span>Enter Key</span><input class="contact" type="text"
								name="key" id="k" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="submit" />
						</p>

					</form>

				</div>
			</div>
		</div>
		<br /> <br /> <br /> <br /> <br />
		<div id="content_footer"></div>
		<div id="footer">
			<p></p>
		</div>
	</div>
</body>
</html>
