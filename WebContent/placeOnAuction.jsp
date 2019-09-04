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

     <!------------------------------------------------------------------
     This function will return any parameter passed to this page via HTTP
     -------------------------------------------------------------------->    	
		<script type="text/javascript">
		function getAllUrlParams(url) {

			  // get query string from url (optional) or window
			  var queryString = url ? url.split('?')[1] : window.location.search.slice(1);

			  // we'll store the parameters here
			  var obj = {};

			  // if query string exists
			  if (queryString) {

			    // stuff after # is not part of query string, so get rid of it
			    queryString = queryString.split('#')[0];

			    // split our query string into its component parts
			    var arr = queryString.split('&');

			    for (var i = 0; i < arr.length; i++) {
			      // separate the keys and the values
			      var a = arr[i].split('=');

			      // set parameter name and value (use 'true' if empty)
			      var paramName = a[0];
			      var paramValue = typeof (a[1]) === 'undefined' ? true : a[1];

			      // (optional) keep case consistent
		//	      paramName = paramName.toLowerCase();
		//	      if (typeof paramValue === 'string') paramValue = paramValue.toLowerCase();

			      // if the paramName ends with square brackets, e.g. colors[] or colors[2]
			      if (paramName.match(/\[(\d+)?\]$/)) {

			        // create key if it doesn't exist
			        var key = paramName.replace(/\[(\d+)?\]/, '');
			        if (!obj[key]) obj[key] = [];

			        // if it's an indexed array e.g. colors[2]
			        if (paramName.match(/\[\d+\]$/)) {
			          // get the index value and add the entry at the appropriate position
			          var index = /\[(\d+)\]/.exec(paramName)[1];
			          obj[key][index] = paramValue;
			        } else {
			          // otherwise add the value to the end of the array
			          obj[key].push(paramValue);
			        }
			      } else {
			        // we're dealing with a string
			        if (!obj[paramName]) {
			          // if it doesn't exist, create property
			          obj[paramName] = paramValue;
			        } else if (obj[paramName] && typeof obj[paramName] === 'string'){
			          // if property does exist and it's a string, convert it to an array
			          obj[paramName] = [obj[paramName]];
			          obj[paramName].push(paramValue);
			        } else {
			          // otherwise add the property
			          obj[paramName].push(paramValue);
			        }
			      }
			    }
			  }

			  return obj;
			}

		</script>
     <!------------------------------------------------------------------
     END of function
     -------------------------------------------------------------------->  
	<%
		String vin = request.getParameter("vin");
		out.print(vin);
			
    %>	
    
    
  	<div class="form">
  		
  		<p class='message-red'>Place your Vehicle on Auction</p>
  		
   		<form class="post-offer-form" method="get" name=myform action="storeAuction.jsp">
      
     		<input type="text" placeholder="VIN" name="VIN" id="VIN" readonly value=""/>
  			
      		<input type="number" placeholder="Starting Price" name="price" min=0.00 max=999999.99 step=0.01 value="100.00"/> 
      		
      		<input type="date" id="startDate" name="startDate" />
      		<input type="text" placeholder="End Date" id="endDate" name="endDate"/>    
      		 		
      		<button>submit</button>
      
      		<p class="message">Back to homepage? <a href="mainPage.jsp">Go back</a></p>
    	</form>

		<script type="text/javascript">
			var vin = getAllUrlParams().vin;
			document.getElementById("VIN").value = vin;
			
			var d = new Date();
			var yyyy = d.getFullYear();
			var mm = String(d.getMonth() + 1);  // January is 0  
			var dd = d.getDate();			
			
			document.getElementById("startDate").value = yyyy + '-' + mm + '-' + dd;
			document.getElementById("endDate").value = "2019-06-01";
			
		</script>

	</div>
		
</body>
</html>