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
	GoodsService goodsService = new GoodsService();
	List<Goods> list = new ArrayList<Goods>();
	
	list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);	
	lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
	System.out.println(currentPage + " < currentPage");
	System.out.println(ROW_PER_PAGE + " < rowPerPage");
	System.out.println(lastPage + " < lastPage");
	System.out.println(startPage + " < startPage");
	System.out.println(endPage + " < endPage");
	
	
	if(list == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">GOODS LIST</h3>
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
							<th>NO</th>
							<th>NAME</th>
							<th>PRICE</th>
							<th>CREATEDATE</th>
							<th>SOLDOUT</th>
						</tr>
					</thead>
					<tbody>
					<%
						for(Goods g : list) {
					%>
							<tr>
								<td><%=g.getGoodsNo()%></td>
								<td><a href="<%=request.getContextPath()%>/adminGoodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>"><%=g.getGoodsName()%></a></td>
								<td><%=g.getGoodsPrice()%></td>
								<td><%=g.getCreateDate()%></td>
								<td>
									<form action="<%=request.getContextPath()%>/updateGoodsSoldOutAction.jsp" method="post" class="form-inline">
										<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
										<select name="soldOut" class="form-control">
											<%
												if(g.getSoldOut().equals("N")) {
											%>
													<option value="Y">Y</option>
													<option value="N" selected="selected">N</option>
											<%
												} else {
											%>
													<option value="Y" selected="selected">Y</option>
													<option value="N">N</option>
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
			<a href="<%=request.getContextPath()%>/addGoodsForm.jsp" class="btn btn-dark" style="float: right;">INSERT</a>
		</div>
		<div>
		<!-- 페이지 -->
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
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
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	