<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <link rel="stylesheet" type="text/css" href="css/main.css">

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<title>AucEx</title>
</head>


<body>

<%
session.setAttribute("user_id", "");
session.setAttribute("user_name", "");
session.setAttribute("user_email", "");
%>

<p class="app-name"> AucEx </p>


<div class="login-page">
  <div class="form">
    <form class="register-form" method="post" action="newUser.jsp">
      
      <input type="text" placeholder="User ID" name="user_id"/>
      
      <input type="text" placeholder="First Name" name="user_name"/>
      
      <input type="text" placeholder="Last Name" name="user_Lname"/>
      
      <input type="text" placeholder="Address" name="user_address"/>
      
      <input type="text" placeholder="email" name="ru_email"/>
      
      <input type="password" placeholder="Password" name="password"/>
      
      <button>create</button>
      
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
    
    <form class="login-form" method="post" action="checkUser.jsp">
    
      <input type="text" placeholder="User ID" name="user_id" />
      <input type="password" placeholder="Password" name="password" />
      
      <button>login</button>
      <p class="message">Not registered? <a href="#">Create an account</a></p>

<!-- This line was commented out. There is no functionality yet  
      <p class="message">Admin or System support? <a href="admin-syssup/asLogin.jsp">Please log in here</a></p>     
-->

      
    </form>
     
  </div>
</div>




<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script type="text/javascript">
$(document).ready(function(){
	if (window.location.href.indexOf('signup')!=-1){
		$('.login-form').hide();
		$('.register-form').show();
	}
});

$('.message a').click(function(){
	   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
	});
</script>



<div class="footer">
  <p>Brought to you by: Group 26</p>
  <p>Bhargav Desai (bhd20); Arthur Godich (ag1433) ; Ganapat Tirumalareddy (gt253); Michael Yang (my301)</p>
</div>


</body>
</html>