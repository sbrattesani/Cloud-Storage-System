<!DOCTYPE html PUBLIC ">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>CDS - Register Page</title>

<!-- CSS links  -->
<link href="CSS/bootstrap.css" rel="stylesheet" type="text/css">
<link href="CSS/Menu.css" rel="stylesheet" type="text/css">
<link href="CSS/theme.css" rel="stylesheet" type="text/css">
<link href="CSS/Font.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title" align="center">Registration Form</h3>
					</div>
					<div class="panel-body">
						Please complete the form to register for the CDS System:
						<form name="myform" 
							action="/CDSPlatform/RegisterServlet" method="POST">
							<fieldset>
								<div class="form-group">
									<input class="form-control" placeholder="Username"
										name="username" type="text">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Email" name="email"
										type="email">
								</div>

								<!-- N and T value tables-->
								<table class="table">
									<tr>
										<th>N Value</th>
										<th>T Value</th>
									</tr>

									<tr class="odd gradeX">
										<td><select name="nvalue" class="form-control">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
										</select></td>

										<td><select name="tvalue" class="form-control">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
										</select></td>
									</tr>
								</table>
								<div class="form-group">
									<input class="form-control" placeholder="Password"
										name="password" type="password">
								</div>
								<div class="form-group">
									<input class="form-control" placeholder="Confirm Password"
										name="conPassword" type="password">
								</div>
								<span style="color: red;">${errMsg}</span>
					
								<input class="btn btn-lg btn-success btn-block" type="submit"
									value="Sign Up" onClick="return validateForm()"></input> 
								<input
									class="btn btn-lg btn-success btn-block" type="reset"
									value="Cancel" onClick="location.href='Login.jsp';"></input>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

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
    }	else if(c.length < 8) {
    	alert("Password must contain at least 8 characters"); // Forces user to create stronger password
        return false;										  // improving system security.
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

	<!-- jQuery, bootstrap, and theme scripts -->
	<script src="JS/JQuery.js"></script>
	<script src="JS/Bootstrap.js"></script>
	<script src="JS/Menu.js"></script>
	<script src="JS/Theme.js"></script>
</body>
</html>
