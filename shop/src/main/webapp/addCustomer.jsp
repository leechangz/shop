<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// 로그인되어 있을 시 차단
	if (session.getAttribute("user") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>
	<div class="container text-center" style="background-color: #F2F2F2; height: 700px;">
		<div class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/register.JPG); height: 200px; magin: auto; opacity: 0.7;">
				<h3 style="color: #fff;">Customer Sign-Up</h3>
			</div>
			
			<!-- 중복체크 form -->
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
			<form action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="get" id="customerForm" class="w-20 border p-3 bg-white shadow rounded align-self-center">
				<div class="container">
					<table class="table table-bordered">
						<tr>
							<td style="width : 30%;">Customer_Id</td>
							<td>
								<input type="text" name="customerId" id="customerId" 
									readonly="readonly" class="form-control">
							</td>
						</tr>
						<tr>
							<td style="width : 30%;">Customer_Pw</td>
							<td>
								<input type="password" name="customerPass" id="customerPass" class="form-control">
							</td>
						</tr>
						<tr>
							<td style="width : 30%;">Customer_Name</td>
							<td>
								<input type="text" name="customerName" id="customerName" class="form-control">
							</td>
						</tr>
						<tr>
							<td>Customer_Address</td>
							<td>
								<div class="form-inline">
									<div class="form-group" style="width : 100%;">
										<input type="text" name="customerAddr" id="customerAddr" readonly="readonly" class="form-control" placeholder="Address" style="width: 80%;">
										<button type="button" id="addrBtn" onclick="sample2_execDaumPostcode()" class="btn btn-dark">주소검색</button>
									</div>
								</div>
								<input type="text" name="customerAddrDetail" class="form-control">
							</td>
						</tr>
						<tr>
							<td style="width : 30%;">Customer_Telephone</td>
							<td>
								<input type="text" name="customerTelephone" id="customerTelephone" class="form-control">
							</td>
						</tr>
					</table>
					<button type="button" id="customerBtn" class="btn btn-dark">회원가입</button>
					<a href="loginForm.jsp" type="button" class="btn btn-dark">취소</a>
				</div>
			</form>		
		</div>
	</div>
	
	<!-- 주소 API -->		
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" 
			style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//////////////////////주소 api /////////////////////////
	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer'); 
	
	function closeDaumPostcode() {
	    element_layer.style.display = 'none';
	}
	
	function sample2_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            if(data.userSelectedType === 'R'){
	
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	
	            
	            } 
	            document.getElementById('customerAddr').value = data.zonecode + ' ' + addr;
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);
	
	    element_layer.style.display = 'block';
	
	    initLayerPosition();
	}
	
	function initLayerPosition(){
	    var width = 300; //우편번호서비스가 들어갈 element의 width
	    var height = 400; //우편번호서비스가 들어갈 element의 height
	    var borderWidth = 5; //샘플에서 사용하는 border의 두께
	
	    // 위에서 선언한 값들을 실제 element에 넣는다.
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}
</script>	
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
						$('#customerId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				}
			});
		}
	});

	$('#customerBtn').click(function() {
		if($('#customerId').val() == '') {
			alert('중복검사를 진행해주세요');
			$("#idck").focus();
		} else if($('#customerPass').val() == '') {
			alert('고객비밀번호를 입력하세요');
			$("#customerPass").focus();
		} else if($('#customerName').val() == '') {
			alert('고객이름을 입력하세요');
			$("#customerName").focus();
		} else if($('#customerAddress').val() == '') {
			alert('고객주소를 입력하세요');
			$("#customerAddress").focus();
		} else if($('#customerTelephone').val() == '') {
			alert('고객전화번호를 입력하세요');
			$("#customerTelephone").focus();
		} else {
			customerForm.submit();
		}
	});
</script>
<%@ include file="/WEB-INF/view/footer.jsp"%>	