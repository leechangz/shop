package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Customer;
import vo.Employee;

public class CustomerService {
	// Action.jsp에서 service를 호출하고 service에서 각 Dao에 있는 메서드를 호출
	
	// 수정
	public int modifyCustomer(Customer paramCustomer) {		
		int result = 0;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao(); 
			if(customerDao.updateCustomer(conn, paramCustomer) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			} else {
				result = 1;
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
	
	// 상품 마지막 페이지
	public int getCustomerLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		CustomerDao customerDao = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			customerDao = new CustomerDao();		 			
			totalCount = customerDao.selectCustomerLastPage(conn, rowPerPage);
			
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
	
	// select
	public List<Customer> getCustomerList(int rowPerPage, int currentPage) {		
		Connection conn = null;
		List<Customer> list = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao(); 
			
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
			
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
	
	// insert
	public boolean addCustomer(Customer paramCustomer) {
		boolean result = true;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao(); 
			if(customerDao.insertCustomer(conn, paramCustomer) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				result = false;
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
		return result;
	}
	
	// delete
	public void removeCustomer(Customer paramCustomer) {		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao(); 
			if(customerDao.deleteCustomer(conn, paramCustomer) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}			
			
			OutIdDao outIdDao = new OutIdDao();
			if(outIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
	}
	
	// login
	public Customer getCustomerByIdAndPw(Customer paramCustomer) {
		Connection conn = null;
		Customer customer = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); 
			// executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
			if(customer == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
			
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
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
		return customer;		
	}
}