package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private ReviewDao reviewDao;

	// 리뷰 추가
	public int addReviewByCustomer(Review review) throws SQLException {
		int result = 0;

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
		
			reviewDao = new ReviewDao();
			
			result = reviewDao.insertReviewByCustomer(conn, review);
			
			if(result == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
				
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 예외를 던지지말고 감싸야함
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println(result + " <-- service");
		return result;
	}
	
	// 상품 별 리뷰 리스트
	public List<Map<String, Object>> getReviewByGoods(int goodsNo) throws SQLException {
		List<Map<String, Object>> list = null;

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
		
			reviewDao = new ReviewDao();
			
			list = reviewDao.selectReviewByGoods(conn, goodsNo);
			
			if(list.size() < 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
				
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 예외를 던지지말고 감싸야함
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println(list + " <-- service");
		return list;
	}
}
