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

	request.setCharacterEncoding("utf-8");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = request.getParameter("customerId");
	int ordersQuantity = Integer.parseInt(request.getParameter("ordersQuantity"));
	int ordersPrice = Integer.parseInt(request.getParameter("ordersPrice"));
	String ordersAddr = request.getParameter("ordersAddr") + " / " + request.getParameter("ordersAddrDetail");
	String ordersState = request.getParameter("ordersState");
	
	Orders orders = new Orders();
	OrdersService ordersService = new OrdersService();
	
	// 파라미터 세팅
	orders.setGoodsNo(goodsNo);
	orders.setCustomerId(customerId);
	orders.setOrdersQuantity(ordersQuantity);
	orders.setOrdersPrice(ordersPrice);
	orders.setOrdersAddr(ordersAddr);
	orders.setOrdersState(ordersState);
	
	System.out.println(orders.toString());
	
	// 주문추가
	int result = ordersService.addCustomerOrders(orders);
	
	if(result == 0) {
		response.sendRedirect(request.getContextPath() + "/customerOrders.jsp");
	} else {
		response.sendRedirect(request.getContextPath() + "/customerOrdersComplete.jsp");
	}
	
%>