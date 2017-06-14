<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- Redirect if session expires due to inactivity. Improves security requirements -->
<META HTTP-EQUIV="refresh" CONTENT="<%= session.getMaxInactiveInterval() %>; Login.jsp" />

<title>CDS - Secret Shares System</title>

<!-- Bootstrap and custom CSS references -->
<link href="CSS/bootstrap.css" rel="stylesheet">
<link href="CSS/menu.css" rel="stylesheet">
<link href="CSS/theme.css" rel="stylesheet">
<link href="./CSS/font.css" rel="stylesheet" type="text/css">

</head>

<body>

	<!-- Check for active session else redirect -->
	<%
	if (session.getAttribute("username") == null) {
		response.sendRedirect("Login.jsp");
	}
	%>
	<div id="wrapper">

		<!-- Navigation bar -->
		<nav class="navbar navbar-default navbar-static-top"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="Interface.jsp"><i
					class="fa fa-cloud-upload"></i> Cloud Data Storage</a>
			</div>
			<form action="CDSPlatorm/GetUser" method="POST">
				<!-- User navigation -->
				<ul class="nav navbar-top-links navbar-right">

					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
							<i class="fa fa-caret-down"> ${username} </i>
					</a>
						<ul class="dropdown-menu dropdown-user">

							<li><a href="/CDSPlatform/GetUser"><i
									class="fa fa-user fa-fw"></i> User Settings</a></li>

							<li class="divider"></li>
							<li><a href="/CDSPlatform/LogoutServlet"><i
									class="fa fa-sign-out fa-fw"></i> Logout</a></li>

						</ul></li>

				</ul>
			</form>
			<!-- Side navigation -->
			<div class="navbar-default sidebar">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="Interface.jsp"><i class="fa fa-home fa-fw"></i>
								Home </a></li>
						<li><a href="Upload.jsp"><i class="fa fa-upload fa-fw"></i>
								Upload </a></li>
						<li><a href="Download.jsp"><i
								class="fa fa-download fa-fw"></i> Download </a></li>
						<li><a href="GetUser"><i class="fa fa-gear fa-fw"></i>
								User Settings</a></li>
					</ul>
				</div>
			</div>
		</nav>

		<!-- Header and file upload -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Files</h1>
				</div>
				<div class="form-group">
					<form name="myform" action="Engine" method="post"
						enctype="multipart/form-data" onsubmit="return validateForm()">
						<label>Choose a file to upload</label> <input name="file"
							type="file">
						<div class="form-group">
							<br>

							<!-- N and T value tables-->
							<table class="table table-striped table-bordered table-hover">
								<tr>
									<th>N Value</th>
									<th>T Value</th>
								</tr>

								<tr class="odd gradeX">
									<td><select name="nvalue" class="form-control">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
									</select></td>

									<td><select name="tvalue" class="form-control">
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
									</select></td>
								</tr>
							</table>
						</div>

						<br> <input type="submit" value="Upload File">
					</form>
					<br> <span style="color: red;">${errMsg}</span>
				</div>
			</div>
		</div>

	</div>

	<Script>
    function validateForm() {
    var a = document.getElementById("nvalue");
    var n = a.options[a.selectedIndex].text;
    
    var b = document.getElementsById("tvalue");
    var t = b.options[b.selectedIndex].text;
 
    System.out.print(a);
    if (n < 1 || t < 1) {
        alert("error");
        return false;
    } else {
    	return true;
    }
}
    </Script>

	<!-- jQuery and Javascript Links -->
	<script src="JS/JQuery.js"></script>
	<script src="JS/Bootstrap.js"></script>
	<script src="JS/Menu.js"></script>
	<script src="JS/Theme.js"></script>

</body>

</html>
