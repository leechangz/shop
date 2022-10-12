package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDao {
	public String selectIdCheck(Connection conn, String idck) throws SQLException {
		String id = null;
		
		// null 일 때 사용한가능 아이디
		String sql = "SELECT t.id FROM"
				+ " (SELECT customer_id id FROM customer UNION"
				+ " SELECT employee_id id FROM employee UNION"
				+ " SELECT out_id id FROM outid) t WHERE t.id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, idck);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				System.out.print("있음");
				id = rs.getString("t.id");
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return id;
	}
}
