<%@ page import="com.abc.jsp.TimetableGA"%>
<%TimetableGA.generateTimetable();%>
<!--TimetableGA.replaceTrainer(16,"MON");%>-->
<!-- response.sendRedirect("../index.jsp");%> -->


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
        
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    
    
    
    
    
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row ">
			<div class="col-md-12 ">
					<div class="card shadow h-75 w-75">
						<div class="card-body">
							<h3 class="h3">Time Table Generated Successfully</h3>
							<button class="btn btn-success" onclick="window.close()">Ok</button>
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