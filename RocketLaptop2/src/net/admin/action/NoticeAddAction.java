package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.Notice;
import net.admin.db.NoticeDAO;

public class NoticeAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO ndao = new NoticeDAO();
		Notice notice = new Notice();
		boolean result = false;
		
		String title = request.getParameter("notice_title");
		String content = request.getParameter("notice_content");
		
		notice.setNotice_title(title);
		notice.setNotice_content(content);
		
		result = ndao.noticeInsert(notice);

		if(result == false) {
			System.out.println("공지사항 등록 실패");
			forward.setPath("error/error.jsp");
			request.setAttribute("message", "공지사항 등록 실패");
			forward.setRedirect(false);
			return forward;
		}
		System.out.println("공지사항 등록 완료");
		
		forward.setRedirect(true);
		forward.setPath("NoticeList.ad");
		return forward;
	}

}
