<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="vo.*" %>
<%
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
			
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	// 디버깅
	System.out.print(customer.getCustomerId() + "id");
	System.out.print(customer.getCustomerPass() + "pw");
	
	CustomerService customerService = new CustomerService();
	customerService.removeCustomer(customer);
	
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>