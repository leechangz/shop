package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.GoodsDao;
import repository.GoodsImgDao;
import repository.SignDao;
import vo.Customer;
import vo.Goods;
import vo.GoodsImg;

//트랜잭션 + action이나 dao가 해서는 안되는 일
public class GoodsService {
	private GoodsDao goodsDao; // 디커풀링으로 인한 의존도를 낮춰 연결하는 방법
	private GoodsImgDao goodsImgDao;
	
	// 상품 삭제	
	public int removeGoods(int goodsNo, String fileName) {
		int result = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			if(goodsImgDao.deleteGoodsImg(conn, goodsNo, fileName) != 0) {
				result = goodsDao.deleteGoods(conn, goodsNo);
				if(result == 0) {
					throw new Exception();  // 이미지 입력실패시 강제로 롤백(catch절 이동)
				}
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
		return result;
	}
	
	
	// 고객 상품리스트 마지막 페이지
	public int getCustomerGoodsListLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();		 			
			totalCount = goodsDao.selectCustomerGoodsListLastPage(conn, rowPerPage);
			
			if(totalCount == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage += 1;
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
		return lastPage;
	}
	
	// 고객 상품 리스트
	public List<Map<String, Object>> getCustomerGoodsListByPage(String type, String word, String sort, int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null;
		Connection conn = null;
		
		int beginRow;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			beginRow = (currentPage - 1) * rowPerPage;
			
			list = goodsDao.selectCustomerGoodsListByPage(conn, type, word, sort, rowPerPage, beginRow);
			
			if(list == null) {
				throw new Exception();
			}
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
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
		return list;
	}
	
	// 상품수정
	public int modifyGoods(Goods goods, GoodsImg goodsImg) {
		int row = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			row = goodsDao.updateGoods(conn, goods);
			
			if(row != 0) {
				row = goodsImgDao.updateGoodsImg(conn, goodsImg);
				if(row == 0) {
					throw new Exception();  // 이미지 입력실패시 강제로 롤백(catch절 이동)
				}
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
		return row;
	}
	
	// 상품추가
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		int goodsNo = 0;
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			goodsNo = goodsDao.insertGoods(conn, goods); // goodsNo가 AI로 자동생성되어 DB입력
			System.out.println(goodsNo + " <-- goodsNo");
			
			if(goodsNo != 0) {
				goodsImg.setGoodsImgNo(goodsNo);
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception();  // 이미지 입력실패시 강제로 롤백(catch절 이동)
				}
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
		return goodsNo;
	}
	
	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Connection conn = null;
		Map<String, Object> map = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();	
			map = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			
			if(map == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
		return map;
	}
	
	// 상품 품절 변경
	public boolean modifyGoodsSoldOut(Goods goods) {
		Connection conn = null;
		boolean result = false;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();	
			row = goodsDao.updateGoodsSoldOut(conn, goods);
			
			if(row != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			} else {
				result = true;
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
		return result;
	}
	
	// 상품리스트
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		Connection conn = null;
		
		int beginRow;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();		 			
			beginRow = (currentPage - 1) * rowPerPage;
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
			if(list == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
		return list;
	}
	
	// 상품 마지막 페이지
	public int getGoodsLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();		 			
			totalCount = goodsDao.selectGoodsLastPage(conn, rowPerPage);
			
			if(totalCount == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage += 1;
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
		return lastPage;
	}
}
