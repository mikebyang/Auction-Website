<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" type="text/css" href="css/main.css">

<title>AucEx </title>
</head>
<body>

<p class="app-name">AucEx</p>      

<div class="links">
	<a href=mainPage.jsp>Home</a>
	<a href=addVehicle.jsp>Add Vehicle</a>
	<a href=bids.jsp>My Bids</a>
	<a href=buy.jsp>Buy</a>

</div>
		
<div class="mainPage">

  
<!-- ------------------------------------------------
  Display all Vehicles I owe
 ----------------------------------------------------->  
 
	 <script>
			function placeBid(vin)
			{										
				alert("You will bid on this Vehicle " + vin);
				window.location.href = "placeBid.jsp?vin=" + vin;									   						
			}
     </script>
					
	
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
							
				String pattern = "yyyy-MM-dd HH:mm:ss";
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

				String currentDate = simpleDateFormat.format(new Date());
				System.out.println(currentDate);
			
				String getList = String.format("Select * From Auction.Item i, Auction.Auction a	Where i.SellerID <> '%s' AND i.VIN = a.VIN AND a.EndDate > '%s' and NOT EXISTS (Select b.BidID From Auction.Bid b Where b.AuctionID = a.AuctionID  and b.BidderID = '%s')", user_id, currentDate, user_id);					
				
				ResultSet allCars = stmt.executeQuery(getList);
				
				if (!allCars.next()){
					out.print("You currently have no active items");
				}
				else{
					
					//Print Vechicle list as a table 
					String tableTitle = String.format("<caption> Available Vehicles</caption>");
					String tableHeader = " <div style=\"overflow-x:auto;\"> <table class=\"table-format\">"
							   	 + tableTitle	
							   	 +"<tr><th>VIN</th><th>Make</th><th>Model</th><th>Condition</th><th>Category</th><th>Status</></tr>";
					out.print(tableHeader);
					
					do {
						
						String vin = allCars.getString("VIN");
						  
					    String eachRow = String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td> "
						    			, vin, allCars.getString("Make"), allCars.getString("Model"), allCars.getString("ItemCondition"), allCars.getString("Category"));
									    	
					 	out.print(eachRow);

				 		out.print("<button id=\'button\' onclick=\"placeBid(\'" + vin +"\') \" class=\'Edit\'>Place Bid</button>");	
									 	
						out.print("</td></tr>");
						
					} while(allCars.next() == true);
					
					out.print("</table></div>");
				}

				    
				con.close();
						 

		}		
		catch(Exception e){
				out.println("Failed to retrive Item list ");
		}
						
					
	%>
<!-- ------------------------------------------------
  END Display all Vehicles I owe
 ---------------------------------------------------->
 
  
</br>
</br>
</br>
</br>
</br>
</br>

</div>


<div class="footer">
  <p>Brought to you by: Group 26</p>
  <p>Bhargav Desai (bhd20); Arthur Godich (ag1433) ; Ganapat Tirumalareddy (gt253); Michael Yang (my301)</p>
</div>



</body>
</html>