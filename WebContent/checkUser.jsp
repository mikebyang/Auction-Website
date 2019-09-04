<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%

		try {
			//Create a connection string
			String url = "jdbc:mysql://cs336db.cmnipzd7m5gz.us-east-2.rds.amazonaws.com:3306/Auction";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "g26cs336", "ag2400DB");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//
			
			//Get parameters from the HTML form at the login.jsp
		    String newEmail = request.getParameter("ru_email");
		    String newPswd = request.getParameter("password");
		    String newUserId = request.getParameter("user_id");
		    
		    //if it is an admin
		    if((newUserId.equals("admin"))&&(newPswd.equals("admin"))){
		    	session.setAttribute("user_id", "admin");
		    	%><script>
		    	window.location.href = "admin-syssup/admin.jsp";
		    	</script>
		    	<%
		    	return;
		    }
		    
			if ((newUserId.equals(""))&&(newPswd.equals(""))){
				%>
				<script> 
				    alert("Please enter your user id and password");
				    window.location.href = "login.jsp";
				</script>
				<% 
			} else {
				
				session.setAttribute("user_id", "agodich");
				session.setAttribute("user_name", "Arthur" );
				session.setAttribute("user_email", "agodich@aol.com");
				
				String str = "SELECT * FROM User e WHERE e.UserID='" + newUserId + "' and e.Password='" + newPswd + "'";
	
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				//System.out.println(str);
	
				if (result.next()) {
					out.print("login success! Welcome: ");
					out.print(result.getString("UserID"));				
					Integer locked = result.getObject("Locked") != null ? result.getInt("Locked") : null;
				
					System.out.println(locked);

					if( result.getObject("Locked") == null ){
						session.setAttribute("user_id", result.getString("UserID"));
						session.setAttribute("user_name", result.getString("Fname"));
						session.setAttribute("user_email", newEmail);
						%>
						<script> 
					 	    alert("login success!");
				    		window.location.href = "mainPage.jsp";
				    		//window.location.href = "driverHomePage.jsp";
						</script>
					<%
					}
					else if(result.getInt("Locked")==0){
						session.setAttribute("user_id", result.getString("UserID"));
						session.setAttribute("user_name", result.getString("Fname"));
						session.setAttribute("user_email", newEmail);
						

						%>
						<script> 
					 	   	alert("login success!");
				    		window.location.href = "mainPage.jsp";
				    		//window.location.href = "driverHomePage.jsp";
						</script>
					<%						
					}
					else if (result.getInt("Locked")==1){
						%>
						<script> 
					    	alert("Sorry, the user is locked and cannot log in now");
					    	window.location.href = "login.jsp";
						</script>
						<%						
					}
					//close the connection.
				} else {
					out.print("User not found");
					%>
					<script> 
				    	alert("User not found, or you entered a wrong password.");
				    	window.location.href = "login.jsp";
					</script>
					<%
				}
			}
			con.close();

		} catch (Exception e) {
			out.print("failed");
			%>
			<script> 
		    	alert("Sorry, unexcepted error happend.");
		    	window.location.href = "login.jsp";
			</script>
			<%			
		}
	%>

</body>
</html>