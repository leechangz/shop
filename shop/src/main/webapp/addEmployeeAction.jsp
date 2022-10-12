<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	//로그인되어 있을 시 차단
	if (session.getAttribute("user") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 파라미터 생성
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	String employeeName = request.getParameter("employeeName");
	
	System.out.println(employeeId + " <-- employeeId");
	System.out.println(employeePass + " <-- employeePass");
	System.out.println(employeeName + " <-- employeeName");
	
	Employee employee = new Employee();
	EmployeeService employeeService = new EmployeeService();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	employee.setEmployeeName(employeeName);
	
	// 메서드 호출 및 확인
	boolean result = employeeService.addEmployee(employee);
	
	if(result) {
		System.out.println(result + "성공");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	} else {
		System.out.println(result + "실패");
		response.sendRedirect(request.getContextPath() + "/addEmployee.jsp");
	}
%>
