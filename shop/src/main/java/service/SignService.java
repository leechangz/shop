package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.SignDao;

public class SignService {
	private SignDao signDao;
	
	public String getIdCheck(String idck) {
		String id = null;		
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			this.signDao = new SignDao();
			
			id = signDao.selectIdCheck(conn, idck);
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}	
		return id;
	}
}
