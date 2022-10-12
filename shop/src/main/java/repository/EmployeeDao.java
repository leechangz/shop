package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Employee;

public class EmployeeDao {
	
	// 고객 강제 탈퇴
	public int deleteCustomerAdmin(Connection conn, String customerId) throws SQLException { // 동일한 Connection 사용
		// 동일한 conn 사용하므로 conn.close() X
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 상품리스트 마지막페이지
	public int selectEmployeeLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM employee";
		
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
	
	// 사원 active 변경
	public int updateEmployeeActive(Connection conn, Employee employee) throws SQLException {
		int row = 0;
		String sql = "UPDATE employee SET active = ? WHERE employee_id = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getActive());
			stmt.setString(2, employee.getEmployeeId());
			
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 사원 리스트
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Employee> list = null;
		Employee employee = null;
		
		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, active FROM employee ORDER BY create_date LIMIT ?, ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			list = new ArrayList<Employee>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
		} finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		
		return list;
	}
	
	// 가입
	// EmployeeService.addEmployee 가 호출
	public int insertEmployee(Connection conn, Employee paraEmployee) throws SQLException {
		int row = 0;
		String sql = "INSERT INTO employee (employee_id, employee_pass, employee_name, update_date, create_date) VALUES (?, PASSWORD(?), ?, now(), now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraEmployee.getEmployeeId());
			stmt.setString(2, paraEmployee.getEmployeePass());
			stmt.setString(3, paraEmployee.getEmployeeName());
			
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 탈퇴
	// EmployeeService.removeEmployee 가 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws SQLException { // 동일한 Connection 사용
		// 동일한 conn 사용하므로 conn.close() X
		int row = 0;
		String sql = "DELETE FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 로그인
	// EmployeeService.getEmployeeByIdAndPw 가 호출
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee login) throws SQLException{
		Employee employee = null;
		
		String sql = "SELECT employee_id employeeId, employee_pass employeePass, employee_name employeeName, active, create_date createDate FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, login.getEmployeeId());
			stmt.setString(2, login.getEmployeePass());
			rs = stmt.executeQuery();
			if(rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeePass(rs.getString("employeePass"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setActive(rs.getString("active"));	
				employee.setCreateDate(rs.getString("createDate"));
			}
		}finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}		
		return employee;	
	}
}
