<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	// 전체 공개
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String tent = "AND g.goods_type = 'tent'";
	String furniture = "AND g.goods_type = 'furniture'";
	String others = "AND g.goods_type = 'others'";
	
	GoodsService goodsService = new GoodsService();
	ReviewService reviewService = new ReviewService();
	
	Map<String, Object> map =goodsService.getGoodsAndImgOne(goodsNo);
	
	// review
	List<Map<String, Object>> list = reviewService.getReviewByGoods(goodsNo);
	
	// 확인
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/customerGoodsList.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron" style="background-image: url(<%=request.getContextPath()%>/images/campList.JPG); height: 150px; magin: auto;">
			<h1 style="color: #fff;">Camping</h1>
		</div>
		
		<!-- 종류선택 sort, page, word초기화 -->
		<div class="container" style="float: left; margin-top: 30px;">
			<ul>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" 
					class="btn btn-primary">
					All
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=tent%>" 
					class="btn btn-primary">
					Tent
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=furniture%>" 
					class="btn btn-primary">
					Furniture
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=others%>" 
					class="btn btn-primary">
					Others
					</a>
				</li>
			</ul>
		</div>
		
		<!-- 제품 상세 -->
		<div class="container text center">
			<div class="row">
				<div class="col-6">
					<section class="box feature">
						<a href="#" class="image featured"><img src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>" alt="" /></a>
					</section>
				</div>
				<div class="col-6" style="background-color: #fff; height: 550px;">
					<table class="table table-bordered">
						<tr height="100">
							<th>NAME</th>
							<td><h3><%=map.get("goodsName")%></h3></td>
						</tr>
						<tr height="100">
							<th>PRICE (원)</th>
							<td><h4><%=map.get("goodsPrice")%></h4></td>
						</tr>
						<tr height="100">
							<th>Detail</th>
							<td><%=map.get("goodsContent")%></td>
						</tr>
						<tr height="100">
							<th>등록날짜</th>
							<td><%=map.get("goodsCreateDate")%></td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="float: right;">
								<form action="<%=request.getContextPath()%>/customerOrders.jsp" method="post" class="form-inline">
									<input type="hidden" name="goodsNo" value="<%=map.get("goodsNo")%>">
									<label for="sel" style="margin-right: 30px;">수량</label>
									<select name="ordersQuantity" class="form-control" style="margin-right: 30px;">
										<%
											for(int i=1; i<11; i++) {
										%>
												<option value="<%=i%>"><%=i%></option>
										<%	
											}
										%>
									</select>
									<button class="btn btn-dark" style="font-size: 36px;">Buy</button>
								</form>
								</div>
							</td>
						</tr>
					</table>			
				</div>	
			</div>
		</div>
		<div style="text-align: left;">
			<form class="w-20 border p-3 bg-white shadow rounded">
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;">Goods Review</h3>
				</div>
				<%
					for(Map<String, Object> m : list) {
				%>
						<div style="margin-bottom: 10px;">
							<div class="border">
								<div>
									<h5><%=m.get("customerId")%></h5>
								</div>
								<div>
									<h5>
										<%
											int star = (Integer)m.get("reviewGrade");
											for(int i=0; i<star; i++) {
										%>
												★
										<%
											}
											for(int i=0; i<5-star; i++) {
										%>
												☆
										<%
											}
										%>
									</h5>
								</div>
								<div>
									<p><%=m.get("reviewContent")%></p>
								</div>
								<div>
									<p>date : <%=m.get("createDate")%></p>
								</div>
							</div>
						</div>
				<%
					}
				%>
			</form>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	