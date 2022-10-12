package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.EmployeeDao;
import repository.GoodsDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	// Action.jsp에서 service를 호출하고 service에서 각 Dao에 있는 메서드를 호출
	
	// 고객 강제 탈퇴
	public int removeCustomerAdmin(String customerId) {		
		int result = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			OutIdDao outIdDao = new OutIdDao();
			if(employeeDao.deleteCustomerAdmin(conn, customerId) != 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				result = outIdDao.insertOutId(conn, customerId);
				if(result == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
					throw new Exception();
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
	
	// 상품 마지막 페이지
	public int getEmployeeLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		EmployeeDao employeeDao = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			employeeDao = new EmployeeDao();		 			
			totalCount = employeeDao.selectEmployeeLastPage(conn, rowPerPage);
			
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
	
	// active update
	public void modifyEmployeeActive(Employee employee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.updateEmployeeActive(conn, employee) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				System.out.print("1");
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
	}
	
	// select
	public List<Employee> getEmployeeList(int rowPerPage, int currentPage) {		
		Connection conn = null;
		List<Employee> list = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);
			
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
	public boolean addEmployee(Employee paramEmployee) {
		boolean result = true;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.insertEmployee(conn, paramEmployee) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
	public void removeEmployee(Employee paramEmployee) {		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.deleteEmployee(conn, paramEmployee) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
			OutIdDao outIdDao = new OutIdDao();
			if(outIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		Connection conn = null;
		Employee employee = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); 
			// executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			if(employee == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
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
			
		return employee;
		
	}
}