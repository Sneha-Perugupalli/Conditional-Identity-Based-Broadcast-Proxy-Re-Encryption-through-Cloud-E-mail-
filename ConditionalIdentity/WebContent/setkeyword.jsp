<!DOCTYPE HTML>
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
		var a = document.ff.name.value;
		var b = document.ff.user.value;
		var c = document.ff.pass.value;

		if (a == 0) {
			alert('Please Enter Title');
			document.getElementById("name").focus();
			return false;
		}
		if (b == 0) {
			alert('Please Enter Keyword');
			document.getElementById("user").focus();
			return false;

		}
		if (c == 0) {
			alert('Please Enter Category');
			document.getElementById("pass").focus();
			return false;
		}
	}
</script>

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div id="logo_text">
					<br />
					<br /> <font size="5"><a href="index.html"><span
							class="logo_colour">Conditional Identity-Based Broadcast Proxy Re-Encryption and Its Application to Cloud Email
								</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">
				
					<li class="selected"><a  href="adminpage.jsp">Home</a></li>
					<li ><a  href="view.jsp">View Data Details</a></li>
					<li ><a  href="viewreq.jsp">View User Request</a></li>
					<li ><a  href="attackresults.jsp">View Attacker Info</a></li>
					<li ><a  href="logout.jsp">Logout</a></li>	
					
				</ul>
			</div>
		</div>
		<div id="content_header"></div>
		<div id="site_content">
			<div id="sidebar_container">
				<br/><br/><br/><br/>
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
				
				<%
					String ke = session.getAttribute("nn").toString();
				%>
                 
                <br/><br/>
		
				<div class="form_settings">		
						
					<form action="update.jsp" name="ff" method="get"
					onsubmit="return check()">
						
						<input type="hidden" value="<%=ke%>" name="key">
						
						<p>
							<span>Title</span><input class="contact" type="text"
								 name="tit"/>
						</p>
						
						<br />
						
						<p>
							<span>Key word</span><input class="contact" type="text"
								name="keyword" />
						</p>
						
						<br />
						
						<p>
							<span>Category</span><input class="contact" type="text"
								 name="cat"/>
						</p>
					
						<br />
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Add" />
						</p>
					</form>
				</div>
			</div>
		</div>
		<br/><br/><br/><br/>
		<div id="content_footer"></div>
		<div id="footer">
			<p></p>
		</div>
	</div>
</body>
</html>
