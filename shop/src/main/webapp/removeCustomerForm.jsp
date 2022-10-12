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
		<div class="jumbotron text-center">
			<h3>사진</h3>
		</div>
		<form action="<%=request.getContextPath()%>/removeCustomer.jsp" method="post"
			class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div style="height: 550px">
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;">Membership Secession</h3>   <!-- 로그인 아이디 -->
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
						<tr height="60">
							<td><h3>Password Check</h3></td>
							<td>
								<input type="hidden" name="customerId" value="<%=customer.getCustomerId()%>">
								<input type="password" name="customerPass" class="form-control">
							</td>
						</tr>									
					</table>
				</div>
				<div style="float: right;">
					<button type="submit" class="btn btn-dark">Delete</button>
					<a href="<%=request.getContextPath()%>/customerIndex.jsp" class="btn btn-dark">Cancel</a>
				</div>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	