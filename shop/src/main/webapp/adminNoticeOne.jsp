<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%	
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeService noticeService = new NoticeService();
	Notice notice = noticeService.getNoticeOne(noticeNo);

%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">NOTICE ONE</h3>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<ul style="list-style-type: none; margin-bottom: 50px;">
					<li><h3>MENU</h3></li>
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminIndex.jsp" class="btn btn-dark">Employee</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminCustomerList.jsp" class="btn btn-dark">Customer</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminGoodsList.jsp" class="btn btn-dark">Goods</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminOrdersList.jsp" class="btn btn-dark">Orders</a></li>
					
					<li style="list-style-type: none; margin-bottom: 50px; margin-top: 50px;"><a href="<%=request.getContextPath()%>/adminNoticeList.jsp" class="btn btn-dark">Notice</a></li>
				</ul>
			</div>
			<div class="col-sm-10">
				<div class="container" style="background-color: #fff;">
					<table class="table table-bordered">
						<tr>
							<td><h5>No</h5></td>
							<td><%=notice.getNoticeNo()%></td>
							<td><h5>Writer</h5></td>
							<td><%=notice.getEmployeeId()%></td>
						</tr>
						<tr>
							<td><h5>Title</h5></td>
							<td colspan="3"><h5><%=notice.getNoticeTitle()%></h5></td>
						</tr>
						<tr>
							<td><h5>Content</h5></td>
							<td colspan="3"><%=notice.getNoticeContent()%></td>
						</tr>
						<tr>
							<td><h5>Upload_Date</h5></td>
							<td colspan="3"><%=notice.getCreateDate()%></td>
						</tr>
					</table>
					<div style="float: right;">
						<a href="<%=request.getContextPath()%>/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>" class="btn btn-dark">UPDATE</a>
						<a href="<%=request.getContextPath()%>/deleteNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo()%>" class="btn btn-dark">DELETE</a>	
					</div>
				</div>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	