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

public class ProductDAO {
private DataSource ds;
	
	public ProductDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		}catch(Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	public boolean productInsert(Product product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		try {
			con = ds.getConnection();
			
			// 상품 등록 부분
			String sql = "insert into product "
				+ "(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE, "
				+ " PRODUCT_DETAILS, PRODUCT_STOCK, "
				+ " PRODUCT_STATUS, PRODUCT_IMAGE, PRODUCT_DATE)"
				+ " values(?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_code());
			pstmt.setString(2, product.getCategory_code());
			pstmt.setString(3, product.getProduct_name());
			pstmt.setInt(4, product.getProduct_price());
			pstmt.setString(5, product.getProduct_details());
			pstmt.setInt(6, product.getProduct_stock()); 
			pstmt.setString(7, product.getProduct_status()); 
			pstmt.setString(8, product.getProduct_image()); 
			result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("데이터 삽입이 완료되었습니다.");
				con.commit();
				return true;
			}else {
				con.rollback();
			}
		}catch(Exception ex) {
			System.out.println("productInsert() 에러 : " + ex);
			if(con != null) {
				try {
					con.rollback();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
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
					con.setAutoCommit(true);
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		return false;
	} // productInsert() end

	public int getProductListCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int p = 0;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select count(*) from product");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				p = rs.getInt(1);
			}
		}catch(Exception ex) {
			System.out.println("getProductListCount() 에러 : " + ex);
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
		return p;
	} // getProdcutListCount() end

	public int getProductListCount(String field, String value) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int p = 0;
		try {
			con = ds.getConnection();
			String sql = "select count(*) "
						+"from (select rownum rnum, p.* "
						+	  	"from (select p.product_code, p.category_code, c.category_name, p.product_name, " 
						+	  		  "p.product_price, p.product_details, p.product_stock, p.product_status, "  
						+	  		  "p.product_image, p.product_sales, p.product_date " 
						+	  		  "from product p, category c " 
						+	  		  "where p.category_code = c.category_code " 
						+	  		  "order by product_code asc) p " 
						+	    "where " + field + " like ?"
						+      ")";
			System.out.println(sql);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + value + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				p = rs.getInt(1);
				System.out.println(p);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getProductListCount() 에러: " + ex);
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
		
		return p;
	} // getProductListCount() end

	public List<Product> getProductList(int page, int limit) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// page : 페이지
		// limit : 페이지 당 목록의 수
		
		String product_list_sql = "select * "
								 +"from (select rownum rnum, p.* "
								 +	  	"from (select p.product_code, p.category_code, c.category_name, p.product_name, " 
								 +	  		  "p.product_price, p.product_details, p.product_stock, p.product_status, "  
								 +	  		  "p.product_image, p.product_sales, p.product_date " 
								 +	  		  "from product p, category c " 
								 +	  		  "where p.category_code = c.category_code " 
								 +	  		  "order by product_code asc) p " 
								 +	    ") " 
								 +"where rnum >= ? and rnum <= ?";
		
		List<Product> list = new ArrayList<Product>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호(10 20 30 40 ... )
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(product_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB에서 가져온 데이터를 VO객체에 담습니다.
			while(rs.next()) {
				Product product = new Product();
				product.setProduct_code(rs.getString("product_code"));
				product.setCategory_code(rs.getString("category_code"));
				product.setCategory_name(rs.getString("category_name"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_details(rs.getString("product_details"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_status(rs.getString("product_status"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_date(rs.getString("product_date"));
				list.add(product); // 값을 담은 객체를 리스트에 저장합니다.
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
	} // getProductList() end

	public List<Product> getProductList(String field, String value, int page, int limit) {
		List<Product> list = new ArrayList<Product>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			
			String sql = "select * "
					 	+"from (select rownum rnum, p.* "
					 	+	   "from (select p.product_code, p.category_code, c.category_name, p.product_name, " 
					 	+	  		  "p.product_price, p.product_details, p.product_stock, p.product_status, "  
					 	+	  		  "p.product_image, p.product_sales, p.product_date " 
					 	+	  		  "from product p, category c " 
					 	+	  		  "where p.category_code = c.category_code " 
					 	+	  		  "order by product_code asc) p " 
						+	   "where " + field + " like ? "
						+     ") " 
						+"where rnum >= ? and rnum <= ?";
			System.out.println(sql);
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + value + "%");
			int startrow = (page - 1) * limit + 1;
			
			int endrow = startrow + limit - 1;
			
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				product.setProduct_code(rs.getString("product_code"));
				product.setCategory_code(rs.getString("category_code"));
				product.setCategory_name(rs.getString("category_name"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_details(rs.getString("product_details"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_status(rs.getString("product_status"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_date(rs.getString("product_date"));
				list.add(product);
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
	} // getProductList() end

	public Product getProductDetail(String product_code) {
		Product product = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select p.* " 
					+"from (select p.product_code, p.category_code, c.category_name, p.product_name, " 
					+	   "p.product_price, p.product_details, p.product_stock, p.product_status, "
					+	   "p.product_image, p.product_sales, p.product_date "  
					+	   "from product p, category c " 
					+	   "where p.category_code = c.category_code " 
					+	   "order by product_code asc) p " 
					+"where product_code = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  product_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				product = new Product();
				product.setProduct_code(rs.getString("product_code"));
				product.setCategory_code(rs.getString("category_code"));
				product.setCategory_name(rs.getString("category_name"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_details(rs.getString("product_details"));
				product.setProduct_stock(rs.getInt("product_stock"));
				product.setProduct_status(rs.getString("product_status"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_date(rs.getString("product_date"));
			}
		}catch(Exception ex) {
			System.out.println("getDetail() 에러 : " + ex);
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
		return product;
	} // getProductDetail() end

	public boolean productModify(Product product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update product "
					+"set PRODUCT_NAME=?, PRODUCT_PRICE=?, PRODUCT_DETAILS=?, "
					+"PRODUCT_STOCK=?, PRODUCT_STATUS=?, PRODUCT_IMAGE=? "
					+"where PRODUCT_CODE=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_name());
			pstmt.setInt(2, product.getProduct_price());
			pstmt.setString(3, product.getProduct_details());
			pstmt.setInt(4, product.getProduct_stock());
			pstmt.setString(5, product.getProduct_status());
			pstmt.setString(6, product.getProduct_image());
			pstmt.setString(7, product.getProduct_code());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("성공 업데이트");
				return true;
			}
		}catch(SQLException ex){
			System.out.println("productModify() 에러 : " + ex);
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
	} // productModify() end

	public boolean productDelete(String product_code) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "delete product "
				   + "where PRODUCT_CODE=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product_code);
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("삭제 성공");
				return true;
			}
		}catch(SQLException ex){
			System.out.println("productDelete() 에러 : " + ex);
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
	} // productDelete() end

	public int ProductSelectionDelete(String[] ajaxArr) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "delete product where product_code in ("; 
		for(int i = 0; i < ajaxArr.length; i++) {
			sql += "'" + ajaxArr[i] + "'";
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
	} // ProductSelectionDelete() end
}
