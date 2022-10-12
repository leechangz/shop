<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	// 고객만
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");

	// 파라미터
	String customerId = (String)session.getAttribute("id");
	int currentPage = 1;
	int lastPage;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.print(customerId + " <-- customerId");
	
	// 화면에 띄울 페이지수
	final int ROW_PER_PAGE = 10;
	
	// list값 및 lastPage 계산
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> list = new ArrayList<>();
	
	list = ordersService.getOrdersListByCustomer(customerId, ROW_PER_PAGE, currentPage);
	lastPage = ordersService.getOrdersLastPageByCustomer(customerId, ROW_PER_PAGE);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
	
	/* if(list == null) {
		response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
		return;
	} 
	*/
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/customer.JPG); height: 200px; magin: auto;">
			<h3>Customer Page</h3>
		</div>		
		<div style="float: left;">
			<a href="<%=request.getContextPath()%>/customerIndex.jsp" class="btn btn-dark">info</a>
			<a href="<%=request.getContextPath()%>/customerOrderList.jsp?customerId=<%=customerId%>" class="btn btn-dark">orderlist</a>
		</div>
		<form class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div>
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;"><%=session.getAttribute("name")%>'s orderList</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>ORDER_NO</th>
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
									<td><a href="<%=request.getContextPath()%>/customerOrdersOne.jsp?ordersNo=<%=m.get("ordersNo")%>"><%=m.get("ordersNo")%></a></td>
									<td><%=m.get("goodsName")%></td>
									<td><%=m.get("ordersPrice")%></td>
									<td><%=m.get("ordersAddr")%></td>
									<td><%=m.get("ordersState")%></td>
									<td><%=m.get("createDate")%></td>
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
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=currentPage-1%>&customerId=<%=customerId%>">이전</a></li>
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
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=i%>&customerId=<%=customerId%>"><%=i%></a></li>
					<%
						}
					%>
					<!-- 다음 -->
					<%
						if(currentPage < lastPage) {
					%>	
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerOrderList.jsp?currentPage=<%=currentPage+1%>&customerId=<%=customerId%>">다음</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	