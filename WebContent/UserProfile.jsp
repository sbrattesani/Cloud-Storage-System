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

			<!-- User navigation -->
			<ul class="nav navbar-top-links navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
						<i class="fa fa-caret-down"> ${username} </i>
				</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="GetUser"><i class="fa fa-user fa-fw"></i>
								User Settings</a></li>
						<li class="divider"></li>
						<li><a href="/CDSPlatform/LogoutServlet"><i
								class="fa fa-sign-out fa-fw"></i> Logout</a></li>
					</ul></li>
			</ul>

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
					<h1 class="page-header">User Settings</h1>
				</div>
			</div>

			<div class="col-lg-6">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="table-responsive">
							<form name="myform" onsubmit="return validateForm()"
								action="/CDSPlatform/UpdateServlet" method="GET">
								<table class="table">
									<tr>
										<th class="success">Username</th>
										<td class="success"><input class="form-control"
											name="username" type="text" value="${username}"
											placeholder="${username}" readonly></td>
										<td class="success"></td>
									</tr>
									<tr>
										<th class="info">Email</th>
										<td class="info"><input class="form-control" name="email"
											type="email" value="${email}" placeholder="${email}"></td>
										<td class="info"></td>
									</tr>

									<!-- N and T value tables-->

									<tr>
										<th class="warning">N Value</th>
										<th class="warning">T Value</th>
									</tr>

									<tr class="odd gradeX">
										<td class="warning"><select name="nvalue"
											class="form-control">

												<option>${nvalue}</option>
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
										</select></td>

										<td class="warning"><select name="tvalue"
											class="form-control">
												<option>${tvalue}</option>
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
										</select></td>
									</tr>

									<tr>
										<th class="danger">Password</th>
										<td class="danger"><input class="form-control"
											name="password" type="password"
											placeholder="Enter a new password"></td>
										<td class="danger"></td>
									</tr>
									<tr>
										<th class="danger">Confirm Password</th>
										<td class="danger"><input class="form-control"
											name="conPassword" type="password"
											placeholder="Confirm Password"></td>
										<td class="danger"></td>
									</tr>
								</table>

								<input class="btn btn-lg btn-danger btn-block" type="submit"
									value="Update"></input>

								<!-- Button for user information deletion -->
								<br>

								<div align="center">
									<i>Delete user account. WARNING THIS CAN NOT BE UNDONE </i>
									<button type="button" class="btn btn-danger btn-circle btn-n"
										onClick="location.href='DeleteServlet';">
										<i class="fa fa-times"></i>
									</button>
								</div>

							</form>

						</div>
					</div>
				</div>
			</div>
			<!-- Error Message -->
			<span style="color: red;">${errMsg}</span>
		</div>
	</div>
	
		<!-- jQuery and JavaScripts -->
	<script src="JS/JQuery.js"></script>
	<script src="JS/Bootstrap.js"></script>
	<script src="JS/Theme.js"></script>

	<!-- Form validation before action -->
	<Script>
    function validateForm() {
    var a = document.forms["myform"]["username"].value;
    var b = document.forms["myform"]["email"].value;
    var c = document.forms["myform"]["password"].value;
    var d = document.forms["myform"]["conPassword"].value;
    var n = document.forms["myform"]["nvalue"].value;
    var t = document.forms["myform"]["tvalue"].value;
    
    if (a.trim() == "") {
        alert("Name must be filled out");
        return false;
    } else if(b.trim() == "") {
    	alert("Email must be filled out");
        return false;
    } else if(c.trim() == "") {
    	alert("Password must be filled out");
        return false;
    } else if(c.length < 8) {
    	alert("Password must contain at least 8 characters");
        return false;
    }
    else if(d.trim() == "") {
    	alert("Please confirm password");
        return false;
    } else if(c.trim() != d.trim()) {
    	alert("Password do not match");
        return false;
    } else if(n.trim() == "") {
    	alert("Please enter a N Value");
        return false;
    } else if(t.trim() == "") {
    	alert("Please enter a T Value");
        return false;
    } else {
    	return true;
    }
}
    </Script>

</body>

</html>
