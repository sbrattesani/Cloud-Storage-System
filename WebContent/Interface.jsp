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

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Home</h1>
				</div>
			</div>
			<p>Hello ${username}! Welcome to the Cloud Data Storage Platform.
				Please use the side bar or select an option below to begin using the
				system.</p>

			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover"
					id="dataTable">
					<thead>
						<tr>
							<th>Upload file</th>
							<th>Download a File</th>
						</tr>


					</thead>
					<tbody>
						<tr class="odd gradeX">
							<td align="center"><img
								src="<%=request.getContextPath()%>/Images/upload.png"
								alt="Upload Image" style="width: 304px; height: 228px;" /></td>
							<td align="center"><img
								src="<%=request.getContextPath()%>/Images/download.png"
								alt="Download Image" style="width: 304px; height: 228px;"></td>
						</tr>

						<tr class="odd gradeX">
							<td>
								<p>+ Upload any file format up to 4GB</p>
								<p>+ Splits file into secret shares</p>
								<p>+ Share securely stored in SQL database</p>
							</td>

							<td>
								<p>+ Download stored files from the database</p>
								<p>+ Files accessible based on user N + T values</p>
								<p>+ Browser based download</p>
							</td>
						</tr>

						<tr class="odd gradeX">
							<td><input class="btn btn-lg btn-success btn-block"
								type="submit" value="Go" onClick="location.href='Upload.jsp'"></input></td>
							<td><input class="btn btn-lg btn-success btn-block"
								type="submit" value="Go" onClick="location.href='Download.jsp'"></input></td>
						</tr>
					</tbody>
				</table>

				<table class="table table-striped table-bordered table-hover"
					id="dataTable">
					<thead>
						<tr>
							<th>User Settings</th>
							<th>Logout</th>
						</tr>
					</thead>

					<tbody>
						<tr class="odd gradeX">
							<td align="center"><img
								src="<%=request.getContextPath()%>/Images/settings.png"
								alt="Settings Image" style="width: 304px; height: 228px;" /></td>
							<td align="center"><img
								src="<%=request.getContextPath()%>/Images/logout.png"
								alt="Logout Image" style="width: 304px; height: 228px;"></td>
						</tr>

						<tr class="odd gradeX">
							<td>
								<p>+ Change personal information</p>
								<p>+ Email and password</p>
								<p>+ Configure N + T values</p>
							</td>

							<td>
								<p>+ Logout of the CDS System</p>
								<p>+ Come back soon!</p>
							</td>
						</tr>

						<tr class="odd gradeX">
							<td><input class="btn btn-lg btn-success btn-block"
								type="submit" value="Go" onClick="location.href='GetUser'"></input></td>
							<td><input class="btn btn-lg btn-success btn-block"
								type="submit" value="Go" onClick="location.href='LogoutServlet'"></input></td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>


	<!-- jQuery and JavaScripts -->
	<script src="JS/JQuery.js"></script>
	<script src="JS/Bootstrap.js"></script>
	<script src="JS/Theme.js"></script>

</body>

</html>
