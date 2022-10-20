<%@ page import="com.abc.jsp.TimetableGA"%>  
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>

<%! int trainer_id=0;%>
<%! String trainer_name="";%>
<%
	trainer_id=(int)session.getAttribute("trainer_id");  
	String trainer_name=(String)session.getAttribute("trainer_name");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1><%= request.getParameter("day") %></h1>
	<h1><%= trainer_id %></h1>
	<%!int id=101; %>
	<% TimetableGA.replaceTrainer(trainer_id,request.getParameter("day"));%>
	
	<%	response.sendRedirect("../index.jsp"); %>
</body>
</html>