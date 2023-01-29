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

				<div class="col-md-6 mt-5">
					<div class="row mt-5">
					<%  query="select * from load_hr where trainer_id="+trainer_id+";";
					 rs1=st.executeQuery(query);
					while(rs1.next()){
					%>

						<div class="col-md-5 m-2">
							<div class="card cyan shadow">
							  <div class="card-header default-color-dark text-white text-center">
							  	Lecture Load Hours
							  </div>
							  <div class="card-body default-color text-white text-center">
							  <%= rs1.getInt("lec_load_hr")%> Hours
							  </div>
							</div>
						</div>
						<div class="col-md-5 m-2">
							<div class="light-blue">
							  <div class="card-header primary text-white text-center">
							  	Practical Load Hours
							  </div>
							  <div class="card-body info text-white text-center">
							  <%= rs1.getInt("pra_load_hr")%> Hours
							  </div>
							</div>
						</div>
						<div class="col-md-5 m-2">
							<div class=" pink accent-1 text-white text-center">
							  <div class="card-header">
							  Total Load Hours
							  </div>
							  <div class="card-body  pink accent-2 text-white text-center">
							  <%= rs1.getInt("total_load")%> Hours
							  
							  </div>
							</div>
						</div>
						<% }%>
						
					</div>
				</div>
				<div class="col-md-6 mt-5">
					<!--Personal Details Card -->
					<div class="card mt-5">
					<div class="card-header bg-success text-white text-center">Profie</div>
					  <div class="card-body">
						<%  query="select * from trainer where trainer_id="+trainer_id+";";
						 rs=st.executeQuery(query);
						while(rs.next()){%>
						<form class="">
							<img src="../images/trainer.jpg " class="w-25 h-25 col-6 pl-3">
							<label class="col-6  text-center"><b><%= rs.getString("trainer_name")%></b></label><hr>
							<label class="pl-5"><b>Email</b>		:<%= rs.getString("email")%></label>
							<label class="pl-5"><b>Contact</b>	:<%= rs.getString("contact")%></label><hr>
							<label class="col-12 pl-5">Address Details :</label>
							<label class="col-12 pl-5"><b>Landmark</b> 	:<%= rs.getString("address")%></label>
							<label class="pl-5"><b>City</b> :<%= rs.getString("city")%></label>
							<label class="pl-5"><b>State</b> 	:<%= rs.getString("state")%></label>
							<label class="col-6 pl-5"><b>Institute Code</b> :<%= rs.getString("institute_code")%></label>
						
						</form>
						
						<%}%>
					    <a href="trainerUpdate.jsp" class="btn btn-success float-right">Update</a>
					  </div>
					</div>
					<!--Personal Details Card -->
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