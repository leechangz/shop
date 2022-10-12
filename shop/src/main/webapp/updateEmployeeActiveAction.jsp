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

	String employeeId = request.getParameter("employeeId");
	String active = request.getParameter("active");
	
	System.out.println(employeeId);
	System.out.println(active);
	
	Employee employee = new Employee();
	EmployeeService employeeService = new EmployeeService();
	
	employee.setEmployeeId(employeeId);
	employee.setActive(active);
	
	employeeService.modifyEmployeeActive(employee);
	
	
	response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
%>