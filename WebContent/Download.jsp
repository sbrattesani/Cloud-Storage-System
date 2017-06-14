<!DOCTYPE html>
<html lang="en">
<%@ page import="java.sql.*"%>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- Redirect if session expires due to inactivity. Improves security requirements -->
<META HTTP-EQUIV="refresh" CONTENT="<%= session.getMaxInactiveInterval() %>; Login.jsp" />

<title>CDS - Secret Shares System</title>

<!-- Custom CSS references -->
<link href="CSS/bootstrap.css" rel="stylesheet">
<link href="CSS/bootstrap.css" rel="stylesheet">
<link href="CSS/table.css" rel="stylesheet">
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
	
	<!-- Get file list from SQL database -->
	<% 
	   Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager
				.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");
		Statement stat = con.createStatement();
	
		String sql = "SELECT * FROM files";
		ResultSet results  = stat.executeQuery(sql);
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
					<h1 class="page-header">Download</h1>
				</div>

			</div>

			<!-- File Table -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading" >CDS File Archive
						
						</div>
						
						<div >
						<table class="table table-striped table-bordered"
								id="uValues">
						<tr>
										<td><b>User:</b> ${username} </td>
										<td><b>N Value:</b> ${nvalue} </td>
										<td><b>T Value:</b> ${tvalue} </td>
									</tr>
									</table>
						</div>
						
						<div class="panel-body" id="check">
							<table class="table table-striped table-bordered"
								id="dataTable">
								<thead>
									<tr>
										<th>ID</th>
										<th>Filename</th>
										<th>Date Uploaded</th>
										<th>N</th>
										<th>T</th>
									</tr>
								</thead>
								<tbody>
									<% while(results.next()){ %>
									<tr class="odd gradeX">
										<td><%= results.getString(1)%></td>
										<td><a href="Engine?param=<%= results.getString(1)%>" >
												<%= results.getString(2)%>
										</a></td>
										<td><%= results.getString(3)%></td>
										<td class="n"><%= results.getString(4)%></td>
										<td class="t"><%= results.getString(5)%></td>
										<td> <a href="DeleteFile?param=<%= results.getString(1)%>" >
											<button type="button" class="btn btn-danger btn-circle"
											onclick="if (confirm('Are you sure you want to delete this file?')) form.action='/Config?pg=FIBiller&amp;cmd=delete'; else return false;">
												<i class="fa fa-times"></i>
											</button>
										</a></td>
									</tr>
									<% } %>

								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- jQuery and JavaScript links -->
	<script src="JS/JQuery.js"></script>
	<script src="JS/Bootstrap.js"></script>
	<script src="JS/Menu.js"></script>
	<script src="JS/Theme.js"></script>
	<script src="JS/Table.js"></script>
	<script src="JS/Table.bootstrap.js"></script>
	<script src="jquery.cookie.js"></script>
	
	<!-- N + T privilage check -->
	<Script>
	$(document).on('click', '#check a', function(e) { 
		
		var nText = $(e.target).parent().siblings('td.n').text();
		var tText = $(e.target).parent().siblings('td.t').text();
		
		var nUser = $('#uValues tr td:nth-child(2)').text().replace(/[^\d]/g, "");
		var tUser = $('#uValues tr td:nth-child(3)').text().replace(/[^\d]/g, "");
		
		if (nUser.trim() < nText.trim() || tUser.trim() < tText.trim() ) {
	        alert("You do not have authorisation to access this file");
	        e.preventDefault(); //Stop download link
	    } 
		 });
	</Script>

	<script>
    $(document).ready(function() {
        $('#dataTable').DataTable({
            responsive: true
        });
    });
    </script>

</body>

</html>
