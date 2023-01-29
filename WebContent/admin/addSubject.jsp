<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
    
<jsp:include page="../config/connect.jsp"></jsp:include>    
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
<title>Insert title here</title>
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
						<div class="w-100 info-color">
						<p class="h4 text-center py-4">Add Subjects</p>
						</div>
					    <div class="card-body">
					        <form class="form" action="config/connection.jsp" method="post">
					            <div class="md-form mt-5">
									<select class="browser-default custom-select" name="dept_code">
									<%  query="select * from department;";
										ResultSet rs=st.executeQuery(query);
										while(rs.next()){%>

											<option value="<%= rs.getInt("dept_id")%>"><%= rs.getString("dept_name")%></option>
											
										<%}%>
									</select>					        	
					        	</div>
					            <div class="md-form mt-5">
					                <i class="fas fa-angle-right prefix grey-text"></i>
					                <input type="text" name="subjectcode"  class="form-control">
					                <label for="subjectcode" class="font-weight-light">Subject Code</label>
					            </div>
					            <div class="md-form mt-5">
					                <i class="fas fa-columns prefix grey-text"></i>
					                <input type="text" name="subject_name"  class="form-control">
					                <label for="subject_name" class="font-weight-light">Subject Name</label>
					            </div>

					            <div class="md-form mt-5">
					                <i class="fas fa-columns prefix grey-text"></i>
					                <input type="text" name="weekly_hours"  class="form-control">
					                <label for="weekly_hours" class="font-weight-light">Weekly Hours</label>
					            </div>

					            <div class="text-center py-4 ">
					                <button name="subject_form" class="btn info-color-dark w-50" type="submit">Add</button>
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
