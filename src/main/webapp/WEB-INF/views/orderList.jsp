<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="eStoreProduct.model.admin.entities.orderModel,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order List</title>

<link rel="stylesheet" type="text/css" href="./css/orderList.css">

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    <script src="./js/orderList.js"></script>
</head>
<body>
<%String s=(String)request.getAttribute("token"); %>
 <p id="tokenHolder" style="display: none;"><%=s %></p>
 <%String s1=(String)request.getAttribute("token1"); %>
 <p id="tokenHolder1" style="display: none;"><%=s1 %></p>
 <% 
   int p = 0;
   Integer pageAttr = (Integer)request.getAttribute("page");
   if (pageAttr != null && pageAttr instanceof Integer) {
       p = (int) pageAttr;
   }
%>
<p id="pageHolder" style="display: none;"><%= p %></p>
 </p>

<div id="spinner-container">
  <div id="spinner"></div>
</div>
<div class="container mt-5">
    <h2>Order List</h2>
    <div class="filters">
      
        <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" onchange="setMinEndDate()">
            <label for="endDate">End Date:</label>
        <input type="date" id="endDate" name="endDate">
        <button onclick="applyDateFilter()">Apply Filters</button>
        
  
        <label for="processedStatusFilter">Processed Status Filter:</label>
        <% if (s != null && s.equals("All")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
            <option id="All" value="All">All</option>
            <option id="processed" value="processed">Processed</option>
            <option id="unprocessed" value="unprocessed">Unprocessed</option>
        </select>
        <%} %>
        <%if(s != null && s.equals("ProcessedPaginationToken")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
        <option id="processed" value="processed">Processed</option>
            <option id="All" value="All">All</option>
            <option id="unprocessed" value="unprocessed">Unprocessed</option>
        </select>
        <%} %>
        <%if(s != null && s.equals("UnProcessedPaginationToken")){ %>
        <select id="processedStatusFilter" onchange="processedStatusFilter()">
        	 <option id="unprocessed" value="unprocessed">Unprocessed</option>
            <option id="All" value="All">All</option>
            <option id="processed" value="processed">Processed</option>
        </select>
        <%} %>
        
       
    </div>
    <div class="container mt-5">
    <!-- Existing code -->
    
    <button id="viewStatisticsBtn" class="btn btn-primary">View Statistics</button>
    
</div>
</div>

<div class="container mt-5">
    <table id="tableData" class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr  class="order-row" >
                <th style="text-align: center; vertical-align: middle;">Order ID</th>
                <th style="text-align: center; vertical-align: middle;">Customer ID</th>
                <th style="text-align: center; vertical-align: middle;">Payment Id</th>
                <th style="text-align: center; vertical-align: middle;">Order Date</th>
                <th style="text-align: center; vertical-align: middle;">Total</th>
                <th style="text-align: center; vertical-align: middle;">GST</th>
                <th style="text-align: center; vertical-align: middle;">Payment Reference</th>
                <th style="text-align: center; vertical-align: middle;">Payment Mode</th>
                <th style="text-align: center; vertical-align: middle;">Payment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipment Status</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Address</th>
                <th style="text-align: center; vertical-align: middle;">Shipping Pincode</th>
         
                <th style="text-align: center; vertical-align: middle;">Shipment Date</th>
                <th style="text-align: center; vertical-align: middle;">Processed By</th>
            </tr>
        </thead>
        <tbody>
         <% List<orderModel> orders=(List<orderModel>)request.getAttribute("orders"); %>
            <% for (orderModel order : orders) {%>
            <tr>
                <td><%= order.getId() %></td>
                <td><%= order.getOrdr_cust_id() %></td>
                <td><%= order.getBillNumber() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getTotal() %></td>
                <td><%= order.getGst() %></td>
                <td><%= order.getPaymentReference() %></td>
                <td><%= order.getPaymentMode() %></td>
                <td><%= order.getPaymentStatus() %></td>
                 <td><%= order.getShipment_status() %></td>
                <td><%= order.getShippingAddress() %></td>
                <td><%= order.getShippingPincode() %></td>
           
                <td><%= order.getShipmentDate() %></td>
                <td>
                    <% if (order.getOrdr_processedby() == null) { %>
                        <button id="red-button" class="btn btn-danger" data-order-id="<%= order.getId() %>">Unprocessed</button>
                    <% } else { %>
                        <button class="btn <%= (order.getOrdr_processedby() == null) ? "btn-danger" : "btn-success" %>" data-order-id="<%= order.getId() %>"><%= order.getOrdr_processedby() %></button>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
        
    </table>
    
    <div class="pagination">
    <c:if test="${page > 0}">
        <a href="javascript:navigateToPage(${page - 1})">Previous</a>
    </c:if>
    
    <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
        <c:choose>
            <c:when test="${pageNumber == page}">
                <span class="current-page">${pageNumber + 1}</span>
            </c:when>
            <c:otherwise>
                <a href="javascript:navigateToPage(${pageNumber})">${pageNumber + 1}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <c:if test="${page < totalPages - 1}">
        <a href="javascript:navigateToPage(${page + 1})">Next</a>
    </c:if>
</div>
</div>


<!-- Modal -->
<div id="statisticsModal" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Orders Statistics</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <canvas id="orderChart" width="400" height="200"></canvas>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



 


</body>
</html>