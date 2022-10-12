package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;
import vo.Employee;

public class CustomerDao {
	
	// 수정
	public int updateCustomer(Connection conn, Customer paraCustomer) throws SQLException { // 동일한 Connection 사용
		int row = 0;
		String sql = "UPDATE customer SET customer_name = ?, customer_address = ?, customer_telephone = ?, update_date = NOW()"
				+ " WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerName());
			stmt.setString(2, paraCustomer.getCustomerAddress());
			stmt.setString(3, paraCustomer.getCustomerTelephone());
			stmt.setString(4, paraCustomer.getCustomerId());
			stmt.setString(5, paraCustomer.getCustomerPass());
			
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
		
	// 상품리스트 마지막페이지
	public int selectCustomerLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM customer";
		
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
	
	// 사원 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Customer> list = null;
		Customer customer = null;
		
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress,create_date createDate"
				+ " FROM customer ORDER BY create_date LIMIT ?, ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			list = new ArrayList<Customer>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCreateDate(rs.getString("createDate"));
	
				list.add(customer);
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
	// CustomerService.addCustomer 가 호출
	public int insertCustomer(Connection conn, Customer paraCustomer) throws SQLException {
		int row = 0;
		String sql = "INSERT INTO customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES (?, PASSWORD(?), ?, ?, PASSWORD(?), now(), now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerId());
			stmt.setString(2, paraCustomer.getCustomerPass());
			stmt.setString(3, paraCustomer.getCustomerName());
			stmt.setString(4, paraCustomer.getCustomerAddress());
			stmt.setString(5, paraCustomer.getCustomerTelephone());
			
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 탈퇴
	// CustomerService.removeCustomer 가 호출
	public int deleteCustomer(Connection conn, Customer paraCustomer) throws SQLException { // 동일한 Connection 사용
		// 동일한 conn 사용하므로 conn.close() X
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerId());
			stmt.setString(2, paraCustomer.getCustomerPass());
			row = stmt.executeUpdate();
		}finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 로그인
	// CustomerService.getCustomerByIdAndPw 가 호출
	public Customer selectCustomerByIdAndPw(Connection conn, Customer login) throws SQLException{
		Customer customer = null;
		
		String sql = "SELECT customer_id customerId, customer_name customerName,"
				+ " customer_address customerAddress, customer_telephone customerTelephone, create_date createDate"
				+ " FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, login.getCustomerId());
			stmt.setString(2, login.getCustomerPass());
			rs = stmt.executeQuery();
			if(rs.next()) {
				customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setCreateDate(rs.getString("createDate"));
			}
		}finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}		
		return customer;	
	}
}
