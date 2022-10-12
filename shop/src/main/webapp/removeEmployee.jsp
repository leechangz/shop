<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="vo.*" %>
<%
	if (session.getAttribute("loginEmployee") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
			
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	
	// 디버깅
	System.out.print(employee.getEmployeeId() + "id");
	System.out.print(employee.getEmployeePass() + "pw");
	
	EmployeeService employeeService = new EmployeeService();
	employeeService.removeEmployee(employee);
	
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
%>