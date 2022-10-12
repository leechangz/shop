package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CounterDao {
	
	// 오늘 날짜에 날짜가 있다면
	public void updateCounter(Connection conn) throws Exception {
		// 쿼리
		String sql = "UPDATE counter SET counter_num = counter_num + 1  WHERE counter_date = CURDATE()";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao.java updateCounter stmt : " + stmt);
			
			// 쿼리실행
			int row = stmt.executeUpdate();
			// 디버깅
			System.out.println("CounterDao.java updateCounter row : " + row);
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
	}
	
	
	// 입력
	public void insertCounter(Connection conn) throws Exception {
		// 쿼리
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES(curdate(),1)";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao.java insertCounter stmt : " + stmt);
			
			// 쿼리실행
			int row = stmt.executeUpdate();
			// 디버깅
			System.out.println("CounterDao.java insertCounter row : " + row);
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
	}
	
	
	// select (오늘 날짜에 있는지)
	public String selectCounterToday(Connection conn) throws Exception {
		// 리턴값 초기화
		String result = null;
		
		// 쿼리
		String sql = "SELECT counter_date counterDate FROM counter WHERE counter_date = CURDATE()";

		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao.java selectCounterToday stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("counterDate");
			}
		} finally {
			// stmt, rs 닫기
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return result;
	}
	
	
	// 전체접속자 수
	public int selectTotalCount(Connection conn) throws Exception {
		// 리턴값 초기화
		int result = -9;
		
		// 쿼리
		String sql = "SELECT sum(counter_num) sum FROM counter";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao.java selectTotalCount stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("sum");
			}
		} finally {
			// stmt, rs 닫기
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return result;
	}
	
	
	// 오늘접속자 수
	public int selectTodayCount(Connection conn) throws Exception {
		// 리턴값 초기화
		int result = -9;
		
		// 쿼리
		String sql = "SELECT counter_num counterNum FROM counter WHERE counter_date = CURDATE()";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CounterDao.java selectTotalCount stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("counterNum");
			}
		} finally {
			// stmt, rs 닫기
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return result;
	}
}
