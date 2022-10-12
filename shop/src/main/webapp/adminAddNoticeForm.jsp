<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	String employeeId = (String)session.getAttribute("id");

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
			<!-- 공지사항 추가 form -->
			<div class="col-sm-10">
				<div class="container" style="background-color: #fff;">
					<form action="<%=request.getContextPath()%>/adminAddNoticeAction.jsp" method="post">
						<table class="table table-bordered">
							<tr>
								<td><h5>Writer</h5></td>
								<td><input type="text" name="employeeId" value="<%=employeeId%>" class="form-control" readonly="readonly"></td>
							</tr>
							<tr>
								<td><h5>Title</h5></td>
								<td colspan="3"><input type="text" name="noticeTitle"></td>
							</tr>
							<tr>
								<td><h5>Content</h5></td>
								<td colspan="3"><textarea name="noticeContent"></textarea></td>
							</tr>
						</table>
						<div style="float: right;">
							<button type="submit" class="btn btn-dark">INSERT</button>
							<a href="<%=request.getContextPath()%>/adminNoticeList.jsp" class="btn btn-dark">CANCEL</a>	
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	