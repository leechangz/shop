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

	//페이징값
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	
	EmployeeService employeeService = new EmployeeService();
	List<Employee> list = new ArrayList<Employee>();
	list = employeeService.getEmployeeList(ROW_PER_PAGE, currentPage);
	
	int lastPage = employeeService.getEmployeeLastPage(ROW_PER_PAGE);
	System.out.print("lastPage : " + lastPage);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<!-- Main -->
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">EMPLOYEE LIST</h3>
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
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>EMPLOYEEID</th>
							<th>EMPLOYEENAME</th>
							<th>CREATEDATE</th>
							<th>EMPLOYEEACTIVE</th>
						</tr>
					</thead>
					<tbody>
					<%
						for(Employee e : list) {
					%>
							<tr>
								<td><%=e.getEmployeeId()%></td>
								<td><%=e.getEmployeeName()%></td>
								<td><%=e.getCreateDate()%></td>
								<td>
									<form action="<%=request.getContextPath()%>/updateEmployeeActiveAction.jsp" method="post" class="form-inline">
										<input type="hidden" name="employeeId" value="<%=e.getEmployeeId()%>">
										<select name="active" class="form-control">
											<%
												if(e.getActive().equals("N")) {
											%>
													<option value="Y" class="form-control">Y</option>
													<option value="N" class="form-control" selected="selected">N</option>
											<%
												} else {
											%>
													<option value="Y" class="form-control" selected="selected">Y</option>
													<option value="N" class="form-control">N</option>
											<%
												}
											%>
										</select>
									<button type="submit" class="btn btn-dark" style="margin-top: 10px; margin-left: 30px;">UPDATE</button>
									</form>
								</td>
							</tr>
					<%	
						}
					%>
				</table>
			</div>
		</div>

		<div>
		<!-- 페이지 -->
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminIndex.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					}
				%>
				
				<!-- 페이지번호 -->
				<%
					for (int i = startPage; i <= endPage; i++) {
						if (lastPage < endPage) {
	        				endPage = lastPage;
	    				}
				%>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminIndex.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminIndex.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	
<%@ include file="/WEB-INF/view/footer.jsp"%>