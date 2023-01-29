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
	<style>
		#table{
			padding-top:100px;
		}
	</style>
    
    
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
<%@ include file="includes/sidebar.jsp" %> 
<div id="page-content-wrapper">
<%@ include file="includes/header.jsp" %> 
<div id="table">
	<div class="container-fluid">
		<div class="row">


	<table class="table m-5 ">
	  <thead class="black white-text">
		<tr>
				<th> Time /<br> Day</th>
				<% query="select * from timeslots where day='MON'"; rs1=st1.executeQuery(query);
				while(rs1.next()){ %>
				<th scope="col" class="text-center border"><%= rs1.getString("slot")%></th>
				<%  } %> 
		</tr>
		</thead>
		<tbody>
			<tr>
			<%query="select distinct(day) from timeslots;"; rs=st.executeQuery(query);
			while(rs.next()){			//iterate over day
			%>
			<tr>
			<th class="bg-success"><%= rs.getString("day") %>
			</th>
								
			<% query="select * from dynamicTable where day='"+rs.getString("day")+"' AND Professor_id="+trainer_id+"";
				rs2=st2.executeQuery(query);
				rs1.beforeFirst();
				while(rs1.next()){
					rs2.beforeFirst();					
			 	 	f=0;
				while(rs2.next()){
				 	 	String slot[] = (rs2.getString("timeslot")).split(" ");
						if(rs1.getString("slot").equals(slot[1])){f=1;%>
						
						<td class="border light-green lighten-3">
							<% query="select sub_name from subjects where sub_id="+rs2.getInt("sub_id")+";";
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label><%= rs3.getString("sub_name")%></label><br>
							 
						 <% query="select div_name from division where div_id="+rs2.getInt("div_id")+";";//elliminated
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label><%= rs3.getString("div_name")%></label><br>  	
							 
						<!--  <label><%= slot[1]%></label><br> -->	    
 							 
							<% query="select room_name from room where room_id="+rs2.getInt("room")+";";
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label>( <%= rs3.getString("room_name")%> )</label><br>
	
						<!-- 	<% query="select trainer_name from trainer where trainer_id="+rs2.getInt("Professor_id")+";";
							rs3=st3.executeQuery(query);rs3.next();%>
							 <label>Prof.<%= rs3.getString("trainer_name")%></label><br> -->	 
							 
						<!--  <label><%= rs2.getString("day")%></label>      -->
					      </td>
						<% break;}%>
			<%	}//end of while loop rs2  %>
									
									<% if(f==0){%><td class="border ">(free)</td><%}
					
				} //end of while loop rs1 %>		
						
			</tr>		
			<% }//end of while loop rs%>	
					
		</tbody>
	
	
	
	</table>		




		
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