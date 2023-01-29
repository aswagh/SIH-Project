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

				<div class="col-md-6 mt-5">
					<div class="row mt-5">
					<%  query="select count(*) as roomcount from room";
					ResultSet rs1=st.executeQuery(query);
					rs1.next();
					int roomcount=rs1.getInt("roomcount");
					%>
						<div class="col-md-5 m-2">
							<div class="card cyan shadow">
							  <div class="card-header">Rooms
							  </div>
							  <div class="card-body">
							  <%= roomcount %>
							  </div>
							</div>
						</div>
					<%  query="select count(*) as divcount from division";
					rs1=st.executeQuery(query);
					rs1.next();
					int divcount=rs1.getInt("divcount");
					%>
						<div class="col-md-5 m-2">
							<div class="light-blue">
							  <div class="card-header">Division
							  </div>
							  <div class="card-body">
							  <%= divcount %>
							  </div>
							</div>
						</div>
					<%  query="select count(*) as labcount from lab";
					rs1=st.executeQuery(query);
					rs1.next();
					int labcount=rs1.getInt("labcount");
					%>
						<div class="col-md-5 m-2">
							<div class="light-green">
							  <div class="card-header">Labs
							  </div>
							  <div class="card-body">
							  <%= labcount %>
							  </div>
							</div>
						</div>
					<%  query="select count(*) as trainercount from trainer";
					rs1=st.executeQuery(query);
					rs1.next();
					int trainercount=rs1.getInt("trainercount");
					%>
						<div class="col-md-5 m-2">
							<div class="light-blue accent-4">
							  <div class="card-header">Trainers
							  </div>
							  <div class="card-body">
							  <%= trainercount %>
							  </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6 mt-5">
					<!--Personal Details Card -->
					<div class="card mt-5">
					<div class="card-header bg-success text-white text-center">Profile</div>
					  <div class="card-body">
						<%  query="select * from admin where admin_id="+admin_id+";";
						ResultSet rs=st.executeQuery(query);
						while(rs.next()){%>
						<form >
							<img src="../images/trainer.jpg " class="w-25 h-25 col-6 pl-3">
							<label class="col-6  text-center"><b>Prof.<%= rs.getString("admin_name")%></b></label><hr>
							<label class="pl-5"><b>Email</b>		:<%= rs.getString("email")%></label>
							<label class="pl-5"><b>Contact</b>	:<%= rs.getString("contact")%></label><hr>
							<label class="col-6 pl-5"><b>Institute Code</b> :<%= rs.getString("institute_code")%></label>
						</form>
						
						<%}%>
					    <a href="updateAdmin.jsp" class="btn btn-success float-right">Update</a>
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