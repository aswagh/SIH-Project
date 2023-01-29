<%! String admin_name=" "; int admin_id=0;%>
<%
	admin_id=(int)session.getAttribute("admin_id");  
	admin_name=(String)session.getAttribute("admin_name");
	
%>

<!--Main Navigation-->
<header>
  <nav class="navbar fixed-top navbar-expand-lg light-blue darken-3 scrolling-navbar shadow">
    <a href="#menu-toggle" id="menu-toggle" class="p-3 nav-link text-white"><span><i class="fas fa-align-justify"></i></i></span></a>
    <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item ">
          <a class="nav-link pl-3 text-white" href="index.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item ">
          <a class="nav-link pl-3 text-white" href="#Admin">Welcome <%= admin_name %><span class="sr-only">(current)</span></a>
        </li>
      </ul>
      <ul class="navbar-nav nav-flex-icons">
        <li class="nav-item">
        <a href="config/logout.jsp" class="nav-link text-white">Log out<i class="fas fa-sign-out-alt"></i></a>        </li>
      </ul>
    </div>
  </nav>

</header>
<!--Main Navigation-->