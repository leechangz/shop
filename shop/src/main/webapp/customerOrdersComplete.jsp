<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	//고객만
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	String customerId = (String)session.getAttribute("id");
	OrdersService ordersService = new OrdersService();
	
	System.out.println(customerId + " <-- customerId");
	
	Map<String, Object> map = ordersService.getNewOrdersOne(customerId);
	Orders orders = (Orders)map.get("orders");
	
	/* if(orders == null) {
		response.sendRedirect(request.getContextPath() + "/.jsp");
		return;
	} */
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/customer.JPG); height: 200px; magin: auto;">
			<h3></h3>
		</div>
		<form class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div>
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;"><%=session.getAttribute("name")%>'s Orders Complete</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered">
						<tr>
							<th>ORDER_NO</th>
							<th>GOODS_NAME</th>
							<th>ORDER_PRICE</th>
							<th>ORDER_ADDRESS</th>
							<th>ORDER_STATE</th>
							<th>ORDER_DATE</th>
						</tr>
						<tr>
							<td><%=orders.getOrdersNo()%></td>
							<td><%=map.get("goodsName")%></td>
							<td><%=orders.getOrdersPrice()%></td>
							<td><%=orders.getOrdersAddr()%></td>
							<td><%=orders.getOrdersState()%></td>
							<td><%=orders.getCreateDate()%></td>
						</tr>
					</table>
				</div>
			</div>
			<div>
				<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" class="btn btn-dark">add purchase</a>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	