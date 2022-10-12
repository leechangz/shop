<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="vo.*"%>
<%
	if (session.getAttribute("loginCustomer") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	System.out.println(customerId + " <-- id");
	System.out.println(customerPass + " <-- pw");
	
	Customer login = new Customer();
	CustomerService customerService = new CustomerService();
	login.setCustomerId(customerId);
	login.setCustomerPass(customerPass);
	
	Customer customer = new Customer();
	customer = customerService.getCustomerByIdAndPw(login);
	
	session.setAttribute("loginCustomer", customer);
	
	if(session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg1=fail");
	} else {
		session.setAttribute("user", "customer");
		session.setAttribute("id", customer.getCustomerId());
		session.setAttribute("name", customer.getCustomerName());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>