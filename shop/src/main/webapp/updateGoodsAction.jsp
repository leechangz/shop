<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "service.GoodsService" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.io.File" %>
<%@ page import = "vo.Goods" %>
<%@ page import = "vo.GoodsImg" %>
<%
	//직원 권한이 없을 시 차단
	if (session.getAttribute("user") == null || session.getAttribute("active").equals("N")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}

	request.setCharacterEncoding("utf-8");

	// 경로
	String dir = request.getServletContext().getRealPath("/upload") ;
	
	// 파일 사이즈
	int max = 10 * 1024 * 1024; 
	
	// mRequest 요청, 파일위치, 파일사이즈, 인코딩, 이름규칙
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy()); 
	
	// 파라미터
	int goodsNo = Integer.parseInt(mRequest.getParameter("goodsNo"));
	String goodsName = mRequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mRequest.getParameter("goodsPrice"));
	String soldOut = mRequest.getParameter("soldOut");
	String goodsType = mRequest.getParameter("goodsType");
	String goodsContent = mRequest.getParameter("goodsContent");
	String contentType = mRequest.getContentType("imgFile");
	String originFileName = mRequest.getOriginalFileName("imgFile");
	String fileName = mRequest.getFilesystemName("imgFile");
	String preImgFileName = mRequest.getParameter("preImgFileName");
	
	// 디버깅
	System.out.println(dir + " <-- dir");
	System.out.println(goodsNo + " <-- goodsNo");
	System.out.println(goodsName + " <-- goodsName");
	System.out.println(goodsPrice + " <-- goodsPrice");
	System.out.println(goodsType + " <-- goodsType");
	System.out.println(goodsContent + " <-- goodsContent");
	System.out.println(soldOut + " <-- soldOut");
	System.out.println(contentType + " <-- 마임타입");
	System.out.println(originFileName + " <-- 원본 파일이름");
	System.out.println(fileName + " <-- 새로 만들어진 파일이름");
	System.out.println(preImgFileName + " <-- 기존 파일이름");
	
	// 업로드된 파일이 이미지 파일이 아닐 경우 이미 업로드된 파일을 삭제
	if(!(contentType.equals("image/gif")||contentType.equals("image/png") || contentType.equals("image/jpeg"))) {
		File f = new File(dir + "\\" + fileName);
		if(f.exists()) {
			f.delete();
		}
		String errorMsg = URLEncoder.encode("이미지파일만 업로드 가능", "utf-8");
		response.sendRedirect(request.getContextPath()+"/addGoodsForm.jsp?errorMsg="+errorMsg);
		return;
	}
	
	// 파라미터 세팅
	Goods goods = new Goods();
	GoodsImg goodsImg = new GoodsImg();
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
	goods.setGoodsType(goodsType);
	goods.setGoodsContent(goodsContent);
	goodsImg.setGoodsImgNo(goodsNo);
	goodsImg.setContentType(contentType);
	goodsImg.setOriginFileName(originFileName);
	goodsImg.setFileName(fileName);
	
	// insert
	GoodsService goodsService = new GoodsService();
	int row = goodsService.modifyGoods(goods, goodsImg);
	
	// 조건 + goodsNo 어디서?
	if(row == 0) {
		// 실패 시 이미지 삭제
		File f = new File(dir + "\\" + fileName);
		if(f.exists()) {
			f.delete();
		}
		response.sendRedirect(request.getContextPath() + "/updateGoodsForm.jsp?goodsNo="+goodsNo);
	} else {
		// 기존 이미지 삭제
		File f = new File(dir + "\\" + preImgFileName);
		if(f.exists()) {
			f.delete();
		}
		response.sendRedirect(request.getContextPath() + "/adminGoodsOne.jsp?goodsNo="+goodsNo);
	}
	
%>