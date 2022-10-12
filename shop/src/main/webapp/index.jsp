<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전체공개
	String tent = "AND g.goods_type = 'tent'";
	String furniture = "AND g.goods_type = 'furniture'";
	String others = "AND g.goods_type = 'others'";
%>
<%@ include file="/WEB-INF/view/header.jsp"%>
	<!-- Main -->
	<div class="container">
		<div id="banner-wrapper">
			<div id="banner" class="box container" style="background-image: url(<%=request.getContextPath()%>/images/banner.PNG); background-color: rgba( 255, 255, 255, 0.5 );">
				<div class="row">
					<div class="col-7 col-12-medium">
						<h2 style="color: #424242;">Camping</h2>
						<p style="color: #fff;">Buy all kinds of camping tools you want</p>
					</div>
					<div class="col-5 col-12-medium">
					</div>
				</div>
			</div>
		</div>
		<div id="features-wrapper">
			<div class="container">
				<div class="row">
					<div class="col-4 col-12-medium">
						<section class="box feature">
							<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=tent%>" class="image featured"><img src="<%=request.getContextPath()%>/images/tent.JPG" alt=""/></a>
							<div class="inner">
								<header>
									<h2>Tent</h2>
									<p>More Goods Click Banner</p>
								</header>
							</div>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="box feature">
							<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=furniture%>" class="image featured"><img src="<%=request.getContextPath()%>/images/furniture.JPG" alt="" /></a>
							<div class="inner">
								<header>
									<h2>Furniture</h2>
									<p>More Goods Click Banner</p>
								</header>
							</div>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="box feature">
							<a href="<%=request.getContextPath()%>/customerGoodsList.jsp?type=<%=others%>" class="image featured"><img src="<%=request.getContextPath()%>/images/others.JPG" alt="" /></a>
							<div class="inner">
								<header>
									<h2>Others</h2>
									<p>More Goods Click Banner</p>
								</header>
							</div>
						</section>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/view/footer.jsp"%>