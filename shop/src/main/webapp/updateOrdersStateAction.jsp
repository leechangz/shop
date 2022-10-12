<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}

	request.setCharacterEncoding("utf-8");

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	
	System.out.println(ordersNo);
	System.out.println(ordersState);
	
	Orders orders = new Orders();
	OrdersService ordersService = new OrdersService();
	
	orders.setOrdersNo(ordersNo);
	orders.setOrdersState(ordersState);
	
	boolean result = ordersService.modifyOrdersState(orders);
	
	if(result) {
		response.sendRedirect(request.getContextPath() + "/adminOrdersList.jsp");
		System.out.println("성공");
	} else {
		response.sendRedirect(request.getContextPath() + "/adminOrdersList.jsp");
		System.out.println("실패");
	}
%>