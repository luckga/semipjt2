package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.Notice;
import net.admin.db.NoticeDAO;

public class NoticeModifyView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		Notice notice = new Notice();
		NoticeDAO ndao = new NoticeDAO();
		int num = Integer.parseInt(request.getParameter("num"));
		
		notice = ndao.getNoticeDetail(num);
		
		if(notice == null) {
			System.out.println("(수정)상세보기 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "공지사항 수정 상세보기 실패입니다.");
			forward.setPath("error.error.jsp");
			return forward;
		}
		System.out.println("(수정)상세보기 성공");
		
		request.setAttribute("n", notice);
		
		forward.setRedirect(false);
		forward.setPath("admin/noticeModify.jsp");
		return forward;
		
	}

}
