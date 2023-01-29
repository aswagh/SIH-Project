<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

    <link rel="stylesheet" href="css/sidebar.css">
    <script type="" src="../jquery/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<%@ include file="includes/sidebar.jsp" %> 
	<div id="page-content-wrapper">
		<%@ include file="includes/header.jsp" %> 
		 <div class="container-fluid">
			<div class="row mt-5">
				<div class="com-md-8 pl-5 pt-5">
			      <div class="card-body">
			        <h2 class="h2-responsive"><strong>Admin Updation Form</strong></h2>
			
			        <form action="config/connection.jsp">
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
			                            <input type="text"  name="middlename" class="form-control">
			                            <label for="middlename" class="">Middle name</label>
			                        </div>
			                    </div>
			                    <div class="col-md-4">
			                        <div class="md-form mb-0">
			                            <input type="text"  name="lastname" class="form-control">
			                            <label for="lastname" class="">Last name</label>
			                        </div>
			                    </div>
			                    <!--Grid column-->
			
			                </div>
			          <!--Email validation-->
			          <div class="md-form">
			            <i class="fas fa-envelope prefix"></i>
			            <input type="email" name="email" class="form-control validate">
			            <label for="email" data-error="x" data-success="">Your email</label>
			          </div>
			
			          <div class="md-form">
			            <i class="fas fa-envelope prefix"></i>
			            <input type="number" name="contact" class="form-control validate">
			            <label for="contact" data-error="wrong" data-success="right">contact</label>
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
				          </div>
				
				          <div class="text-xs-left">
				            <button name="adminUpdate_form" class="btn btn-success">Update</button>
				          </div>
				        </form>
	
					</div>
                </div>
				      </div>
				</div>
			</div>
		</div>
	</div>
</div>














<!-- ---------------------------End of Main Content------------------------------------------------------- -->
    <script type="text/javascript">
      $(document).ready(function(){
        $("#menu-toggle").click(function(e){
          e.preventDefault();
          $("#wrapper").toggleClass("menuDisplay");
        });
      });
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