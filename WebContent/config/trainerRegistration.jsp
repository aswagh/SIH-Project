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
	String state = request.getParameter("contact");
	String dept = request.getParameter("dept");
	String dob = request.getParameter("dob");
	String adhar_id = request.getParameter("adhar_id");
	out.println(fullname+"','"+email+"','"+password+"',"+institute_code+",'"+contact);
	Connection conn=null;
	try{
       	Class.forName("com.mysql.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		Statement st = conn.createStatement();
		String query ="INSERT INTO trainer (`trainer_name`,`dept_id`,`dob`,`addhar_id`,`email`,`contact`,`address`,`city`,`state`,`institute_code`,`password`) "+
		"VALUES ('"+fullname+"',"+dept+",'"+dob+"','"+adhar_id+"','"+email+"',"+contact+",'"+address+"','"+city+"','"+state+"','"+institute_code+"','"+password+"',) ";
		st.executeUpdate(query);
		out.print("Inserted Successfully");
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
	<!-- <jsp:forward page="../index.jsp" />  -->
<%
  if (conn == null){
    response.sendRedirect("index.jsp");
  }
%>
</body>
</html>