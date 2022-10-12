<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	// 직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	

	request.setCharacterEncoding("utf-8");
	
	// 파라미터 세팅
	String employeeId = request.getParameter("employeeId");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	System.out.println(employeeId);
	System.out.println(noticeTitle);
	System.out.println(noticeContent);
	
	Notice paramNotice = new Notice();
	NoticeService noticeService = new NoticeService();
	
	paramNotice.setEmployeeId(employeeId);
	paramNotice.setNoticeTitle(noticeTitle);
	paramNotice.setNoticeContent(noticeContent);
	
	// 메서드 호출 및 확인
	int result = noticeService.addNotice(paramNotice);
	
	if(result != 0) {
		response.sendRedirect(request.getContextPath() + "/adminNoticeList.jsp");
		System.out.println("성공");
	} else {
		response.sendRedirect(request.getContextPath() + "/adminAddNoticeForm.jsp");
		System.out.println("실패");
	}
%>