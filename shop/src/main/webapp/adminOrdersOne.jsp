<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	OrdersService ordersService = new OrdersService();
	
	Map<String, Object> map =ordersService.getOrdersOne(ordersNo);
	
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">ORDER ONE</h3>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<ul style="list-style-type: none; margin-bottom: 50px;">
					<li><h3>MENU</h3></li>
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminIndex.jsp" class="btn btn-dark">Employee</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminCustomerList.jsp" class="btn btn-dark">Customer</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminGoodsList.jsp" class="btn btn-dark">Goods</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminOrdersList.jsp" class="btn btn-dark">Orders</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminNoticeList.jsp" class="btn btn-dark">Notice</a></li>
				</ul>
			</div>			
			<div class="col-sm-10">
				<table class="table table-bordered">
					<tr>
						<th>ORDER_NO</th>
						<td><%=map.get("ordersNo")%></td>
					</tr>
					<tr>
						<th>CUSTOMER_ID</th>
						<td><%=map.get("customerId")%></td>
					</tr>
					<tr>
						<th>GOODS_NAME</th>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<th>GOODS_PRICE</th>
						<td><%=map.get("goodsPrice")%> (원)</td>
					</tr>
					<tr>
						<th>ORDERS_STATE</th>
						<td><%=map.get("ordersState")%></td>
					</tr>
					<tr>
						<th>ORDERS_DATE</th>
						<td><%=map.get("createDate")%></td>
					</tr>
				</table>
			</div>
		</div>
		<div style="margin-bottom: 20px; position: relative; left: 450px;">
			<a href="<%=request.getContextPath()%>/" class="btn btn-dark">DELETE</a>	
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	