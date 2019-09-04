<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>AucEx </title>
</head>


<body>
  	<div class="form">
  		
  		<p class='message-red'>Add Vehicle</p>
   		<form class="post-offer-form" method="post" action="storeVehicleInfo.jsp">
      
     		<input type="text" placeholder="VIN" name="VIN"/>
      		<%-- Drop down menu  --%>
      		 <select name="category">
    			<option value="car">Car</option>
    			<option value="truck">Truck</option>
    			<option value="motorcycle">Motorcycle</option>
  			</select>	 
  			
      		<input type="text" placeholder="Make" name="make"/>       
      		<input type="text" placeholder="Model" name="model"/>
      		<input type="text" placeholder="Year" name="year"/>
      		<input type="text" placeholder="Description" name="description"/>
      		<input type="text" placeholder="Condition" name="condition"/>
      		<input type="text" placeholder="Color" name="color"/>
      		<input type="text" placeholder="Interior" name="interior"/>
      		<input type="text" placeholder="Navigation" name="navigation"/>
      		<input type="text" placeholder="Drive" name="drive"/>
      		
      		<input type="text" placeholder="Engine size" name="engineSize"/>
      		<input type="text" placeholder="Body Type" name="bodyType"/>
      		<input type="text" placeholder="Towing power" name="towing"/>
      		
      		<button>submit</button>
      
      		<p class="message">Back to homepage? <a href="mainPage.jsp">Go back</a></p>
    	</form>
	</div>
</body>
</html>
