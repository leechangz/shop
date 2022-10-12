<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%	
	if (session.getAttribute("loginEmployee") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	Employee employee = (Employee)session.getAttribute("loginEmployee");

%>
<%@ include file="/WEB-INF/view/header.jsp"%>
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/employee.JPG); height: 200px; magin: auto;">
			<h1 style="color: #fff;">Employee Page</h1>
		</div>
		<div style="float: left;">
			<a href="<%=request.getContextPath()%>/employeeIndex.jsp" class="btn btn-dark">info</a>
			<a href="<%=request.getContextPath()%>/adminIndex.jsp" class="btn btn-dark">adminIndex</a>
		</div>
		<form class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div>
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;"><%=session.getAttribute("name")%>'s information</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered text-center">
						<tr height="60">
							<td><h3>Id</h3></td>
							<td><h4><%=employee.getEmployeeId()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Name</h3></td>
							<td><h4><%=employee.getEmployeeName()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Active</h3></td>
							<td><h4><%=employee.getActive()%></h4></td>
						</tr>
						<tr height="60">
							<td><h3>Join Date</h3></td>
							<td><h4><%=employee.getCreateDate()%></h4></td>
						</tr>									
					</table>
				</div>
			</div>
		</form>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	