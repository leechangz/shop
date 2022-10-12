<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전체공개
	request.setCharacterEncoding("utf-8");
	String loginType = "customer";
	if(request.getParameter("loginType") != null) {
		loginType = request.getParameter("loginType");
	}
	System.out.println(loginType);
%>
<%@ include file="/WEB-INF/view/header.jsp"%>
	<div class="container text-center" style="background-color: #F2F2F2; height: 500px;">		
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/login.JPG); height: 200px; magin: auto;">
			<h3 style="color: #fff;">LOGIN</h3>
		</div>
			<%
				if(loginType.equals("customer")) {
			%>
					<div class="container" style="margin-bottom: 10px;">
						<form action="<%=request.getContextPath()%>/loginForm.jsp" method="post" class="form-inline">
							<label style="margin-right: 10px;">LoginType</label>
							<select name="loginType" class="form-control" style="margin-right: 10px;">
								<option value="customer" selected="selected">customer</option>
								<option value="employee">employee</option>
							</select>
							<button type="submit" class="btn btn-dark">change</button>
						</form>
					</div>
					<div>
						<form action="<%=request.getContextPath()%>/customerloginAction.jsp" method="post" id="customerForm" class="w-20 border p-3 bg-white shadow rounded align-self-center">					
							<div class="container text-center">
								<h4>CUSTOMER</h4>
								<%
									if(request.getParameter("errorMsg1") != null) {
								%> 
										<span style="color:red"><%=request.getParameter("errorMsg1")%></span>
								<%
									}
								%>
							</div>
							<table class="table table-secondary">
								<tr>
									<td>ID</td>
									<td><input type="text" name="customerId" id="customerId" class="form-control"></td>
								</tr>
								<tr>
									<td>PW</td>
									<td><input type="password" name="customerPass" id="customerPass" class="form-control"></td>
								</tr>
							</table>
							<div class="container text-center">
								<button type="button" id="customerBtn" class="btn btn-dark">Login</button>
								<a href="<%=request.getContextPath()%>/addCustomer.jsp" type="button" class="btn btn-dark">Sign-Up</a>
							</div>
						</form>
					</div>
			<%
				} else {
			%>
					<div class="container" style="margin-bottom: 10px;">
						<form action="<%=request.getContextPath()%>/loginForm.jsp" method="post" class="form-inline">
							<label style="margin-right: 10px;">LoginType</label>
							<select name="loginType" class="form-control" style="margin-right: 10px;">
								<option value="customer">customer</option>
								<option value="employee" selected="selected">employee</option>
							</select>
							<button type="submit" class="btn btn-dark">change</button>
						</form>
					</div>
					<div>
						<form action="<%=request.getContextPath()%>/employeeloginAction.jsp" method="post" id="employeeForm" class="w-20 border p-3 bg-white shadow rounded align-self-center">
							<div class="container text-center">
								<h4>EMPLOYEE</h4>
								<%
									if(request.getParameter("errorMsg2") != null) {
								%>
										<span style="color:red"><%=request.getParameter("errorMsg2")%></span>
								<%
									}
								%>
							</div>
							<table class="table table-secondary">
								<tr>
									<td>ID</td>
									<td><input type="text" name="employeeId" id="employeeId" class="form-control"></td>
								</tr>
								<tr>
									<td>PW</td>
									<td><input type="password" name="employeePass" id="employeePass" class="form-control"></td>
								</tr>
							</table>
							<div class="container text-center">
								<button type="button" id="employeeBtn" class="btn btn-dark">Login</button>
								<a href="<%=request.getContextPath()%>/addEmployee.jsp" type="button" class="btn btn-dark">Sign-Up</a>
							</div>
						</form>
					</div>
			<%
				}
			%>
	</div>
<script>
	$('#customerBtn').click(function() {
		if($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요');
		} else if($('#customerPass').val() == '') {
			alert('고객비밀번호를 입력하세요');
		} else {
			customerForm.submit();
		}
	});
	$('#employeeBtn').click(function() {
		if($('#employeeId').val() == '') {
			alert('스텝아이디를 입력하세요');
		} else if($('#employeePass').val() == '') {
			alert('스텝비밀번호를 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
</script>
<%@ include file="/WEB-INF/view/footer.jsp"%>