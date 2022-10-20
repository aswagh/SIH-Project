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
		 <div class="container" style="margin-top:120px;">
			<div class="row ">
				<div class="col-sm-6">	
				<%while(notify!=0){ %>
	
	
				<%	String query2="select * from leaveNotify where alloc_trainer="+trainer_id+";";
					rs6=st6.executeQuery(query2);
						while(rs6.next()){ 
					if(rs6.getString("status")!=null){ %>
			
					<div class="card">
						<div class="card-header">
							Notification
						</div>
						<div class="card-body">
							<p> Respected sir/madam, your session of 
							<% query="select sub_name from subjects where sub_id="+rs6.getInt("sub_id")+";";
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label><%= rs3.getString("sub_name")%></label><br>
							 has been schedule at division
						 <% query="select div_name from division where div_id="+rs6.getInt("div_id")+";";//elliminated
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label><%= rs3.getString("div_name")%></label><br>  	
							  in room no:							 
						<% query="select room_name from room where room_id="+rs6.getInt("room_id")+";";
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label>( <%= rs3.getString("room_name")%> )</label><br>
	
	
							<a href="config/notificationResolve.jsp?trainer_id=<%=trainer_id %>" class="btn btn-success">Confirm</a>
							<a href="config/notificationResolve.jsp?trainer_id=<%=trainer_id %>" class="btn btn-danger">Reject</a>
						</div>
						
						
					</div>
					
					<%
					}else{%>
					
					<div class="card mt-3">
						<div class="card-header">
							Notification
						</div>
						<div class="card-body">
							The Prof.<%= trainer_name%> is not available today.So session will be conducted by you. 
						</div>
													<a href="config/notificationResolve.jsp?trainer_id=<%=trainer_id %>" class="btn btn-success">Confirm</a>
						
					</div>
						
					
					
					
					<% break;} }%>
	
	
				<%notify--;} %>
	
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