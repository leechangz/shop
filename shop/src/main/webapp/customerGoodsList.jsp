<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.GoodsService"%>
<%@ page import = "java.util.*" %>
<%
	// 전체 공개

	request.setCharacterEncoding("utf-8");

	int rowPerPage = 20;
	if(request.getParameter("rowPerPage") != null) {
	   rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
	   currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort = "g.goods_no DESC";
	if(request.getParameter("sort") != null) {
		sort = request.getParameter("sort");
	}
	
	String word = "";
	if(request.getParameter("word") != null) {
		word = request.getParameter("word");
	}
	
	String type = "";
	if(request.getParameter("type") != null) {
		type = request.getParameter("type");
	}
	
	String tent = "AND g.goods_type = 'tent'";
	String furniture = "AND g.goods_type = 'furniture'";
	String others = "AND g.goods_type = 'others'";
	
	System.out.println(sort + " < sort");
	System.out.println(word + " < word");
	System.out.println(type + " < type");
	
	
	int lastPage;
	
	// 품절이 아닌 리스트
	GoodsService goodsService = new GoodsService();
	List<Map<String, Object>> list = goodsService.getCustomerGoodsListByPage(type, word, sort, rowPerPage, currentPage);
	
	lastPage = goodsService.getCustomerGoodsListLastPage(rowPerPage);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / rowPerPage) * rowPerPage + 1;
	int endPage = (((currentPage - 1) / rowPerPage) + 1) * rowPerPage;
	System.out.println(currentPage + " < currentPage");
	System.out.println(rowPerPage + " < rowPerPage");
	System.out.println(lastPage + " < lastPage");
	System.out.println(startPage + " < startPage");
	System.out.println(endPage + " < endPage");
	
	if(list == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
%>
<%@ include file="/WEB-INF/view/header.jsp"%>
	<div class="container text-center">
		<div class="jumbotron" style="background-image: url(<%=request.getContextPath()%>/images/campList.JPG); height: 300px; magin: auto;">
			<h1 style="color: #fff;">GoodsList</h1>
		</div>
		
		<!-- 검색기능 sort, page초기화 type 유지 -->
		<div class="container" style="margin: auto;">
			<form action="<%=request.getContextPath()%>/customerGoodsList.jsp" method="post" class="form-inline">
				<label style="margin-right: 20px;">serch</label>
				<input type="text" name="word" class="form-control" style="margin-right: 20px;">
				<input type="hidden" name="type" value="<%=type%>">
				<button type="submit" class="btn btn-dark" style="margin-right: 20px;">serch</button>
			</form>
		</div>
		
		<!-- 종류선택 sort, page, word초기화 -->
		<div style="float: left; margin-top: 30px;">
			<ul>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp" 
					class="btn btn-primary">
					All
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=tent%>" 
					class="btn btn-primary">
					Tent
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=furniture%>" 
					class="btn btn-primary">
					Furniture
					</a>
				</li>
				<li style="display: inline;"> | </li>
				<li style="display: inline;">
					<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=others%>" 
					class="btn btn-primary">
					Others
					</a>
				</li>
			</ul>
		</div>	
		
		<!-- 정렬기능 page초기화 type, word 유지 -->
		<div style="float: right; margin-top: 30px;">
			<form action="<%=request.getContextPath()%>/customerGoodsList.jsp" method="post" class="form-inline">
				<input type="hidden" name="type" value="<%=type%>">
				<input type="hidden" name="word" value="<%=word%>">
				<select name="sort" id="sort" class="form-control" aria-label="Default select example">
					<!-- 1 -->
					<%
						if(sort.equals("g.goods_no DESC")){
					%>
							<option value="g.goods_no DESC" selected="selected">기본순</option>
					<%
						} else {
					%>
							<option value="g.goods_no DESC">기본순</option>
					<%
						}
					%>
					<!-- 2 -->
					<%
						if(sort.equals("IFNULL(t.sumNUm, 0) DESC")){
					%>
							<option value="IFNULL(t.sumNUm, 0) DESC" selected="selected">판매순</option>
					<%
						} else {
					%>
							<option value="IFNULL(t.sumNUm, 0) DESC">판매순</option>
					<%
						}
					%>
					<!-- 3 -->
					<%
						if(sort.equals("g.goods_price DESC")){
					%>
							<option value="g.goods_price DESC" selected="selected">높은가격순</option>
					<%
						} else {
					%>
							<option value="g.goods_price DESC">높은가격순</option>
					<%
						}
					%>
					<!-- 4 -->
					<%
						if(sort.equals("g.goods_price ASC")){
					%>
							<option value="g.goods_price ASC" selected="selected">낮은가격순</option>
					<%
						} else {
					%>
							<option value="g.goods_price ASC">낮은가격순</option>
					<%
						}
					%>
					<!-- 5 -->
					<%
						if(sort.equals("g.create_date DESC")){
					%>
							<option value="g.create_date DESC" selected="selected">최신순</option>
					<%
						} else {
					%>
							<option value="g.create_date DESC">최신순</option>
					<%
						}
					%>
				</select>
				<button type="submit" class="btn btn-dark">GO</button>
			</form>
		</div>
						                 
		<!-- 각 파라미터에 따른 리스트 출력 -->
		<div>
			<table class="table table-bordered">
				<tr>
					<%
						int i = 1;
						for(Map<String, Object> m : list) {	
							if(m.get("soldOut").equals("N")) {
					%>
							 <td style="width: 25%;">
								<div class="box feature">
									<a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
				                 		<img src='<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>' width="200" height="200">
				                 	</a>
									<div class="inner">
										<header>
											<h2><%=m.get("goodsName")%></h2>
											<p><%=m.get("goodsContent")%></p>
											<p><%=m.get("goodsPrice")%> (원)</p>
										</header>
									</div>
								</div>
			               	 </td>
					<%		
							} else {
					%>
								<td style="width: 25%;">
									<div class="box feature">
										<a href="<%=request.getContextPath()%>/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
					                 		<img src='<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>' width="200" height="200" style="opacity: 0.5;">
					                 	</a>
										<div class="inner">
											<header>
												<h2><%=m.get("goodsName")%></h2>
												<p style="color: red;">SOLD OUT</p>
												<p><%=m.get("goodsPrice")%> (원)</p>
											</header>
										</div>
									</div>
					                 <!-- 리뷰 개수 -->
				               	 </td>
					<%
							}
							if(i%4 == 0) {
					%>
								</tr><tr>
					<%
							}
							i++;
						}
						
						int tdCnt = 4 - (list.size() % 4);
						if(tdCnt == 4) {
							tdCnt = 0;
						}
						for(int j=0; j<tdCnt; j++) {
					%>
							<td>&nbsp;</td>
					<%
						}
					%>
				</tr>
			</table>
		</div>
		
		<!-- 페이징 sort, type, word 유지 -->
		<div>
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item">
							<a class="page-link" 
							href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&sort=<%=sort%>&word=<%=word%>&type=<%=type%>">
							이전
							</a>
						</li>
				<%
					}
				%>
				
				<!-- 페이지번호 -->
				<%
					for (int j = startPage; j <= endPage; j++) {
						if (lastPage < endPage) {
	        				endPage = lastPage;
	    				}
				%>
						<li class="page-item">
							<a class="page-link" 
							href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=j%>&rowPerPage=<%=rowPerPage%>&sort=<%=sort%>&word=<%=word%>&type=<%=type%>">
							<%=j%>
							</a>
						</li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item">
							<a class="page-link" 
							href="<%=request.getContextPath()%>/customerGoodsList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&sort=<%=sort%>&word=<%=word%>&type=<%=type%>">
							다음
							</a>
						</li>
				<%
					}
				%>
			</ul>
		</div>
		
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	