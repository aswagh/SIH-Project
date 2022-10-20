<%@ page import="com.abc.jsp.*"%>  
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%! int trainer_id=0;%>
<%! int div_id=0;%>
<%! int room_id=0;%>
<%! int sub_id=0;%>
<%! String slot="";%>
<%! String status="";%>
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
	<% div_id= Integer.parseInt(request.getParameter("div"));%>
	<% room_id= Integer.parseInt(request.getParameter("room"));%>
	<% sub_id= Integer.parseInt(request.getParameter("sub"));%>
	<% slot=request.getParameter("slot");%>
	<% status=request.getParameter("status");%>
	
	<%TimetableGA.replaceTrainerForAslot(trainer_id,slot,div_id,sub_id,room_id,status); %>
			<% response.sendRedirect("../index.jsp"); %>
</body>
</html>