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
       	Class.forName("com.mysql.jdbc.Driver");
       	conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tt","root","mysql");
		Statement st = conn.createStatement();
		
		
		if(request.getParameter("dept_form")!=null){
			String dept_name=request.getParameter("departmentname");
			query = "INSERT INTO department (dept_name) VALUES ('"+dept_name+"')";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Department Added..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addDepartment.jsp");}
		}
		if(request.getParameter("division_form")!=null){
			String div_name=request.getParameter("div_name");
			//String year=request.getParameter("year");
			query = "INSERT INTO division (div_name,year) VALUES ('"+div_name+"','Second')";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Division Added..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addDivision.jsp");}
		}

		if(request.getParameter("subject_form")!=null){
			String sub_name=request.getParameter("subject_name");
			String weekly_hours=request.getParameter("weekly_hours");
			String dept_code=request.getParameter("dept_code");
			query = "INSERT INTO subjects (sub_name,weekly_hours,dept_id,year) VALUES"+
					" ('"+sub_name+"',"+weekly_hours+","+dept_code+",'Second')";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Subject Added..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addSubject.jsp");}
		}

		if(request.getParameter("room_form")!=null){
			String room_no=request.getParameter("room_name");
			String room_capacity=request.getParameter("room_capacity");
			query = "INSERT INTO room (room_name,capacity) VALUES"+
					" ('"+room_no+"',"+room_capacity+")";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Room Added..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addRoom.jsp");}
		}
 
		if(request.getParameter("loadHours_form")!=null){
			String trainer_id=request.getParameter("trainer_code");
			int lec_load_hr=Integer.parseInt(request.getParameter("lecLoadHours"));
			int pra_load_hr=Integer.parseInt(request.getParameter("pracLoadHours"));
			int total_load=pra_load_hr+lec_load_hr;
			query = "INSERT INTO `load_hr`(`trainer_id`,`lec_load_hr`,`pra_load_hr`,`total_load`) VALUES "+
			"("+trainer_id+","+lec_load_hr+","+pra_load_hr+","+total_load+")";

				if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Load Hours Added..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("index.jsp");}
		}
		
		if(request.getParameter("adminUpdate_form")!=null){
			String	firstname = request.getParameter("firstname");
			String middlename = request.getParameter("middlename");
			String lastname = request.getParameter("lastname");
			String fullname =firstname+" "+middlename+" "+lastname;
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String contact = request.getParameter("contact");
			query = "UPDATE admin SET `admin_name`='"+fullname+"',`email`='"+email+"',`password`='"+password+"',contact='"+contact+"'";
			if(st.executeUpdate(query)!=0){
				response.sendRedirect("../index.jsp");%>
				<script>if(!alert("Updated..."))document.location ='index.jsp';</script>
			<%} 
			else{response.sendRedirect("addDivision.jsp");}
		}
		if(request.getParameter("timeSlot_form")!=null){
			int start_slot = Integer.parseInt(request.getParameter("start_slot"));
			int end_slot = Integer.parseInt(request.getParameter("end_slot"));
			int day = Integer.parseInt(request.getParameter("day"));
			int B_start = Integer.parseInt(request.getParameter("B_start"));
			int B_end = Integer.parseInt(request.getParameter("B_end"));
			query = "truncate table timeslots";
			st.executeUpdate(query);
			String daysArray[] = {"MON", "TUE", "WED", "THUS", "FRI", "SAT", "SUN"};
			int id=1;
			for(int days = 0;days<day;days++) {
				for(int i = start_slot ; i < end_slot ; i++)
				{
					int j = i+1;
					String time = daysArray[days]+" "+Integer.toString(i)+"-"+Integer.toString(j);
					if(i!=B_start) {
						query = "insert into timeslots values("+id+",'"+Integer.toString(i)+"-"+Integer.toString(j)+"','"+daysArray[days]+"') ";
						st.executeUpdate(query);
						id++;
					}
					else{
						i = B_end;
						i--;
					}
				}
			}
			response.sendRedirect("../index.jsp");
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