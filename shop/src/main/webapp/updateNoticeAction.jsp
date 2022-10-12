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

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	System.out.println(noticeNo);
	System.out.println(noticeTitle);
	System.out.println(noticeContent);
	
	Notice paramNotice = new Notice();
	NoticeService noticeService = new NoticeService();
	
	paramNotice.setNoticeNo(noticeNo);
	paramNotice.setNoticeTitle(noticeTitle);
	paramNotice.setNoticeContent(noticeContent);
	
	int result = noticeService.modifyNotice(paramNotice);
	
	if(result != 0) {
		response.sendRedirect(request.getContextPath() + "/adminNoticeOne.jsp?noticeNo=" + noticeNo);
		System.out.println("성공");
	} else {
		response.sendRedirect(request.getContextPath() + "/updateNoticeOne.jsp?noticeNo=" + noticeNo);
		System.out.println("실패");
	}
%>