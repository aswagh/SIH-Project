<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
        <!-- Bootstrap core CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.2.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Design Bootstrap -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.7.3/css/mdb.min.css" rel="stylesheet">
        <script src="jquery/jquery.min.js"></script>
    <title>Demo</title>
  </head>
  <body>
<!---___________________________________________________________________-->
<!-- Purple Header -->
<div class="edge-header deep-purple"></div>

<!-- Main Container -->
<div class="container free-bird">
  <div class="row">
    <div class="col-md-8 col-lg-7 mx-auto float-none white z-depth-1 py-2 px-2">

      <div class="card-body">
        <h2 class="h2-responsive"><strong>Admin Registration Form</strong></h2>

        <form action="config/connection.jsp" method="post">
                <div class="row">
                    <div class="col-md-4">
                        <div class="md-form mb-0">
                            <i class="fas fa-user prefix"></i>
                            <input type="text" name="firstname" class="form-control">
                            <label for="firstname" class="">First name</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="md-form mb-0">
                            <input type="text" name="middlename" class="form-control">
                            <label for="middlename" class="">Middle name</label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="md-form mb-0">
                            <input type="text" name="lastname" class="form-control">
                            <label for="lastname" class="">Last name</label>
                        </div>
                    </div>
                    <!--Grid column-->
                </div><!--  row -->
		          <!--Email validation-->
		          <div class="md-form">
		            <i class="fas fa-envelope prefix"></i>
		            <input type="email" name="email" class="form-control validate">
		            <label for="email" data-error="wrong" data-success="right">Your email</label>
		          </div>
		
		          <div class="md-form">
		            <i class="fas fa-envelope prefix"></i>
		            <input type="number" name="contact" class="form-control validate">
		            <label for="contact" data-error="wrong" data-success="right">contact</label>
		          </div>
		
					<label>Select institute</label>
					<div class="md-form mt-2">
					<select class="browser-default custom-select " name="institute_code">
						<option  value="6175">PCCOE(6175)</option>
						<option  value="6271">PICT(6271)</option>
						
					</select>					        	
					</div>
	
		          <h5 class="h5-responsive mt-3">Password</h5>
		          <div class="md-form">
		            <i class="fas fa-key prefix"></i>
		            <input type="password" name="password" class="form-control validate">
		            <label for="password" data-error="wrong" data-success="right">Password</label>
		          </div>
		          <div class="md-form">
		            <i class="fas fa-key prefix"></i>
		            <input type="password" id="confirmpassword" class="form-control validate">
		            <label for="confirmpassword" data-error="wrong" data-success="right">Confirm Password</label>
		            <span id="message"></span>
		          </div>
		
		          <div class="text-xs-left">
		            <button name="" type="submit" class="btn btn-primary">Register</button>
		          </div>
        </form>

        <div class="my-2">
          <p style="font-weight:300;font-size:0.75rem">Never share your passwords with anyone...</p>
        </div>

      </div>
      <!--Naked Form-->

    </div>
  </div>
</div>
<!-- /.Main Container --><!--   _____________________________Header_________________________________________-->

<script>

	$('#password, #confirm_password').on('keyup', function () {
		  if ($('#password').val() == $('#confirmpassword').val()) {
		    $('#message').html('Matching').css('color', 'green');
		  } else 
		    $('#message').html('Not Matching').css('color', 'red');
		});
</script>

<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.2.1/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.7.3/js/mdb.min.js"></script>

<!-- ----------------------------------------------------Java script------------> 


  </body>
</html>