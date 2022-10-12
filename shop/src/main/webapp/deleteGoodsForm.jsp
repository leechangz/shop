<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String id = (String)session.getAttribute("id");

	GoodsService goodsService = new GoodsService();
	
	Map<String, Object> map =goodsService.getGoodsAndImgOne(goodsNo);
	
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/adminGoodsList.jsp");
		return;
	}
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center">
			<h1><%=session.getAttribute("user")%> PAGE</h1>
			<h3>GOODS DELETE</h3>
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
					<tr>
						<th>NO</th>
						<td><%=map.get("goodsNo")%></td>
					</tr>
					<tr>
						<th>NAME</th>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<th>PRICE (원)</th>
						<td><%=map.get("goodsPrice")%></td>
					</tr>
					<tr>
						<th>상품이미지</th>
						<td><img src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>" width="400" height="400"></td>
					</tr>
					<tr>
						<th>등록날짜</th>
						<td><%=map.get("goodsCreateDate")%></td>
					</tr>
					<tr>
						<th>PASSWORD</th>
						<td>
							<input type="hidden" name="adminId" id="adminId" value="<%=id%>">
							<input type="hidden" name="fileName" id="fileName" value="<%=map.get("imgFileName")%>">
							<input type="hidden" name="goodsNo" id="goodsNo" value="<%=map.get("goodsNo")%>">
							<input type="password" name="deletePw" id="deletePw" class="form-control">							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="float: right;">
			<button type="button" id="deleteBtn" class="btn btn-dark">DELETE</button>
			<a href="<%=request.getContextPath()%>/goodsOne.jsp?goodsNo=<%=goodsNo%>" class="btn btn-dark">CANCEL</a>	
		</div>
	</div>
<script>
	$('#deleteBtn').click(function() {
		if($('#deletePw').val() == '') {
			alert('PW를 입력하세요');
		} else {
			$.ajax({
				url : '/shop/goodsDeleteController',
				type : 'post',
				data : {
					adminId : $('#adminId').val(), 
					deletePw : $('#deletePw').val(),
					goodsNo : $('#goodsNo').val(),
					fileName : $('#fileName').val()
				},
				success : function(json) {
					if(json == 'y') {
						alert('삭제되었습니다.');
						location.href="adminGoodsList.jsp";
					} else {
						alert('비밀번호가 다릅니다.');
					}
				}
			});
		}
	});
</script>
<%@ include file="/WEB-INF/view/footer.jsp"%>	