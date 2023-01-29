<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="../config/connect.jsp"></jsp:include>    
<%
	int admin_id=(int)session.getAttribute("admin_id");  
	String admin_name=(String)session.getAttribute("admin_name");
	
	
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
						<p class="h4 text-center py-4">Add Time Slots</p>
						</div>
					    <div class="card-body">
					        <form class="form" action="config/connection.jsp" method="post" >

					            <div class="form-group mt-5">
						            <label for="start_slot">Start Time :</label>
									<select class="browser-default custom-select" name="start_slot">
										<%for(int i=6;i<24;i++){ %>
											<option value=<%=i %>><%= i%></option>
										<%} %>
					            	</select>
					            </div>
					            <div class="form-group mt-5">
					            <label for="end_slot">End Time :</label>
									<select class="browser-default custom-select" name="end_slot">
										<%for(int i=10;i<24;i++){ %>
											<option value=<%=i %>><%= i%></option>
										<%} %>
					            	</select>
					            </div>

					            <div class="form-group mt-5">
						            <label for="B_start">Break Start Time :</label>
									<select class="browser-default custom-select" name="B_start">
										<%for(int i=6;i<24;i++){ %>
											<option value=<%=i %>><%= i%></option>
										<%} %>
					            	</select>
					            </div>
					            <div class="form-group mt-5">
					            <label for="B_end">Break End Time :</label>
									<select class="browser-default custom-select" name="B_end">
										<%for(int i=10;i<24;i++){ %>
											<option value=<%=i %>><%= i%></option>
										<%} %>
					            	</select>
					            </div>
					            <div class="form-group">
						            <label for="day">Working Days :</label>
									<select class="browser-default custom-select" name="day">
										<%for(int i=1;i<8;i++){ %>
											<option value=<%=i %>><%= i%></option>
										<%} %>
					            	</select>
					            </div>
					            <div class="text-center py-4 ">
					                <button class="btn btn-cyan w-50" name="timeSlot_form" type="submit">Add Slot</button>
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