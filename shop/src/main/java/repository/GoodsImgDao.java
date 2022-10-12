package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 이미지 삭제
	public int deleteGoodsImg(Connection conn, int keyNo, String fileName) throws SQLException {
		int row = 0;
		
		String sql = "DELETE FROM goods_img WHERE goods_no = ? AND fileName = ?";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, keyNo);
			stmt.setString(2, fileName);
			
			row = stmt.executeUpdate(); 
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		System.out.println(row + " <-- row");
		return row;
	}
	
	// 이미지 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		int row = 0;
		
		String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ?"
				+ " WHERE goods_no = ?";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFileName());
			stmt.setString(2, goodsImg.getOriginFileName());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsImgNo());
			
			row = stmt.executeUpdate(); 
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		System.out.println(row + " <-- row");
		return row;
	}
	
	// 이미지 추가
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		int row = 0;
		
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date)"
					 + " VALUES (?, ?, ?, ?, now())";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsImg.getGoodsImgNo());
			stmt.setString(2, goodsImg.getFileName());
			stmt.setString(3, goodsImg.getOriginFileName());
			stmt.setString(4, goodsImg.getContentType());
			
			row = stmt.executeUpdate(); 
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		System.out.println(row + " <-- row");
		return row;
	}
}
