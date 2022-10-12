<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	// 고객만
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	// 파라미터 세팅
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	String customerName = request.getParameter("customerName");
	String customerAddress = request.getParameter("customerAddr") + " / " + request.getParameter("customerAddrDetail");
	String customerTelephone = request.getParameter("customerTelephone");
	
	System.out.println(customerId + " <-- customerId");
	System.out.println(customerPass + " <-- customerPass");
	System.out.println(customerName + " <-- customerName");
	System.out.println(customerAddress + " <-- customerAddress");
	System.out.println(customerTelephone + " <-- customerTelephone");
	
	Customer customer = new Customer();
	CustomerService customerService = new CustomerService();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerTelephone(customerTelephone);
	
	// 메서드 호출 후 확인
	int result = customerService.modifyCustomer(customer);
	
	if(result != 0) {
		System.out.println(result + "성공");
		session.setAttribute("loginCustomer", customer);
		response.sendRedirect(request.getContextPath() + "/customerIndex.jsp");
	} else {
		System.out.println(result + "실패");
		response.sendRedirect(request.getContextPath() + "/updateCustomerForm.jsp");
	}
%>