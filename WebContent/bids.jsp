<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.lang.*"%>
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
  Display all Vehicles I bid on
 ----------------------------------------------------->  
 
	 <script>
			function bidAgain(vin)
			{										
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
							
				String getList = String.format("Select i.VIN, i.SellerID, i.Make, i.Model, i.Category, a.StartDate, a.EndDate, a.AuctionID, b.BidID, b.BidderID, b.BidAmt, b.BidDate " +
						                       "From Auction.Auction a, Auction.Item i, Auction.Bid b " +
				                               "Where a.VIN = i.VIN and a.AuctionID = b.AuctionID " +
						                              "and a.AuctionID IN (Select b.AuctionID From Auction.Bid b " +
				                                                           "Where b.BidderID = '%s' )" +
					                           "Order by a.AuctionID, b.BidDate DESC", user_id);
								
				ResultSet allCars = stmt.executeQuery(getList);
				
				if (!allCars.next()){
					out.print("You currently have no active Bids");
				}
				else{
					
					//Print Vechicle list as a table 
					String tableTitle = String.format("<caption> My Bids </caption>");
					String tableHeader = " <div style=\"overflow-x:auto;\"> <table class=\"table-format\">"
							   	 + tableTitle	
							   	 +"<tr><th>VIN</th><th>Make</th><th>Model</th><th>Start Date</th><th>End Date</th><th>Bidder ID</th><th>Bid Amount</th><th>Status</th></tr>";
					out.print(tableHeader);
					
					String vinPrev = " ";
					
					do {
						
						String vin = allCars.getString("VIN");
						
						//There might be multiple bids for the same Item (VIN) Display only the latest one
						if (!vin.equals(vinPrev))
						{ String eachRow = String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td> "
						    			, vin, allCars.getString("Make"), allCars.getString("Model"), allCars.getString("StartDate"), allCars.getString("EndDate"), allCars.getString("BidderID"), allCars.getString("BidAmt"));
									    	
					 	out.print(eachRow);
					 	
					 	//Check if given user is the highest bidder
					 	if (user_id.equals(allCars.getString("BidderID")))
					 	{
					 			out.print("You are the highest bidder");
				
						}
					 	else {
				 				out.print("You were outbid");
					 			out.print("<button id=\'button\' onclick=\"bidAgain(\'" + vin +"\') \" class=\'Edit\'>Bid Again</button>");

					 	}
					 	
						out.print("</td></tr>");
						
						}
						
					 	vinPrev = vin;
					 	
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