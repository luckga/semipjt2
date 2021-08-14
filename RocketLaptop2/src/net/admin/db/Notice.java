package net.admin.db;

public class Notice {
	private int notice_num;
	private String notice_title;
	private String notice_content;
	private String notice_date;
	private int notice_readcount;
	
	public int getNotice_num() {
		return notice_num;
	}
	
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	
	public String getNotice_title() {
		return notice_title;
	}
	
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	
	public String getNotice_content() {
		return notice_content;
	}
	
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	
	public String getNotice_date() {
		return notice_date.substring(0, 10);
	}
	
	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}
	
	public int getNotice_readcount() {
		return notice_readcount;
	}
	
	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}
	
}
