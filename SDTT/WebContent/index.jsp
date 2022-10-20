<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.2.1/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.7.3/css/mdb.min.css" rel="stylesheet">

	<title> Smart And Dynamic Timetable</title>
<style type="text/css">
html,
body{
  height: 100%;

}
header,
.view {
  height: 50%;
}

@media (max-width: 740px) {
  html,
  body{
    height: 100vh;
  }
  header,
  .view {
    height: 50vh;
  }
}

.top-nav-collapse {
  background-color: black;
}

.navbar:not(.top-nav-collapse) {
  background: transparent !important;
}

@media (max-width: 500px) {
  .navbar:not(.top-nav-collapse) {
    background: #78909c !important;
  }
}
</style>
</head>
<body>

        <header>
          <!--Navbar-->
          <nav class="navbar navbar-expand-lg navbar-dark fixed-top scrolling-navbar">
            <div class="container">
			    <a class="navbar-brand" href="#">
            	<img src="images/logo2.png" style="width:75px; height:50px">
			    </a>
			    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
			      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			      <span class="navbar-toggler-icon"></span>
			    </button>
			    <div class="collapse navbar-collapse" id="navbarSupportedContent">
			      <ul class="navbar-nav mr-auto">
			      </ul>

			      <ul class="navbar-nav nav-flex-icons">
			        <li class="nav-item ">
			          <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
			        </li>
			      <li class="nav-item dropdown nav-item">
			        <a class="nav-link dropdown-toggle nav-link" id="navbarDropdownMenuLink-333" data-toggle="dropdown" aria-haspopup="true"
			          aria-expanded="false">
			          <i class="fas fa-user"></i>Login
			        </a>
			        <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="navbarDropdownMenuLink-333">
						<a href="" class="dropdown-item" data-toggle="modal" data-target="#adminLogin">Admin Login </a>
						<a href="trainerRegistration" class="dropdown-item" data-toggle="modal" data-target="#trainerLogin">Trainer Login</a>   
			        </div>
			      </li>

			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown" aria-haspopup="true"
			          aria-expanded="false">
			          <i class="fas fa-user-plus"></i>Sign up
			        </a>
			        <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="navbarDropdownMenuLink-333">
						<a class="dropdown-item " href="adminRegistration.jsp">Admin Registration</a>
				        <a class="dropdown-item " href="trainerRegistration.jsp">Trainer Registration</a>
			        </div>
			      </li>
			     </ul>
			    </div>
            </div>
          </nav>
          
          <div class="view h-100 light-blue">
          	<div class="container mt-5 pt-5">
          		<div class="row">
          			<div class="col-md-6 col-sm-12 pt-5">
          				<h3 class="h3 text-white">
          						Move from time consuming
          						process to the automated way
          				</h3>
          			</div>
          			<div class="col-md-6 pt-5">
          				<div class="w-50 h-50" >
          				<img class="img-fluid shadowm" src="images/laptop.png"> 	
          				</div>
          			</div>
          		</div>
          	</div>
          </div>
        </header>
<!-- Main navigation -->
        <!--Main Layout-->
          <div class="view h-75 light">
          	<div class="container py-5">
          		<div class="row w">
          			<div class="col-md-6 h-50">
          				<div class="w-50 h-50" >
          				<img class="img-fluid shadowm" src="images/desktop.png"> 	
          				</div>
          			</div>

          			<div class="col-md-6 h-50">
          				<h3 class="h3">Clash Free</h3>
          				<p>The System generated timetable is Clash-Free in terms  of  Trainers and Session durations.</p>
          				<h3 class="h3">Dynamic Nature</h3>
          				<p> Dynamically allocation of Other trainer in case of unavailability of Particular trainer.</p>
          				<h3 class="h3">Well-Formedness</h3>
          				<p>Load Hours of Trainers,Training Period are taken into Consideration</p>
          				<h3 class="h3">Infrastructure-friendly</h3>
          				<p>In terms of minimum walking distance between training halls having two consecutive training sessions of same Trainer.</p>
          			</div>
          		</div>
          	</div> 
          </div>

        <!--Main Layout-->
<!-- _______________________________________footer______________________________________  -->
<footer class="page-footer font-small primary-color-dark">

    <!-- Copyright -->
    <div class="footer-copyright text-center py-5">© 2019 Copyright:
      <a href="#"> Heisenbug_404.com</a>
    </div>
    <!-- Copyright -->

  </footer>


<!-- _____________Admin Login Modal UI Start _____________________________ -->
						<div class="modal fade" id="adminLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
						  aria-hidden="true">
						  <div class="modal-dialog cascading-modal modal-avatar modal-sm" role="document">
						    <div class="modal-content" style="border-radius:15px;">
						      <div class="modal-header">
						        <img src="images/admin.png" alt="avatar" class="rounded-circle img-responsive">
						      </div>
						      <div class="modal-body text-center mb-1" >
						        <h5 class="mt-1 mb-2">Admin Login</h5>
							   <form method="post" action="config/validate.jsp" name="adminLoginForm">
								   <div class="md-form mb-5">
									  <input type="email" id="username" name="username" class="form-control validate">
									  <label data-error="" data-success="" for="username">Your email</label>
									</div>
							        <div class="md-form ml-0 mr-0">
							          <input type="password" type="text" id="password" name="password" class="form-control form-control-sm validate ml-0">
							          <label data-error="" data-success="" for="password" class="ml-0">Enter password</label>
							        </div>
							        <div class="text-center mt-4">
							          <button type="submit" name="adminLogin_form" class="btn btn-cyan mt-1">Login <i class="fas fa-sign-in"></i></button>
							        </div>
							   </form>
						      </div>
						    </div>
						  </div>
						</div>
				<!-- _______________Admin login ends_________________ -->
				<!-- _____________Trainer Login -->
					<div class="modal fade" id="trainerLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
					  aria-hidden="true">
					  <div class="modal-dialog cascading-modal modal-avatar modal-sm" role="document">
					    <div class="modal-content" style="border-radius:15px;">
					      <div class="modal-header">
					        <img src="images/trainer.jpg" alt="avatar" class="rounded-circle img-responsive">
					      </div>
					      <div class="modal-body text-center mb-1" >
					        <h5 class="mt-1 mb-2">Trainer Login</h5>
							   <form method="post" action="config/validate.jsp" >
							   <div class="md-form mb-5">
								  <input type="email" name="username" class="form-control validate">
								  <label data-error="" data-success="" for="username">Your email</label>
								</div>
						        <div class="md-form ml-0 mr-0">
						          <input type="password" type="text" name="password" class="form-control form-control-sm validate ml-0">
						          <label data-error="" data-success="" for="password" class="ml-0">Enter password</label>
						        </div>
						        <div class="text-center mt-4">
						          <button type="submit" name="trainerLogin_form" class="btn btn-cyan mt-1">Login <i class="fas fa-sign-in"></i></button>
						        </div>

					        </form>
					      </div>
					    </div>
					  </div>
					</div>
<!-- ________________trainers end modal ui ends________________ -->

<script type="text/javascript">
	

</script>
  <!-- _________________________________________JQuery __________________________________ -->
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.2.1/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.7.3/js/mdb.min.js"></script>



</body>
</html>