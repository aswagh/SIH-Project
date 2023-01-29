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
	String firstname;
	String middlename;
	String lastname;
	String fullname;
	String email;
	String password;
	String institute_code;
	String contact,city,state,address,adhar_id,dept_id,query,dob;
	Connection conn=null;
	try{
       	Class.forName("com.mysql.cj.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		Statement st = conn.createStatement();
		if(request.getParameter("adminRegistration_form")!=null){
			firstname = request.getParameter("firstname");
			middlename = request.getParameter("middlename");
			lastname = request.getParameter("lastname");
			fullname =firstname+" "+middlename+" "+lastname;
			email = request.getParameter("email");
			password = request.getParameter("password");
			institute_code = request.getParameter("institute_code");
			contact = request.getParameter("contact");
			query = "INSERT INTO admin (`admin_name`,`email`,`institute_code`,`password`,contact) VALUES ('"+fullname+"','"+email+"',"+institute_code+",'"+password+"','"+contact+"');";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Registered..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addDivision.jsp");}
		}

		if(request.getParameter("trainerRegistration_form")!=null){
			firstname = request.getParameter("firstname");
			middlename = request.getParameter("middlename");
			lastname = request.getParameter("lastname");
			fullname =firstname+" "+middlename+" "+lastname;
			dept_id = request.getParameter("dept_code");
			dob = request.getParameter("dob");
			adhar_id = request.getParameter("adhar_id");
			email = request.getParameter("email");
			contact = request.getParameter("contact");
			address = request.getParameter("address");
			city = request.getParameter("city");
			state = request.getParameter("state");
			institute_code = request.getParameter("institute_code");
			password = request.getParameter("password");
			query="INSERT INTO `trainer`(`trainer_name`,`dept_id`,`dob`,`addhar_id`,`email`,`contact`,`address`,`city`,`state`,`institute_code`,`password`)VALUES"+
			"('"+fullname+"',"+dept_id+",'"+dob+"','"+adhar_id+"','"+email+"','"+contact+"','"+address+"','"+city+"','"+state+"','"+institute_code+"','"+password+"')";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Registered..."))document.location ='index.jsp';</script>
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