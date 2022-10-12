package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CounterDao;

public class CounterService {
	private CounterDao counterDao;
	private DBUtil dbUtil;

	// 방문자 카운트
	public void count() {
		counterDao = new CounterDao();
		dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("#count DB 연결 성공!");
			if (counterDao.selectCounterToday(conn) == null) { // 오늘날짜 카운터가 없으면 1 입력
				System.out.println("todayCounter 없음");
				counterDao.insertCounter(conn);
			} else { // 오늘날짜의 카운터가 있으면 +1 업데이터
				System.out.println("todayCounter 있음");
				counterDao.updateCounter(conn);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	// 총방문자 수
	public int getTotalCount() {
		// 리턴값
		int totalCount = 0;
		dbUtil = new DBUtil();
		counterDao = new CounterDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("#getTodayCount DB 연결 성공!");
			totalCount = counterDao.selectTotalCount(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(totalCount + "<-- totalCount");
		return totalCount;
	}

	// 오늘 방문자 수
	public int getTodayCount() {
		// 리턴값
		int todayCount = 0;
		dbUtil = new DBUtil();
		counterDao = new CounterDao();
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("#getTodayCount DB 연결 성공!");
			todayCount = counterDao.selectTodayCount(conn);

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(todayCount + "<-- todayCount");
		return todayCount;
	}
}