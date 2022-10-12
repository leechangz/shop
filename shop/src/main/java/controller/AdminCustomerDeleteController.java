package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.EmployeeService;
import vo.Employee;

@WebServlet("/customerDeleteController")
public class AdminCustomerDeleteController extends HttpServlet {
	private EmployeeService employeeService;
	private Employee employee;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		this.employee = new Employee();
		this.employeeService = new EmployeeService();
		
		String adminId = request.getParameter("adminId");
		String adminPw = request.getParameter("adminPw");
		String customerId = request.getParameter("customerId");
		
		System.out.println(adminId + " <-- adminId");
		System.out.println(adminPw + " <-- adminPw");
		System.out.println(customerId + " <-- customerId");
		
		employee.setEmployeeId(adminId);
		employee.setEmployeePass(adminPw);
		
		System.out.println(employee.getEmployeeId() + " <-- getEmployeeId");
		System.out.println(employee.getEmployeePass() + " <-- getEmployeePass");
		
		Employee AdminCk = employeeService.getEmployeeByIdAndPw(employee);
		
		System.out.println(AdminCk.getEmployeeId() + " <-- getEmployeeId");
		System.out.println(AdminCk.getEmployeePass() + " <-- getEmployeePass");
		
		int result = 0;
		
		// 관리자 비밀번호 일치 확인
		if(AdminCk != null) {
			result = employeeService.removeCustomerAdmin(customerId);
		} 
		
		Gson gson = new Gson();
		String jsonStr = "";
		
		if(result == 1) {
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