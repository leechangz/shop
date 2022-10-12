<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	//고객만
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String customerId = request.getParameter((String)session.getAttribute("id"));
	OrdersService ordersService = new OrdersService();
	
	Map<String, Object> map =ordersService.getOrdersOne(ordersNo);
	
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
		return;
	}
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
		<form action="<%=request.getContextPath()%>/addReviewAction.jsp" method="post" class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div>
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;"><%=session.getAttribute("name")%>'s Order Detail</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered">
						<tr>
							<th>ORDER_NO</th>
							<td><%=map.get("ordersNo")%></td>
						</tr>
						<tr>
							<th>GOODS_NAME</th>
							<td><%=map.get("goodsName")%></td>
						</tr>
						<tr>
							<th>ORDERS_PRICE</th>
							<td><%=map.get("ordersPrice")%> (원)</td>
						</tr>
						<tr>
							<th>ORDERS_STATE</th>
							<td><%=map.get("ordersState")%></td>
						</tr>
						<tr>
							<th>ORDERS_DATE</th>
							<td><%=map.get("createDate")%></td>
						</tr>
						<tr>
							<th>Review</th>
							<td>
								<div class="row">
									<div class="col-9">
										<input type="hidden" name="goodsNo" value="<%=map.get("goodsNo")%>">
										<input type="hidden" name="ordersNo" value="<%=map.get("ordersNo")%>">
										<textarea name="reviewContent"></textarea>
									</div>
									<div class="col-3">
										<label for="sel" style="margin-right: 20px; font-size: 24px;">Rank</label>
										<select name="reviewGrade" class="form-control" style="margin-right: 30px;">
											<%
												for(int i=1; i<=5; i++) {
											%>
													<option value="<%=i%>"><%=i%></option>
											<%	
												}
											%>
										</select>
										<button type="submit" class="btn btn-dark" style="margin-top:10px;">insert</button>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	