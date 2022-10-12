<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Customer" %>
<%	
	if (session.getAttribute("loginCustomer") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	Customer customer = (Customer)session.getAttribute("loginCustomer");

%>
<%@ include file="/WEB-INF/view/header.jsp"%>
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/customer.JPG); height: 200px; magin: auto;">
			<h3>Customer Page</h3>
		</div>
		<div style="float: left;">
			<a href="<%=request.getContextPath()%>/customerIndex.jsp" class="btn btn-dark">info</a>
			<a href="<%=request.getContextPath()%>/customerOrderList.jsp?customerId=<%=customer.getCustomerId()%>" class="btn btn-dark">orderlist</a>
		</div>
		<form class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div style="height: 500px">
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;"><%=session.getAttribute("name")%>'s information</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered text-center">
						<tr height="60">
							<td><h3>Id</h3></td>
							<td><h4><%=customer.getCustomerId()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Name</h3></td>
							<td><h4><%=customer.getCustomerName()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Address</h3></td>
							<td><h4><%=customer.getCustomerAddress()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Telephone</h3></td>
							<td><h4><%=customer.getCustomerTelephone()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Join Date</h3></td>
							<td><h4><%=customer.getCreateDate()%></h4></td>
						</tr>									
					</table>
				</div>
				<div style="float: right;">
					<a href="<%=request.getContextPath()%>/updateCustomerForm.jsp" class="btn btn-dark">Update</a>
					<a href="<%=request.getContextPath()%>/removeCustomerForm.jsp" class="btn btn-dark">Secession</a>
				</div>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	