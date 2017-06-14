<!DOCTYPE html PUBLIC ">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

<title>CDS - Login Page</title>

 <!-- Bootstrap CSS Link -->
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css">

</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title" align="center">Please Sign In</h3>
                   </div>
                    <div class="panel-body">
    				Please enter your username and password:
    
    				<!-- Login Form -->
    				<form name="login" action="/CDSPlatform/LoginServlet" method="POST">
    					<fieldset>
                        	<div class="form-group has-error">
                            	<input class="form-control" placeholder="Username" name="username" type="text" autofocus>
                                	</div>
                                	<div class="form-group has-error">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                    <div align="center"><span style="color:red;">${errMsg}</span></div>
                                </div>
                                <!-- Input credentials button -->
                                <input class="btn btn-lg btn-danger btn-block" type="submit" value="Submit"></input>
                            </fieldset>
                         </form>
                         <br>
                         
                         <!-- Registration Link -->
                         <div align="center">
                         <p><a href="Register.jsp" style="color:#8B0000;"> Sign Up</a></p>
                         </div>
					</div>
                </div>
            </div>
        </div>
    </div>

</body></html>
