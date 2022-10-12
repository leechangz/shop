<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%	
	// 직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	// 로그인 되어 있는 아이디값
	String id = (String)session.getAttribute("id");	

	//페이징 변수 호출
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	
	CustomerService customerService = new CustomerService();
	
	// 리스트에 값 저장
	List<Customer> list = new ArrayList<Customer>();
	list = customerService.getCustomerList(ROW_PER_PAGE, currentPage);
	
	int lastPage = customerService.getCustomerLastPage(ROW_PER_PAGE);
	System.out.print("lastPage : " + lastPage);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;	
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">EMPLOYEE PAGE</h1>
			<h3 style="color: #fff;">NOTICE</h3>
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
			<!-- 고객 리스트 table -->
			<div class="col-sm-10">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Customer_Id</th>
							<th>Customer_Name</th>
							<th>Customer_Address</th>
							<th>CREATEDATE</th>
							<th>Customer_Delete</th>
						</tr>
					</thead>
					<tbody>
					<%
						for(Customer c : list) {
					%>
							<tr>
								<td><%=c.getCustomerId()%></td>
								<td><%=c.getCustomerName()%></td>
								<td><%=c.getCustomerAddress()%></td>
								<td><%=c.getCreateDate()%></td>
								<td>
									<form class="inline-form">
									<input type="password" name="adminPw" id="adminPw">
									<input type="hidden" name="adminId" id="adminId" value="<%=id%>">
									<input type="hidden" name="customerId" id="customerId" value="<%=c.getCustomerId()%>">
									<button type="button" name="customerDeleteBtn" id="customerDeleteBtn" class="btn btn-dark" style="margin-top: 10px;">DELETE</button>
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
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminCustomerList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
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
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminCustomerList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/adminCustomerList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
<script>
	$('#customerDeleteBtn').click(function() {
		if($('#adminPw').val() == '') {
			alert('PW를 입력하세요');
		} else {
			$.ajax({
				url : '/shop/customerDeleteController',
				type : 'post',
				data : {
					adminId : $('#adminId').val(),
					adminPw : $('#adminPw').val(), 
					customerId : $('#customerId').val()
				},
				success : function(json) {
					if(json == 'y') {
						alert('삭제되었습니다.');
						location.href="adminCustomerList.jsp";
					} else {
						alert('비밀번호가 다릅니다.');
						location.href="adminCustomerList.jsp";
					}
				}
			});
		}
	});
</script>
<%@ include file="/WEB-INF/view/footer.jsp"%>	