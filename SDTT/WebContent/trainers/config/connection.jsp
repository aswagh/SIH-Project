<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn=null;
	String query="";
	try{
       	Class.forName("com.mysql.cj.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		Statement st = conn.createStatement();
		if(request.getParameter("trainerUpdate_form")!=null){
			String firstname = request.getParameter("firstname");
			String middlename = request.getParameter("middlename");
			String lastname = request.getParameter("lastname");
			String fullname =firstname+" "+middlename+" "+lastname;
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String institute_code = request.getParameter("institute_code");
			String contact = request.getParameter("contact");
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String dept = request.getParameter("dept_code");
			String dob = request.getParameter("dob");
			String adhar_id = request.getParameter("adhar_id");
			query = "UPDATE trainer SET `trainer_name`='"+fullname+"',`email`='"+email+"',`password`='"+password+"',contact='"+contact+"',"+
			"address='"+address+"',city='"+city+"',state='"+state+"',dept_id="+dept+",dob='"+dob+"',addhar_id='"+adhar_id+"'";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Updated..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addDivision.jsp");}
		}

		
	
	
	}
	catch(Exception e){
		out.println("Error +"+e.getMessage());
		out.println(" error :"+e);
	}
	finally {
           if (conn != null) {
               try {
                   conn.close();
                   System.out.println("Database Connection Terminated");
               } catch (Exception e) {}
           }
	}
	%>
	</body>
</html>