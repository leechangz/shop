<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	GoodsService goodsService = new GoodsService();
	
	Map<String, Object> map =goodsService.getGoodsAndImgOne(goodsNo);
	
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/adminGoodsList.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">GOODS UPDATE</h3>
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
				<form action="<%=request.getContextPath()%>/updateGoodsAction.jsp" 
					  method="post" enctype="multipart/form-data">
					<table class="table table-bordered">
						<tr>
							<th>NO</th>
							<td><input type="text" name="goodsNo" value="<%=map.get("goodsNo")%>" class="form-control" readonly="readonly"></td>
						</tr>
						<tr>
							<th>NAME</th>
							<td><input type="text" name="goodsName" value="<%=map.get("goodsName")%>" class="form-control"></td>
						</tr>
						<tr>
							<th>PRICE (원)</th>
							<td><input type="text" name="goodsPrice" value="<%=map.get("goodsPrice")%>" class="form-control"></td>
						</tr>
						<tr>
							<th>품절여부</th>
							<td>
								<input type="hidden" name="soldOut" value="<%=map.get("soldOut")%>">
								<%=map.get("soldOut")%>
							</td>
						</tr>
						<tr>
							<th>TYPE</th>
							<td>
								<select name="goodsType">
									<option value="tent" selected="selected">tent</option>
									<option value="furniture">furniture</option>
									<option value="others">"others"</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>설명</th>
							<td>
								<textarea name="goodsContent" class="form-control">
									<%=map.get("goodsContent")%>
								</textarea>
							</td>
						</tr>
						<tr>
							<th>상품이미지</th>
							<td>
								<input type="hidden" name="preImgFileName" value="<%=map.get("imgFileName")%>">
								<img src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>">
								<input type="file" name="imgFile" class="form-control">
							</td>
						</tr>
						<tr>
							<th>등록날짜</th>
							<td><input type="text" name="goodsCreateDate" value="<%=map.get("goodsCreateDate")%>" class="form-control" readonly="readonly"></td>
						</tr>
						<tr>
							<th>수정날짜</th>
							<td><input type="text" name="goodsUpdateDate" value="<%=map.get("goodsUpdateDate")%>" class="form-control" readonly="readonly"></td>
						</tr>
					</table>
					<div style="float: right;">
						<button type="submit" class="btn btn-dark">UPDATE</button>
						<a href="<%=request.getContextPath()%>/adminGoodsOne.jsp?goodsNo=<%=goodsNo%>" class="btn btn-dark">CANCEL</a>	
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	