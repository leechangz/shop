<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<%@ page import="vo.*" %>
<%
	// 고객이 아닐 시
	if (!(session.getAttribute("user").equals("customer"))) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 파라미터 세팅
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int reviewGrade = Integer.parseInt(request.getParameter("reviewGrade"));
	String reviewContent = request.getParameter("reviewContent");
	String customerId = (String)session.getAttribute("id");
	
	System.out.println(goodsNo);
	System.out.println(ordersNo);
	System.out.println(reviewGrade);
	System.out.println(reviewContent);
	System.out.println(customerId);
	
	// 메서드 호출 및 확인
	ReviewService reviewService = new ReviewService();
	Review review = new Review();
	review.setOrdersNo(ordersNo);
	review.setReviewContent(reviewContent);
	review.setReviewGrade(reviewGrade);
	
	int result = reviewService.addReviewByCustomer(review);
	
	if(result == 0) {
		response.sendRedirect(request.getContextPath() + "/customerGoodsOne.jsp?goodsNo=" + goodsNo);
	} else {
		response.sendRedirect(request.getContextPath() + "/customerGoodsOne.jsp?goodsNo=" + goodsNo);
	}

%>
