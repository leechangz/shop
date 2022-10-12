<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
<%
	//로그인되어 있을 시 차단
	if (session.getAttribute("user") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
	<div class="container text-center" style="background-color: #F2F2F2; height: 550px;">
		<div class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/register.JPG); height: 200px; magin: auto; opacity: 0.7;">
				<h3 style="color: #fff;">Employee Sign-Up</h3>
			</div>

			<!-- 중복확인 form -->
			<div>
				<form class="form-inline">
					<div class="form-group" style="width : 100%;">
						<table class="table table-bordered">
							<tr>
							<td style="width : 30%;">ID CHECK</td>
							<td>
								<input type="text" name="idck" id="idck" class="form-control primary" style="width: 67%;">
								<button type="button" id="idckBtn" class="btn btn-dark">아이디중복검사</button>
							</td>
						</table>
					</div>
				</form>
			</div>
			
			<!-- 고객가입 form -->
			<form action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="get" id="employeeForm" class="w-20 border p-3 bg-white shadow rounded align-self-center">
				<div class="container">
					<table class="table table-bordered">
						<tr>
							<td style="width : 30%;">Employee_Id</td>
							<td>
								<input type="text" name="employeeId" id="employeeId" 
									readonly="readonly" class="form-control">
							</td>
						</tr>
						<tr>
							<td style="width : 30%;">Employee_Pw</td>
							<td>
								<input type="password" name="employeePass" id="employeePass" class="form-control">
							</td>
						</tr>
						<tr>
							<td style="width : 30%;">Employee_Name</td>
							<td>
								<input type="text" name="employeeName" id="employeeName" class="form-control">
							</td>
						</tr>
					</table>
					<button type="button" id="employeeBtn" class="btn btn-dark">회원가입</button>
					<a href="loginForm.jsp" type="button" class="btn btn-dark">취소</a>
				</div>
			</form>
		</div>
	</div>
<script>

	$('#idckBtn').click(function() {
		if($('#idck').val().length < 4 || $('#idck').val().length > 13) {
			alert('ID는 4자이상 13자 이하입니다.');
		} else {
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {idck : $('#idck').val()},
				success : function(json) {
					if(json == 'y') {
						alert('사용가능한 아이디 입니다.');
						$('#employeeId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#employeeId').val('');
					}
				}
			});
		}
	});
	
	$('#employeeBtn').click(function() {
		if($('#employeeId').val() == '') {
			alert('중복검사를 진행해주세요');
			$("#idck").focus();
		} else if($('#employeePass').val() == '') {
			alert('고객비밀번호를 입력하세요');
			$("#employeePass").focus();
		} else if($('#employeeName').val() == '') {
			alert('고객이름을 입력하세요');
			$("#employeeName").focus();
		} else {
			employeeForm.submit();
		}
	});
</script>
<%@ include file="/WEB-INF/view/footer.jsp"%>	