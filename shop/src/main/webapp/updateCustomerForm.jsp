<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<form action="<%=request.getContextPath()%>/updateCustomerAction.jsp" method="post"
			class="w-20 border p-3 bg-white shadow rounded align-self-center">
			<div style="height: 700px">
				<div class="d-inline-flex">
					<h3 style="margin-bottom: 50px;">Update Info</h3>   <!-- 로그인 아이디 -->
				</div>
				<div>
					<table class="table table-bordered text-center">
						<tr height="30">
							<td><h3>Id</h3></td>
							<td><h4><input type="text" name="customerId" value="<%=customer.getCustomerId()%>" readonly="readonly"></h4></td>
						</tr>
						<tr height="30">
							<td><h3>Name</h3></td>
							<td><h4><input type="text" name="customerName" value="<%=customer.getCustomerName()%>" ></h4></td>
						</tr>
						<tr height="30">
							<td><h3>Address</h3></td>
							<td>
								<div class="form-inline">
									<div class="form-group" style="width : 100%;">
										<input type="text" name="customerAddr" id="customerAddr" readonly="readonly" class="form-control" placeholder="Address" style="width: 80%;">
										<button type="button" id="addrBtn" onclick="sample2_execDaumPostcode()" class="btn btn-dark">주소검색</button>
									</div>
								</div>
								<input type="text" name="customerAddrDetail" class="form-control" value="<%=customer.getCustomerAddress()%>">
							</td>
						</tr>
						<tr height="30">
							<td><h3>Telephone</h3></td>
							<td><h4><input type="text" name="customerTelephone" value="<%=customer.getCustomerTelephone()%>" ></h4></td>
						</tr>
						<tr height="30">
							<td><h3>Join Date</h3></td>
							<td><h4><%=customer.getCreateDate()%></h4></td>
						</tr>
						<tr height="30">
							<td><h3>Password Check</h3></td>
							<td>
								<input type="password" name="customerPass" class="form-control">
							</td>
						</tr>									
					</table>
				</div>
				<div style="float: right;">
					<button type="submit" class="btn btn-dark">Update</button>
					<a href="<%=request.getContextPath()%>/customerIndex.jsp" class="btn btn-dark">Cancel</a>
				</div>
			</div>
		</form>
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
<%@ include file="/WEB-INF/view/footer.jsp"%>	