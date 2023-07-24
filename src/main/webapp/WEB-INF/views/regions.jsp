<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="eStoreProduct.model.admin.output.RegionsOutput, java.util.List" %>
    
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Region List</title>
    
    
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" type="text/css" href="./css/regions.css">

 
    <script src="./js/regions.js"></script>
   
</head>
<div id="content">
<body>
<h3 style="text-align:center"><b>Shipping Area Configuration</b></h3>
<form>
<input id="name" value="name" type="text">
<input id="pinFrom" value="pinFrom" type="text">
<input id="pinTo" value="pinTo" type="text">
<input id="surCharge" value="surCharge" type="text">
<input id="priceWavier" value="priceWavier" type="text">
</form>
<div class="add-button">
        <a class="add-region">Add Regions</a>
    </div>
    <table>
        <tr>
            <th style="text-align: center; vertical-align: middle;">Region ID</th>
            <th style="text-align: center; vertical-align: middle;">Region Name</th>
            <th style="text-align: center; vertical-align: middle;">Pin From</th>
            <th style="text-align: center; vertical-align: middle;">Pin To</th>
            <th style="text-align: center; vertical-align: middle;">Surcharge</th>
            <th style="text-align: center; vertical-align: middle;">Price Waiver</th>
            <th >         </th>
        </tr>
        <%-- Iterate over the list of regions and generate table rows --%>
        <%
            List<RegionsOutput> regions = (List<RegionsOutput>) request.getAttribute("regionList");

            for (RegionsOutput region : regions) {
        %>
        <tr>
            <td><%= region.getRegionId() %></td>
            <td><%= region.getRegionName() %></td>
            <td><%= region.getRegionPinFrom() %></td>
            <td><%= region.getRegionPinTo() %></td>
            <td><%= region.getRegionSurcharge() %></td>
            <td><%= region.getRegionPriceWaiver() %></td>
            <td><button onclick='removereg("<%= region.getRegionId() %>")' class="removereg">remove</button></td>
        </tr>
        <%-- End of loop --%>
        <% } %>
    </table>
</body>
</div>
</html>