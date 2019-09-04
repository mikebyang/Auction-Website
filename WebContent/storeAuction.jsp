<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%@ page import="java.text.DecimalFormat"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<title>AucEx</title>
</head>


<body>
	<%
		String user_id = session.getAttribute("user_id").toString();
	
		try{
			//Create a connection string
			String url = "jdbc:mysql://cs336db.cmnipzd7m5gz.us-east-2.rds.amazonaws.com:3306/Auction";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");

			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "g26cs336", "ag2400DB");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//get the information submitted by end_user
			String VIN = request.getParameter("VIN");
			String test = request.getParameter("price");
			String price = request.getParameter("price");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			
			//storeInfo into database
			String check_if_exist = "SELECT * FROM Auction a"
					+ String.format(" WHERE a.VIN='%s' ", VIN);
					
			//out.println(check_if_exist);
			ResultSet allMatching = stmt.executeQuery(check_if_exist);
			
			
			if(allMatching.next() == true) {	
			%>
				<script> 
			    	alert("This car already Auctioned \n");
			    	window.location.href = "placeOnAuction.jsp";
				</script>
			<%
			}

			out.println("section 3 ");

			
			String insertItem = "INSERT INTO Auction (VIN, StartingPrice, StartDate, EndDate)"
					+String.format(" VALUES ('%s', '%s', '%s', '%s')", VIN, price, startDate, endDate);
			
			out.println(insertItem);	
			stmt.executeUpdate(insertItem);
			
			con.close();
			
			%>
			<script> 
		    	alert("Success! Your item was placed on Auction\n");
	    		window.location.href = "mainPage.jsp";
		    	//window.location.href = "showCarList.jsp";
			</script>
			<%
			
		}catch(Exception e){
		
			out.print(e.getMessage());
			
			%>
			<script> 
		    	alert("Error ! \n");
		    	window.location.href = "mainPage.jsp";
		    	//window.location.href = "showCarList.jsp";
			</script>
			<%
			
			
		}
	%>
</body>
</html>

