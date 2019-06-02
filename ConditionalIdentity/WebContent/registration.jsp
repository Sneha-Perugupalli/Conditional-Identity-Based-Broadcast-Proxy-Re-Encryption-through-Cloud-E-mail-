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
		var d = document.ff.email.value;
		var e = document.ff.dob.value;
		var f = document.ff.loc.value;
		var g = document.ff.sex.value;

		if (a.length== 0) {
			alert('Please Enter Name');
			document.getElementById("name").focus();
			return false;
		}
		if (b.length== 0) {
			alert('Please Enter Userid');
			document.getElementById("user").focus();
			return false;

		}
		if (c.length == 0) {
			alert('Please Enter Password');
			document.getElementById("pass").focus();
			return false;

		}
		if (d.length == 0) {
			alert('Please Enter E-mail Id');
			document.getElementById("email").focus();
			return false;

		}
		/*if (e.length == 0) {
			alert('Please Enter Date of Birth');
			document.getElementById("dob").focus();
			return false;

		}*/
		if (f.length == 0) {
			alert('Please Enter Your Location');
			document.getElementById("loc").focus();
			return false;

		}
		if (g.length == 0) {
			alert('Please Enter Gender');
			document.getElementById("sex").focus();
			return false;

		}
		//var email = document.mypro.email.value;
	    var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	    
	
	    if (!filter.test(d)) {
	    alert("Please provide a valid email address");
	    d.focus;
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
					<br /> <br /> <font size="5"><a href="index.html"><span
							class="logo_colour">Conditional Identity-Based Broadcast Proxy Re-Encryption and Its Application to Cloud Email
								</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">
					<!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
					<li class="selected"><a href="index.html">Home</a></li>
					<li><a href="userlog.jsp">Login</a></li>
					<li><a href="regpage.jsp">User Registration</a></li>
					<li><a href="registration.jsp">Data Owner Registration</a></li>
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
							<li><a href="index.html">Home</a></li>
							<li><a href="userlog.jsp">Login</a></li>
							<li><a href="regpage.jsp">User Registration</a></li>
							<li><a href="registration.jsp">Data Owner Registration</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">

				<%
					if (request.getParameter("msgg") != null) {
				%>
				<h3>Failed</h3>
				<%
					} else {
				%>
				<h3>Data Owner Registration</h3>
				<%
					}
				%>

				<div class="form_settings">
					
					<form action="regaction.jsp" name="ff" method="get"
						onsubmit="return check()">

						<%
							request.getSession().setAttribute("usertype", "owner");
						%>

						<p>
							<span>Name</span><input class="contact" type="text" name="name" id="name" />
						</p>
						<p>
							<span>User ID</span><input class="contact" type="text" name="user" id="user" />
						</p>
						<p>
							<span>E-Mail</span><input class="contact" type="text" name="email" id="mail" />
						</p>
						<p>
							<span>Password</span><input class="contact" type="password" name="pass" id="pass" />
						</p>

						<p>
							<!--  <span>Date</span><input class="contact" type="text" name="dob" id="dob" />-->
						</p>
						<p>
							<span>Location</span><input class="contact" type="text" name="loc" id="loc" />
						</p>
						<p>
							<span>Gender</span><input class="contact" type="text" name="sex" id="sex" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit" name="contact_submitted" value="Register" />
						</p>
					</form>
					
				</div>
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
