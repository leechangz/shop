package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

@WebServlet("/loginTypeController")
public class LoginTypeController extends HttpServlet {
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		String loginType =null;
		if(request.getParameter("loginType") != null) {
			loginType = request.getParameter("loginType");
		}
		
		Gson gson = new Gson();
		String jsonStr = "";
		
		if(loginType != null) {
			request.getSession().setAttribute("loginType", loginType);
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
