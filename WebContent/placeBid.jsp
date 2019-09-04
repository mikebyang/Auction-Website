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

     
      <script>
			function storeBid(vin)
			{										
				alert("Vehicle will be placed on auction " + vin);
				window.location.href = "storeBid.jsp?vin=" + vin;									   						
			}
     </script>
     
	<%
	String vin = request.getParameter("vin");
			
    %>	
 
 	<%	
		try{
								
								
				//Create a connection string
				String url = "jdbc:mysql://cs336db.cmnipzd7m5gz.us-east-2.rds.amazonaws.com:3306/Auction";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");

				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "g26cs336", "ag2400DB");
								
				//Create a SQL statement
				Statement stmt = con.createStatement();
							
				String getList = String.format("SELECT i.VIN, i.Make, i.Model, i.Category, a.StartingPrice, a.StartDate, a.EndDate, a.AuctionID, b.* "
						                       + "FROM Auction.Item i JOIN Auction.Auction a on i.VIN = a.VIN LEFT JOIN Auction.Bid b on a.AuctionID = b.AuctionID"
						                       + " WHERE i.VIN = '%s' and a.EndDate >= now() Order By b.BidDate DESC", vin);
					
				
				ResultSet allBids = stmt.executeQuery(getList);
				

				allBids.beforeFirst();
				if (!allBids.next()){
					out.print("You currently have no active items");
				}
				else{
					
					String currentBid = "";
					if (allBids.getObject("BidAmt") == null)
					{		
						currentBid = allBids.getString("StartingPrice");
						
					} 
					else{
						currentBid = allBids.getString("BidAmt");
						
					}
					
					// Compute next Bid amount by adding inclrement amount $10 
					float nextBid = Float.valueOf(currentBid.trim()).floatValue() + 10;
					String nextBidStr = String.format("%.2f",nextBid);
					
					//Print Vechicle list as a table 
			    	String formHeader = " <div class=\"form\"> <p class=\"message-red\">Place Bid</p>"	
    	                    + "<form class=\"post-offer-form\" method=\"get\" name=myform action=\"storeBid.jsp\">";
    				String formBody = "<p>Make: " + allBids.getString("Make") + "</p>" 
    						        + "<p>Model: " + allBids.getString("Model") + "</p>" 
    						        +"<input type=\"hidden\" name=\"auctionID\" value=" + allBids.getString("AuctionID") + ">" 
    						      	+ "<p>Auction Ends: " + allBids.getString("EndDate") + "</p>"
    						     	+ "<p>Current Bid: " + currentBid  + "</p>" 
    						     	+ "<p>Your New Bid: </p>" 
    						     	+"<input type=\"number\" id=\"newBid\" name=\"newBid\" min=" + nextBidStr + "step=0.01 value=" + nextBidStr + "><br>" 
    						     	+ "<button>submit</button>"
    						     	+ "<p class=\"message\">Back to homepage? <a href=\"mainPage.jsp\">Go back</a></p>"
    						        ;
    	                    
    				out.print(formHeader);
    				out.print(formBody);
					
    				// Do not forget to close form
					out.print("</form></div>"); 
				}

				    
				con.close();
						 

		}		
		catch(Exception e){
				out.println("Failed to retrive Item list ");
		}
						
					
	%>   
 
	
		
</body>
</html>