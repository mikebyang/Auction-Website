<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


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
			String category = request.getParameter("category");
			String make = request.getParameter("make");
			String model = request.getParameter("model");
			String description = request.getParameter("description");
			String condition = request.getParameter("condition");

			int year = Integer.parseInt(request.getParameter("year"));
			String color = request.getParameter("color");
			String interior = request.getParameter("interior");
			String navigation = request.getParameter("navigation");
			String drive = request.getParameter("drive");
			String bodyType = request.getParameter("bodyType");
			String engineSize = request.getParameter("engineSize");
			String towing = request.getParameter("towing");
			
			
			//storeInfo into database
			String check_if_exist = "SELECT * FROM Car c"
					+ String.format(" WHERE c.VIN='%s' ", VIN);
					
			//out.println(check_if_exist);
			ResultSet allMatching = stmt.executeQuery(check_if_exist);
			
			
			if(allMatching.next() == true) {	
			%>
				<script> 
			    	alert("This car already Exists on Car table \n");
			    	//window.location.href = "showCarList.jsp";
				</script>
			<%
			}
			String insertItem = "INSERT INTO Item (VIN, Make, Model, Description, ItemCondition, Category, SellerID)"
					+String.format(" VALUES ('%s', '%s', '%s','%s','%s', '%s', '%s')", VIN, make, model, description, condition, category, user_id);
				
			stmt.executeUpdate(insertItem);
			
			if (category.equals("car")) {
				String insertCar = "INSERT INTO Car (VIN, Year, Color, Interior, Navigation, Drive)"
						+String.format(" VALUES ('%s', %d,'%s','%s', '%s', '%s')", VIN, year, color, interior, navigation, drive);
					
				stmt.executeUpdate(insertCar);				
			}
			else if (category.equals("truck")) {
				String insertTruck = "INSERT INTO Truck (VIN, Year, Color, BodyType, Towing)"
						+String.format(" VALUES ('%s', %d,'%s','%s', '%s' )", VIN, year, color, bodyType, towing);
					
				stmt.executeUpdate(insertTruck);	
				
			}
			else  {
				String insertMotorcycle = "INSERT INTO Motorcycle (VIN, Year, Color, BodyType, EngineSize)"
						+String.format(" VALUES ('%s', %d,'%s','%s', '%s')", VIN, year, color, bodyType, engineSize);
					
				stmt.executeUpdate(insertMotorcycle);	
				
			}			

			con.close();
			
			%>
			<script> 
		    	alert("Success! new car info saved\n");
	    		window.location.href = "mainPage.jsp";
		    	
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

