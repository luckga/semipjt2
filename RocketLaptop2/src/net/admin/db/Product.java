package net.admin.db;

public class Product {
	private String product_code; // 상품코드
	private String category_code; // 카테고리 코드
	private String category_name; // 카테고리 테이블의 카테고리 이름
	private String product_name; // 상품명
	private int product_price; // 상품가격
	private String product_details; // 상품 상세정보
	private int product_stock; // 재고 수
	private String product_status; // 상품 상태
	private String product_image; // 상품 이미지
	private int product_sales; // 상품 판매량
	private String product_date; // 상품 등록일
	
	public String getProduct_code() {
		return product_code;
	}
	
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	
	public String getCategory_code() {
		return category_code;
	}

	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	
	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getProduct_name() {
		return product_name;
	}
	
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public String getProduct_details() {
		return product_details;
	}
	
	public void setProduct_details(String product_details) {
		this.product_details = product_details;
	}
	
	public int getProduct_stock() {
		return product_stock;
	}
	
	public void setProduct_stock(int product_stock) {
		this.product_stock = product_stock;
	}
	
	public String getProduct_status() {
		return product_status;
	}
	
	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}
	
	public String getProduct_image() {
		return product_image;
	}
	
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	
	public int getProduct_sales() {
		return product_sales;
	}
	
	public void setProduct_sales(int product_sales) {
		this.product_sales = product_sales;
	}
	
	public String getProduct_date() {
		return product_date;
	}
	
	public void setProduct_date(String product_date) {
		this.product_date = product_date.substring(0, 10);
	}
}
