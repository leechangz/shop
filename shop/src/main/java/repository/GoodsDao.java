package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	
	// 상품삭제
	public int deleteGoods(Connection conn, int goodsNo) throws SQLException {
		int row = 0;
		
		// null 일 때 사용한가능 아이디
		String sql = "DELETE FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return row;
	}
	
	
	// 상품리스트 마지막페이지
	public int selectCustomerGoodsListLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM goods";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return totalCount;
	}
	
    // 고객 상품리스트 페이지로 반환	
	// 상품 정렬
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, String type, String word, String sort, int rowPerPage, int beginRow) throws SQLException{
		List<Map<String, Object>> list = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;	
	    String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice,"
	    		+ " g.goods_content goodsContent, g.sold_out soldOut, gi.filename fileName"
	    		+ " FROM goods g LEFT JOIN (SELECT goods_no, SUM(orders_quantity) sumNum"
	    		+ " FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no"
	    		+ " INNER JOIN goods_img gi ON g.goods_no = gi.goods_no"
	    		+ " WHERE g.goods_name LIKE ? " + type
	    		+ " ORDER BY " + sort +" LIMIT ?, ?";
    
	    System.out.println(beginRow + " < beginRow");
		System.out.println(rowPerPage + " < rowPerPage");
	    
	    try {
	    	list = new ArrayList<Map<String, Object>>();;
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+word+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String,Object> map = new HashMap<String, Object>();
		        
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("goodsContent", rs.getString("goodsContent"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("fileName", rs.getString("fileName"));
				
				System.out.println(list);
				
		        list.add(map);
			}
		} finally {
			if (rs != null) {
		        rs.close();
		    }
		    if (stmt != null) {
		        stmt.close();
		    }
		}
	    
	    return list;
	}
	
	// 상품 수정
	public int updateGoods(Connection conn, Goods goods) throws SQLException {
		int row = 0;
		
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ?, goods_type = ?, goods_content = ?, update_date = NOW()"
				+ " WHERE goods_no = ?";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getGoodsType());
			stmt.setString(4, goods.getGoodsContent());
			stmt.setInt(5, goods.getGoodsNo());

			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println(row + " <-- row");
		return row;
	}
	
	// 반환값 key값 (jdbc api)
	// 상품 추가
	public int insertGoods(Connection conn, Goods goods) throws SQLException {
		int keyId = 0;
		
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date,"
				+ " sold_out, goods_type, goods_content)"
					 + " VALUES (?, ?, now(), now(), ?, ?, ?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			stmt.setString(4, goods.getGoodsType());
			stmt.setString(5, goods.getGoodsContent());
			
			// 1) insert
			stmt.executeUpdate(); // insert 성공한 row 수
			
			// 2) select last_ai_key from ...
			rs = stmt.getGeneratedKeys(); // select last_key
			
			if(rs.next()) {
				keyId = rs.getInt(1);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		System.out.println(keyId + " <-- keyId");
		return keyId;
	}
	
	// 상품 상세보기
	// 쿼리에서 where 조건이 없다면.. 반환 타입이 List<Map<String, Object>> list
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {
		Map<String, Object> map = null;
		
		String sql = "SELECT g.*, gi.* FROM goods g INNER JOIN goods_img gi ON g.goods_no=gi.goods_no WHERE g.goods_no=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getInt("g.goods_no"));
				map.put("goodsName", rs.getString("g.goods_name"));
				map.put("goodsPrice", rs.getInt("g.goods_price"));
				map.put("goodsContent", rs.getString("g.goods_content"));
				map.put("goodsType", rs.getString("g.goods_type"));
				map.put("goodsUpdateDate", rs.getString("g.update_date"));
				map.put("goodsCreateDate", rs.getString("g.create_date"));
				map.put("soldOut", rs.getString("g.sold_out"));
				map.put("imgFileName", rs.getString("gi.filename"));
				map.put("imgOriginFileName", rs.getString("gi.origin_filename"));
				map.put("imgContentType", rs.getString("gi.content_type"));
				map.put("imgCreateDate", rs.getString("gi.create_date"));
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		return map;
	}
	
	// 상품 soldout 변경
	public int updateGoodsSoldOut(Connection conn, Goods goods) throws SQLException {
		int row = 0;
		String sql = "UPDATE goods SET sold_out = ? WHERE goods_no = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getSoldOut());
			stmt.setInt(2, goods.getGoodsNo());
			
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 상품리스트
	public List<Goods> selectGoodsListByPage(Connection conn, final int rowPerPage, int beginRow) throws SQLException {
		List<Goods> list = null;
		Goods goods = null;
		
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice,"
				+ " create_date createDate, sold_out soldOut"
				+ " FROM goods ORDER BY goods_no DESC LIMIT ?, ?"; 
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		System.out.println(beginRow + " < beginRow");
		System.out.println(rowPerPage + " < rowPerPage");
		try {
			list = new ArrayList<Goods>();
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				goods = new Goods();
				goods.setGoodsNo(rs.getInt("goodsNo"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setGoodsPrice(rs.getInt("goodsPrice"));
				goods.setCreateDate(rs.getString("createDate"));
				goods.setSoldOut(rs.getString("soldOut"));
				
				list.add(goods);
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return list;
	}
	
	// 상품리스트 마지막페이지
	public int selectGoodsLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM goods";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		} finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return totalCount;
	}
}
