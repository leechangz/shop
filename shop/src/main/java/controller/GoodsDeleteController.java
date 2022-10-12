package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.EmployeeService;
import service.GoodsService;
import vo.Employee;

@WebServlet("/goodsDeleteController")
public class GoodsDeleteController extends HttpServlet {
	private GoodsService goodsService;
	private Employee employee;
	private EmployeeService employeeService;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		this.goodsService = new GoodsService();
		this.employee = new Employee();
		this.employeeService = new EmployeeService();
		
		String adminId = request.getParameter("adminId");
		int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		String deletePw = request.getParameter("deletePw");
		String fileName = request.getParameter("fileName");
		
		System.out.println(adminId + " <-- adminId");
		System.out.println(deletePw + " <-- deletePw");
		System.out.println(goodsNo + " <-- goodsNo");
		System.out.println(fileName + " <-- fileName");
		
		employee.setEmployeeId(adminId);
		employee.setEmployeePass(deletePw);
		
		System.out.println(employee.getEmployeeId() + " <-- getEmployeeId");
		System.out.println(employee.getEmployeePass() + " <-- getEmployeePass");
		
		Employee AdminCk = employeeService.getEmployeeByIdAndPw(employee);
		
		System.out.println(AdminCk.getEmployeeId() + " <-- getEmployeeId");
		System.out.println(AdminCk.getEmployeePass() + " <-- getEmployeePass");
		
		int result = 0;
		
		// 관리자 비밀번호 일치 확인
		if(AdminCk != null) {
			// 일치 시 삭제작업
			result = goodsService.removeGoods(goodsNo, fileName);
			// upload 파일 삭제
			String dir = request.getServletContext().getRealPath("/upload") ;
			File f = new File(dir + "\\" + fileName);
			if(f.exists()) {
				f.delete();
			}
		} 
		
		Gson gson = new Gson();
		String jsonStr = "";
		
		if(result != 0) {
			jsonStr = gson.toJson("y");
		} else {
			jsonStr = gson.toJson("n");
		}
		System.out.println(jsonStr + " <-- jsonStr");
		
		PrintWriter out = response.getWriter();
		out.write(jsonStr);
		out.flush();
		out.close();
	}
}