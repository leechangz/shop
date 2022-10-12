<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
<%
	// 직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}	
%>
	<div class="container text-center" style="background-color: #F2F2F2; height: 800px;">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">GOODS INSERT</h3>
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
			<!-- 상품추가 폼 -->	
			<div class="col-sm-10">
				<form action="<%=request.getContextPath()%>/addGoodsAction.jsp" 
		 			  method="post" enctype="multipart/form-data">
					<table class="table table-bordered">
						<tr>
							<th>NAME</th>
							<td>
								<input type="text" name="goodsName" class="form-control">
							</td>
						</tr>
						<tr>
							<th>PRICE (원)</th>
							<td><input type="text" name="goodsPrice" class="form-control"></td>
						</tr>
						<tr>
							<th>SOLDOUT</th>
							<td>
								<select name="soldOut">
									<option value="N">N</option>
									<option value="Y">Y</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>TYPE</th>
							<td>
								<select name="goodsType">
									<option value="tent">tent</option>
									<option value="furniture">furniture</option>
									<option value="others">others</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>CONTENT</th>
							<td>
								<textarea name="goodsContent" class="form-control">
								</textarea>
							</td>
						</tr>
						<tr>
							<th>IMAGE</th>
							<td>
								<div class="custom-file">
									<input type="file" name="imgFile" class="file-input">
								</div>
							</td>
						</tr>
					</table>
					<div style="float: right;">
						<button type="submit" class="btn btn-dark">INSERT</button>
						<a href="<%=request.getContextPath()%>/adminGoodsList.jsp" class="btn btn-dark">CANCEL</a>
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	