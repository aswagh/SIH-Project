<%! int trainer_id=0;%>
<%! String trainer_name="";%>
<%! int notify=0;%>
<%
	trainer_id=(int)session.getAttribute("trainer_id");  
	String trainer_name=(String)session.getAttribute("trainer_name");
	
	
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%
	Connection conn=null;
	String query="";
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
	int C=1,f=0;
	try{
       	Class.forName("com.mysql.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		st = conn.createStatement();
		st1 = conn.createStatement();
		st2 = conn.createStatement();
		st3 = conn.createStatement();
		st4 = conn.createStatement();
		st5 = conn.createStatement();
		st6 = conn.createStatement();
	}
	catch(Exception e){
		out.println("Error +"+e.getMessage());
		out.println(" error :"+e);
	}
%>


<!--Main Navigation-->

<header>

  <nav class="navbar fixed-top navbar-expand-lg navbar-dark teal accent-4 scrolling-navbar shadow">
    <a href="#menu-toggle" id="menu-toggle" class="p-3 text-white"><span><i class="navbar-toggler-icon"></i></span></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item ">
          <a class="nav-link pl-3" href="#Trainer">Welcome ,<%= trainer_name %> <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item ">
          <a class="nav-link pl-3" href="index.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
      </ul>
	<!-- <form class="form-inline">
		<div class="custom-control custom-radio pr-3">
		  <input type="radio" class="custom-control-input" id="defaultGroupExample1" name="attendance">
		  <label class="custom-control-label" for="defaultGroupExample1"> Absent  </label>
		</div>
		<div class="custom-control custom-radio pl-3">
		  <input type="radio" class="custom-control-input" id="defaultGroupExample2" name="attendance" checked>
		  <label class="custom-control-label" for="defaultGroupExample2" > Present </label>
		</div>
		<input class="btn btn-warning" type="submit" name="attendance_form" value="Notify">
	  </form>
	  -->  
	  <ul>
	  	<% String query1=" select count(*) as notify from leaveNotify where alloc_trainer="+trainer_id+";";
				  rs5=st5.executeQuery(query1); rs5.next();
				  notify = rs5.getInt("notify");
				  %>
			<button type="button" class="btn teal darken-1 waves-effect" ><a href="notification.jsp" class="text-white">
			  <i class="far fa-bell"></i>  Notifications <span class="badge badge-danger ml-2"><%= notify %></span></a>
			</button>
	  </ul>
      <ul class="navbar-nav nav-flex-icons  pl-5">
        <li class="nav-item">
        <a href="config/logout.jsp" class="nav-link">Log out<i class="fas fa-sign-out-alt"></i></a>        </li>
        </li>
      </ul>
      
            
    </div>
  </nav>
</header>
<!--Main Navigation-->