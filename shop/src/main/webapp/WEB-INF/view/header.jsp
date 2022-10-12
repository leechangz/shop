<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="service.CounterService"%>
<%	
	//오늘 방문자수, 총 방문자수
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	
	// 안나옴 세션생성을 해도 안됨
	// int currentCounter = (Integer)(application.getAttribute("currentCounter"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>Shop_Model1_Goodee50_LeeChangHee</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<head>
<body class="is-preload homepage">
	<div class="container alert alert-success">
		<i class="bi-alarm"></i><span>TODAY : <%=todayCounter %> TOTAL : <%=totalCounter %></span>
	</div>
	<div id="page-wrapper">
		
		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container">

				<!-- Logo -->
					<div id="logo">
						<h1 style="background: #000;"><a href="index.jsp">ChangPing</a></h1>
						<span>by leechagZ</span>
					</div>

				<!-- Nav -->
					<nav id="nav">
						<ul>
							<li class="current"><a href="index.jsp">Home</a></li>
							<li><a href="customerGoodsList.jsp">Goods</a></li>
							<li><a href="customerNoticeList.jsp">Notice</a></li>
							<%
								if(session.getAttribute("user") != null) {
									if(session.getAttribute("user").equals("customer")) {
							%>
										<li>
											<a href="customerIndex.jsp">Members</a>
											<ul>
												<li><a href="customerIndex.jsp">Member Info</a></li>
												<li><a href="customerOrderList.jsp">OrderList</a></li>
											</ul>
										</li>
										<li><a href="logout.jsp">logout</a></li>
							<%
									} else {
							%>
										<li>
											<a href="employeeIndex.jsp">Members</a>
											<ul>
												<li><a href="employeeIndex.jsp">Member Info</a></li>
												<li><a href="adminIndex.jsp">AdminPage</a></li>
											</ul>
										</li>
										<li><a href="logout.jsp">logout</a></li>
							<%
									}
								} else {
							%>
									<li><a href="loginForm.jsp">login</a></li>
							<%
								}
							%>
						</ul>
					</nav>
			</header>
		</div>
	</div>