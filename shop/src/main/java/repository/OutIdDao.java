package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OutIdDao {
	
	// 탈퇴 회원의 정보를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String id) throws SQLException {
		// 동일한 conn 사용하므로 conn.close() X
		int row = 0;
		
		String sql = "INSERT INTO outid (out_id, out_date) VALUES (?, NOW())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
}
