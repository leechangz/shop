<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%	
	// 로그인 되어 있는 사람만
	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeService noticeService = new NoticeService();
	Notice notice = noticeService.getNoticeOne(noticeNo);

%>
<%@ include file="/WEB-INF/view/header.jsp"%>	
	<div class="container text-center">
		<div class="jumbotron text-center" style="background-image: url(<%=request.getContextPath()%>/images/notice.JPG); height: 200px; magin: auto;">
			<h3 style="color: #fff;">NOTICE</h3>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/customerNoticeList.jsp" class="btn btn-dark" style="float: left; margin-bottom: 20px;">BACK</a>
		</div>
		<div class="container" style="background-color: #fff;">
			<table class="table table-bordered">
				<tr>
					<td><h4>No</h4></td>
					<td><%=notice.getNoticeNo()%></td>
					<td><h4>Writer</h4></td>
					<td><%=notice.getEmployeeId()%></td>
				</tr>
				<tr>
					<td><h3>Title</h3></td>
					<td colspan="3"><h3><%=notice.getNoticeTitle()%></h3></td>
				</tr>
				<tr>
					<td><h3>Content</h3></td>
					<td colspan="3"><textarea class="form-control" style="height: 200px;" readonly="readonly"><%=notice.getNoticeContent()%></textarea></td>
				</tr>
				<tr>
					<td><h4>Upload_Date</h4></td>
					<td colspan="3"><%=notice.getCreateDate()%></td>
				</tr>
			</table>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>	