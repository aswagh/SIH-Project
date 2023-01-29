<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%
	int admin_id=(int)session.getAttribute("admin_id");  
	String admin_name=(String)session.getAttribute("admin_name");

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
<title>Rooms</title>
</head>
<body>
<div id="wrapper">
	<%@ include file="includes/sidebar.jsp" %> 
	<div id="page-content-wrapper">
		<%@ include file="includes/header.jsp" %> 
		 <div class="container-fluid">
			<div class="row m-5">
				<div class="col-md-6 mt-5">
					<div class="card mt-5 w-100">
						<div class="w-100 light-blue">
						<p class="h4 text-center py-4">Add Rooms</p>
						</div>
					    <div class="card-body">
					        <form class="form" action="config/connection.jsp" method="post" >
					            <div class="md-form mt-5">
									<select class="browser-default custom-select" name="trainer_code">
									<%  query="select trainer_id,trainer_name from trainer;";
										ResultSet rs=st.executeQuery(query);
										while(rs.next()){%>
											<option value="<%= rs.getInt("trainer_id")%>"><%= rs.getString("trainer_name")%></option>
										<%}%>
									</select>					        	
					            </div>
					            <div class="md-form mt-5">
					                <i class="fas fa-columns prefix grey-text"></i>
					                <input type="text" name="lecLoadHours"  class="form-control">
					                <label for="lecLoadHours" class="font-weight-light">Lecture Load Hours</label>
					            </div>
					            <div class="md-form mt-5">
					                <i class="fas fa-columns prefix grey-text"></i>
					                <input type="text" name="pracLoadHours"  class="form-control">
					                <label for="pracLoadHours" class="font-weight-light">Practical Load Hours</label>
					            </div>
					            <div class="text-center py-4 ">
					                <button class="btn btn-cyan w-50" name="loadHours_form" type="submit">Submit</button>
					            </div>
					        </form>
					
					    </div>
					
					</div>
					<!-- Department End -->
				</div>
				
			</div>
		</div>
	</div>
</div>






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