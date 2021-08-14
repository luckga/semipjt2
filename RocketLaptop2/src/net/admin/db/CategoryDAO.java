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

public class CategoryDAO {
private DataSource ds;
	
	public CategoryDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	public List<Category> getCategoryList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String category_list_sql = "select * from category";
		
		List<Category> list = new ArrayList<Category>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(category_list_sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Category category = new Category();
				category.setCategory_code(rs.getString("category_code"));
				category.setCategory_name(rs.getString("category_name"));
				list.add(category);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getCategoryList() 에러 : " + ex);
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
	}
	
	
}
