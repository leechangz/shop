package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Review;

public class ReviewDao {
	
	// 리뷰추가
	public int insertReviewByCustomer(Connection conn, Review review) throws SQLException {
		int row = 0;
		
		String sql = "INSERT INTO review (orders_no, review_content, review_grade, create_date)"
				+ " VALUES (?, ?, ?, NOW())";

		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, review.getOrdersNo());
			stmt.setString(2, review.getReviewContent());
			stmt.setInt(3, review.getReviewGrade());
			
			row = stmt.executeUpdate();

		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println(row);
		return row;
	}
	
	// 리뷰목록
	public List<Map<String, Object>> selectReviewByGoods(Connection conn, int goodsNo) throws SQLException {
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;
		
		String sql = "SELECT o.customer_id customerId, r.review_grade reviewGrade,"
				+ " r.review_content reviewContent, r.create_date createDate"
				+ " FROM review r INNER JOIN orders o"
				+ " ON r.orders_no = o.orders_no"
				+ " WHERE o.goods_no = ?";

		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			list = new ArrayList<>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<String, Object>();
				
				map.put("customerId", rs.getString("customerId"));
				map.put("reviewGrade", rs.getInt("reviewGrade"));
				map.put("reviewContent", rs.getString("reviewContent"));
				map.put("createDate", rs.getString("createDate"));
				
				System.out.println(map + " <-- dao");
				list.add(map);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println(map);
		return list;
	}
}
