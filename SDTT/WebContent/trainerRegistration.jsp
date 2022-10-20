<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
    
<%
	Connection conn=null;
	String query="";
	Statement st=null;
	try{
       	Class.forName("com.mysql.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		st = conn.createStatement();
	}
	catch(Exception e){
		out.println("Error +"+e.getMessage());
		out.println(" error :"+e);
	}
%>

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
        <h2 class="h2-responsive"><strong>Trainer Registration Form</strong></h2>

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

                </div>
          <!--Email validation-->
          <div class="md-form">
            <i class="fas fa-envelope prefix"></i>
            <input type="email" name="email" class="form-control validate">
            <label for="email" data-error="wrong" data-success="right">Your email</label>
          </div>

          <div class="md-form">
			<i class="far fa-address-book prefix"></i>
            <input type="number" name="contact" class="form-control validate">
            <label for="contact" data-error="wrong" data-success="right">contact</label>
          </div>

	        <label>Select department</label>
			<div class="md-form mt-2">
			<select class="browser-default custom-select " name="dept_code">
				<%  query="select * from department;";
					ResultSet rs=st.executeQuery(query);
					while(rs.next()){%>
					<option value="<%= rs.getInt("dept_id")%>"><%= rs.getString("dept_name")%></option>
				<%}%>
			</select>					        	
			</div>

		<div class="md-form">
			<h6 class="h6-responsive mt-3">Date of Birth</h6>
		  <input  type="date" name="dob" class="form-control">
		</div>


          <div class="md-form">
            <i class="fas fa-envelope prefix"></i>
            <input type="number" name="adhar_id" class="form-control validate">
            <label for="adhar_id" data-error="wrong" data-success="right">Adhar ID</label>
          </div>


            <h6 class="h6-responsive mt-3">Address Details</h6>
                <div class="row">
                    <div class="col-md-12">
                      <div class="md-form ">
                        <i class="far fa-address-card prefix"></i>
                        <input type="text" name="address" class="form-control validate">
                        <label for="address" data-error="wrong" data-success="right">Address</label>
                      </div>
                    </div>
                    <div class="col-md-6">
                        <div class="md-form mb-0">
                            <input type="text" name="city" class="form-control">
                            <label for="firstname" class="">City</label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="md-form mb-0">
                            <input type="number" name="pincode" class="form-control">
                            <label for="pincode" class="">Pincode</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="md-form mb-0">
                            <input type="text" name="state" class="form-control">
                            <label for="state" class="">State</label>
                        </div>
                    </div>
                    <!--Grid column-->
                </div>

		          <h6 class="h6-responsive mt-3">Password</h6>
		          <div class="md-form">
		            <i class="fas fa-key prefix"></i>
		            <input type="password" name="password" class="form-control validate">
		            <label for="password" data-error="wrong" data-success="right">Password</label>
		          </div>
		          <div class="md-form">
		            <i class="fas fa-key prefix"></i>
		            <input type="password" id="confirmpassword" class="form-control validate">
		            <label for="confirmpassword" data-error="wrong" data-success="right">Confirm Password</label>
		          </div>

          <div class="text-xs-left">
            <button name="trainerRegistration_form" type="submit" class="btn btn-primary">Register</button>
          </div>
        </form>

      </div>
      <!--Naked Form-->

    </div>
  </div>
</div>
<!-- /.Main Container --><!--   _____________________________Header_________________________________________-->


<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.2.1/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.7.3/js/mdb.min.js"></script>
<!-- ----------------------------------------------------Javascript------------> 

<%
    if (conn != null) {
        try {
            conn.close();
            System.out.println("Database Connection Terminated");
        } catch (Exception e) {}
    }
%>


  </body>
</html>