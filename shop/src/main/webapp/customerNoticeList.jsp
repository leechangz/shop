<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%	
	// 전체공개
	request.setCharacterEncoding("utf-8");

	//페이징값
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	
	NoticeService noticeService = new NoticeService();
	List<Notice> list = new ArrayList<Notice>();
	list = noticeService.getNoticeList(ROW_PER_PAGE, currentPage);
	
	int lastPage = noticeService.getNoticeLastPage(ROW_PER_PAGE);
	System.out.print("lastPage : " + lastPage);
	
	// 페이지 번호에 필요한 변수 계산
	int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;	
%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/notice.JPG); height: 200px; magin: auto;">
			<h3 style="color: #fff;">NOTICE</h3>
		</div>
		<div>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>No</th>
						<th>Title</th>
						<th>Writer</th>
						<th>Upload_Date</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/customerNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>">
									<%=n.getNoticeTitle()%>
								</a>
							</td>
							<td><%=n.getEmployeeId()%></td>
							<td><%=n.getCreateDate()%></td>
						</tr>
				<%	
					}
				%>
				</tbody>
			</table>
		</div>
		<div>
		<!-- 페이지 -->
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
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
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/customerNoticeList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	