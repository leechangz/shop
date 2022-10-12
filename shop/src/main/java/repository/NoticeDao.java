package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDao {
	
	// 수정
	public int insertNotice(Connection conn, Notice paramNotice) throws SQLException {
		int row = 0;
		
		String sql = "INSERT INTO notice (notice_title, notice_content, employee_id, update_date, create_date)"
				+ " VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			stmt.setString(3, paramNotice.getEmployeeId());
			
			row = stmt.executeUpdate();
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 수정
	public int updateNotice(Connection conn, Notice paramNotice) throws SQLException {
		int row = 0;
		
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?"
				+ " WHERE notice_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			stmt.setInt(3, paramNotice.getNoticeNo());
			
			row = stmt.executeUpdate();
		} finally {
			if(stmt!=null) {
				stmt.close();
			}
		}
		return row;
	}
	
	// 상세보기
	public Notice selectNoticeOne(Connection conn, int noticeNo) throws SQLException {
		Notice notice = null;
		
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent,"
				+ " employee_id employeeId, create_date createDate FROM notice"
				+ " WHERE notice_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setEmployeeId(rs.getString("employeeId"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setCreateDate(rs.getString("createDate"));
			}
		} finally {
			if(rs!=null)   {
				rs.close();
			}
			if(stmt!=null) {
				stmt.close();
			}
		}
		
		
		return notice;
	}
	// 상품리스트 마지막페이지
	public int selectNoticeLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM notice";
		
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
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Notice> list = null;
		Notice notice = null;
		
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, employee_Id employeeId, create_date createDate"
				+ " FROM notice ORDER BY create_date LIMIT ?, ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			list = new ArrayList<Notice>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setEmployeeId(rs.getString("employeeId"));
				notice.setCreateDate(rs.getString("createDate"));
	
				list.add(notice);
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
}
