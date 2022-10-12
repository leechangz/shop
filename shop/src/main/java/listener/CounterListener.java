package listener;

import java.sql.SQLException;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import service.CounterService;

@WebListener
public class CounterListener implements HttpSessionListener {
	private CounterService counterService;

	// 세션이 생성될때 마다 DB카운터를 1씩 증가
	// 세션이 생성될때 마다 application attribute에 현재접속카운터를 1씩 증가
	public void sessionCreated(HttpSessionEvent se) {
		counterService = new CounterService();
		try {
			counterService.count(); // 세션생성되면 count 메소드 통해서 방문자수+1
		} catch (Exception e) {
			System.out.println("방문자 수 오류 발생!");
			e.printStackTrace();
		}
		// 동시 접속자 있을 경우
		// 세션에 저장된 값 가져와서 + 1
		int n = (Integer) (se.getSession().getServletContext().getAttribute("currentCounter"));
		se.getSession().getServletContext().setAttribute("currentCounter", n + 1);
	}

	// 방문자 수가 세션에 저장되어 있지 않는 경우라면
	// 세션이 소멸되면 application attribute에 현재접속카운터를 1씩 감소
	public void sessionDestroyed(HttpSessionEvent se) {
		se.getSession().getServletContext().setAttribute("currentCounter",
				(Integer) (se.getSession().getServletContext().getAttribute("currentCounter")) - 1);
	}
}