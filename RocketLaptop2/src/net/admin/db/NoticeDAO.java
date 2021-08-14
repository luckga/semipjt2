package net.admin.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {
	private DataSource ds;
	
	public NoticeDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	public boolean noticeInsert(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try{
			con = ds.getConnection();
			
			String max_sql = "(select nvl(max(notice_num), 0)+1 from notice)";
			
			String sql = "insert into notice "
					   + "values(" + max_sql + ", ?, ?, sysdate, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getNotice_title());
			pstmt.setString(2, notice.getNotice_content());
			pstmt.setInt(3, 0);
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("데이터 삽입이 완료되었습니다.");
				return true;
			}
			
		}catch(Exception ex) {
			System.out.println("noticeInsert() 에러 : " + ex);
			ex.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return false;
	} // noticeInsert() end

	public int getNoticeListCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int n = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select count(*) from notice");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt(1);
			}
		}catch(Exception ex) {
			System.out.println("getNoticeListCount() 에러 : " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return n;
	} // getNoticeListCount() end

	public List<Notice> getNoticeList(int page, int limit) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// page : 페이지
		// limit : 페이지 당 목록의 수
		// board_re_ref desc, board_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위만큼 가져오는 쿼리문입니다.
		
		String notice_list_sql = "select * "
							   +"from (select rownum rnum, notice_num, notice_title, notice_content, notice_date, notice_readcount"
							   +"	   from (select * "
							   +"	  		 from notice "
							   +"	  		 order by notice_date desc)"
							   +"	  )"
							   +"where rnum >= ? and rnum <= ?";
		
		List<Notice> list = new ArrayList<Notice>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호(10 20 30 40 ... )
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(notice_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB에서 가져온 데이터를 VO객체에 담습니다.
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_num(rs.getInt("notice_num"));
				notice.setNotice_title(rs.getString("notice_title"));
				notice.setNotice_content(rs.getString("notice_content"));
				notice.setNotice_date(rs.getString("notice_date"));
				notice.setNotice_readcount(rs.getInt("notice_readcount"));
				list.add(notice); // 값을 담은 객체를 리스트에 저장합니다.
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getNoticeList() 에러 : " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return list;
	} // getNoticeList() end

	public void ReadCountUpdate(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "update notice "
					+"set NOTICE_READCOUNT=NOTICE_READCOUNT+1 "
					+"where NOTICE_NUM = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			System.out.println("ReadCountUpdate() 에러 : " + ex);
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		
	} // setReadCountUpdate() end

	public Notice getNoticeDetail(int num) {
		Notice notice = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from notice where NOTICE_NUM = ?");
			pstmt.setInt(1,  num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				notice = new Notice();
				notice.setNotice_num(rs.getInt("notice_num"));
				notice.setNotice_title(rs.getString("notice_title"));
				notice.setNotice_content(rs.getString("notice_content"));
				notice.setNotice_date(rs.getString("notice_date"));
				notice.setNotice_readcount(rs.getInt("notice_readcount"));
			}
		}catch(Exception ex) {
			System.out.println("getNoticeDetail() 에러 : " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return notice;
	} // getNoticeDetail() end

	public boolean noticeModify(Notice notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update notice "
					+"set NOTICE_TITLE=?, NOTICE_CONTENT=?"
					+"where NOTICE_NUM=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getNotice_title());
			pstmt.setString(2, notice.getNotice_content());
			pstmt.setInt(3, notice.getNotice_num());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("성공 업데이트");
				return true;
			}
		}catch(SQLException ex){
			System.out.println("noticeModify() 에러 : " + ex);
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return false;
	} // noticeModify() end

	public boolean noticeDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "delete notice "
				   + "where NOTICE_NUM=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("삭제 성공");
				return true;
			}
		}catch(SQLException ex){
			System.out.println("noticeDelete() 에러 : " + ex);
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return false;
	} // noticeDelete() end

	public int getNoticeListCount(String field, String value) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int n = 0;
		try {
			con = ds.getConnection();
			String sql = "select count(*) from notice "
					   + "where " + field + " like ?";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + value + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				n = rs.getInt(1);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getNoticeListCount() 에러: " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		
		return n;
	} // getNoticeListCount() end

	public List<Notice> getNoticeList(String field, String value, int page, int limit) {
		List<Notice> list = new ArrayList<Notice>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			String sql = "select * " + 
					   "from (select rownum rnum, notice_num, notice_title, notice_content, notice_date, notice_readcount " + 
					   "	  from (select * " + 
					   "	  	    from notice " + 
					   "	        where " + field + " like ? " + 
					   "	        order by notice_date desc)" + 
					   "	  )" + 
					   "where rnum between ? and ?";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + value + "%");
			int startrow = (page - 1) * limit + 1;
			
			int endrow = startrow + limit - 1;
			
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				notice.setNotice_num(rs.getInt("notice_num"));
				notice.setNotice_title(rs.getString("notice_title"));
				notice.setNotice_content(rs.getString("notice_content"));;
				notice.setNotice_date(rs.getString("notice_date"));
				notice.setNotice_readcount(rs.getInt("notice_readcount"));
				list.add(notice);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getNoticeList() 에러: " + ex);
		}finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		
		return list;
	} // getNoticeList() end

	public int NoticeSelectionDelete(String[] ajaxArr) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "delete notice where notice_num in ("; 
		for(int i = 0; i < ajaxArr.length; i++) {
			sql += ajaxArr[i];
			if(i != ajaxArr.length - 1) {
				sql += ", ";
			}
		}
		sql += ")";
		
		System.out.println("sql = " + sql);
		
		int result = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			result = pstmt.executeUpdate();
		}catch(SQLException ex){
			System.out.println("NoticeSelectionDelete() 에러 : " + ex);
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
			
			if(con != null) {
				try{
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return result;
	} // NoticeSelectionDelete() end
	
}
