<!DOCTYPE HTML>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Path"%>
<%@page import="pack.SimpleFTPClient"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
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
							class="logo_colour"> Conditional Identity-Based Broadcast
								Proxy Re-Encryption and Its Application to Cloud Email</a></font>
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
					<table style="width: 100%; border-spacing: 0;">
						<tr>
							
						</tr>
						<%
							String txt = request.getParameter("search");

							request.getSession().setAttribute("mykey", txt);

							String userid = (String) request.getSession().getAttribute("me");

							Connection conn = DbConnector.getConnection();
							Statement st = conn.createStatement();

							ResultSet rst = st
									.executeQuery("select * from userfiles where filekey='"
											+ txt + "' and userid='"
											+ request.getSession().getAttribute("me") + "'");

							String filename = null;
							String edit = null;
							String view = null;
							String key = null;

							while (rst.next()) {

								filename = rst.getString("filename");
								edit = rst.getString("edit");
								view = rst.getString("view");
								key = rst.getString("filekey");
							}

							if (edit != null && edit.equals("yes")) {
						%>
						<form action="upload2">

							<input type="hidden" value="<%=filename%>" name="filename">
							<input type="hidden" value="<%=userid%>" name="userid">
							<table style="width: 100%; border-spacing: 0;">

								<tr>
									<th>File Name</th>
									<th><%=filename%></th>
								</tr>
								<tr>
									<td align="center" colspan="2">
										<%
											String path = "F:\\venu\\"; //chanage the path
											
											

												SimpleFTPClient client = new SimpleFTPClient();
												client.setHost("ftp.drivehq.com");
												client.setUser("bhavyag18");
												client.setPassword("123456");
												client.setRemoteFile(filename);
												client.setMykey(txt);

												client.connect();

												if (client.downloadFile(path + "searencrypted" + filename)) {

													System.out.println("search download encrypted data:\t "
															+ new String(Files.readAllBytes(Paths.get(path
																	+ "searencrypted" + filename))));

													FileInputStream fis = new FileInputStream(path
															+ "searencrypted" + filename);

													FileOutputStream fos = new FileOutputStream(path
															+ "searchdecrypted" + filename);

													try {

														client.decrypt(fis, fos);

														System.out.println("search download decrypted data:\t "
																+ new String(Files.readAllBytes(Paths.get(path
																		+ "searchdecrypted" + filename))));

													} catch (Throwable e) {
														// TODO Auto-generated catch block
														e.printStackTrace();
													}

													String viewData = new String(Files.readAllBytes(Paths
															.get(path + "searchdecrypted" + filename)));

													String[] spilts = viewData.split("voidmain");
										%> <textarea rows="10" cols="10" name="filedata"> <%=spilts[0]%> </textarea>
										<%
											}//if
										%>


									</td>
								</tr>
							</table>
							<center>
								<input type="submit" value="update" />
							</center>
						</form>
						<%
							} else {
								if (view != null && view.equals("yes")) {
						%>

						<table style="width: 100%; border-spacing: 0;">

							<tr>
								<th>File Name</th>
								<th><%=filename%></th>
							</tr>
							<tr>
								<td align="center" colspan="2">
									<%
										String path = "F:\\venu\\"; //chanage the path

												SimpleFTPClient client = new SimpleFTPClient();
												client.setHost("ftp.drivehq.com");
												client.setUser("bhavyag18");
												client.setPassword("123456");
												client.setRemoteFile(filename);
												client.setMykey(txt);

												client.connect();

												if (client.downloadFile(path + "searencrypted" + filename)) {

													System.out.println("search download encrypted data:\t "
															+ new String(Files.readAllBytes(Paths.get(path
																	+ "searencrypted" + filename))));

													FileInputStream fis = new FileInputStream(path
															+ "searencrypted" + filename);

													FileOutputStream fos = new FileOutputStream(path
															+ "seardecrypted" + filename);

													try {

														client.decrypt(fis, fos);

														System.out
																.println("search download decrypted data:\t "
																		+ new String(
																				Files.readAllBytes(Paths
																						.get(path
																								+ "seardecrypted"
																								+ filename))));

													} catch (Throwable e) {
														// TODO Auto-generated catch block
														e.printStackTrace();
													}

													String viewData = new String(Files.readAllBytes(Paths
															.get(path + "seardecrypted" + filename)));

													String[] spilts = viewData.split("voidmain");
									%> <textarea rows="10" cols="10" name="filedata"> <%=spilts[0]%> </textarea>
									<%
										}//if
											}
										}
									%>


								</td>
							</tr>
						</table>

						</div>
						</div>
						</div>
						<br />
						<br />
						<br />
						<br />
						<br />
						<div id="content_footer"></div>
						<div id="footer">
							<p></p>
						</div>
						</div>
</body>
</html>
