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

	// 현재 페이지
	int currentPage = 1;
	int lastPage;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 화면에 띄울 페이지수
	final int ROW_PER_PAGE = 10;
	
	// list값 및 lastPage 계산
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> list = new ArrayList<>();
	
	list = ordersService.getOrdersList(ROW_PER_PAGE, currentPage);
	lastPage = ordersService.getOrdersLastPage(ROW_PER_PAGE);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
	
	if(list == null) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">ORDER LIST</h3>
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
			<div style="text-align: center;">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>ORDER_NO</th>
							<th>CUSTOMER_ID</th>
							<th>GOODS_NAME</th>
							<th>ORDER_PRICE</th>
							<th>ORDER_ADDRESS</th>
							<th>ORDER_STATE</th>
							<th>ORDER_DATE</th>
						</tr>
					</thead>
					<tbody>
					<%
						for(Map<String, Object> m : list) {
					%>
							<tr>
								<td><a href="<%=request.getContextPath()%>/adminOrdersOne.jsp?ordersNo=<%=m.get("ordersNo")%>"><%=m.get("ordersNo")%></a></td>
								<td><a href="<%=request.getContextPath()%>/adminCustomerOrderList.jsp?customerId=<%=m.get("customerId")%>"><%=m.get("customerId")%></a></td>
								<td><%=m.get("goodsName")%></td>
								<td><%=m.get("ordersPrice")%></td>
								<td><%=m.get("ordersAddr")%></td>
								<td>
									<form action="<%=request.getContextPath()%>/updateOrdersStateAction.jsp" method="post">
										<input type="hidden" name="ordersNo" value="<%=m.get("ordersNo")%>">
										<select name="ordersState">
											<%
												if(m.get("ordersState").equals("입금전")) {
											%>
													<option value="입금전" selected="selected">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("ordersState").equals("배송준비중")) {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중" selected="selected">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("ordersState").equals("배송중")) {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중" selected="selected">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료" selected="selected">배송완료</option>
											<%
												}
											%>					
										</select>
									<button type="submit" class="btn btn-dark" style="margin-top: 10px;">UPDATE</button>
									</form>
								</td>
								<td><%=m.get("createDate")%></td>
							</tr>
					<%	
						}
					%>
				</table>
				</div>
			</div>
		</div>		
		<div>
		<!-- 페이지 -->
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminOrdersList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
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
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminOrdersList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	