<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%
	Connection conn=null;
	String query="";
	Statement st=null,st1=null,st2=null,st3=null,st4=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	int C=1,f=0;
	try{
       	Class.forName("com.mysql.cj.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
		
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
	<style>
		#table{
			padding-top:100px;
		}
	</style>
<title>Insert title here</title>
</head>
<body>
<!-- ______________________HEade tags______________________ -->
<div id="wrapper">
<%@ include file="includes/sidebar.jsp" %>  
<div id="page-content-wrapper"> 
<%@ include file="includes/header.jsp" %> 
<div id="table">
<div class="container-fluid">
<div class="row">
<table>
<tr>
  	<%query="select distinct(day) from timeslots;"; rs4=st4.executeQuery(query);
  		while(rs4.next()){
  	%>
  	<td class="pl-3 border">
	<table class="table ">
	  <thead class="black white-text">
				<tr></tr>
			    <tr>
			      <th scope="col"></th><th scope="col"></th><th scope="col"></th>
					<th scope="col"><%= rs4.getString("day") %></th>
			      <th scope="col"></th><th scope="col"></th><th scope="col"></th><th scope="col"></th>
			      <tr>
					<th></th>
					<% query="select * from timeslots where day='"+rs4.getString("day")+"'"; rs3=st3.executeQuery(query); %>
				<%  rs3.next();
				for(int i=0;i<7;i++){ %>
				<th scope="col"><%= rs3.getString("slot") %></th>
				<% rs3.next();}%> 
				<tr>
			
		</thead>
		<tbody>
		<tr>
			<%query="select * from division;"; rs2=st2.executeQuery(query);
			while(rs2.next()){%>
			<tr>
			<th class="bg-success"><%= rs2.getString("div_name") %></th>
			<%query="select * from timetable where day='"+rs4.getString("day")+"' AND div_id="+rs2.getInt("div_id")+"";
				rs=st.executeQuery(query);	
				rs3.beforeFirst();
				while(rs3.next()){
					rs.beforeFirst();
					f=0;
					while(rs.next()){
				 	 	String slot[] = (rs.getString("timeslot")).split(" ");
						if(rs3.getString("slot").equals(slot[1])){f=1;%>
	
						<td class="border">
							<% query="select sub_name from subjects where sub_id="+rs.getInt("sub_id")+";";
							rs1=st1.executeQuery(query);rs1.next();%>
							 <label><%= rs1.getString("sub_name")%></label><br>
							 
						<!-- <% query="select div_name from division where div_id="+rs.getInt("div_id")+";";//elliminated
							rs1=st1.executeQuery(query);rs1.next();%>
							 <label><%= rs1.getString("div_name")%></label><br>  -->	
							 
							<!-- <label><%= slot[1]%></label><br>  --> 
 							 
							<% query="select room_name from room where room_id="+rs.getInt("room")+";";
							rs1=st1.executeQuery(query);rs1.next();%>
							 <label>( <%= rs1.getString("room_name")%> )</label><br>
	
							<% query="select trainer_name from trainer where trainer_id="+rs.getInt("Professor_id")+";";
							rs1=st1.executeQuery(query);rs1.next();%>
							 <label>Prof.<%= rs1.getString("trainer_name")%></label><br>
							 
							<!-- <label><%= rs.getString("day")%></label>   --> 
					      </td>
						
							
						<%break;}
					}
					if(f==0){%><td class="border">No</td><%}
					
				}//end of while  for rs3
			%>
			</tr>
			<% }//end while loop for rs2 division %>
		</tr>
		</tbody>
	</table>
	</td>
	<%}//End of rs4 %>
	
</tr>
</table>
	
</div>
	 
 
 
 </div>
</div>
<!-- ______________________HEade ends below ______________________ -->
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