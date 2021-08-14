package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.Notice;
import net.admin.db.NoticeDAO;

public class NoticeDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Notice notice = new Notice();
		NoticeDAO ndao = new NoticeDAO();
		int num = Integer.parseInt(request.getParameter("num"));
		
		ndao.ReadCountUpdate(num);
		notice = ndao.getNoticeDetail(num);
		
		if(notice == null) {
			System.out.println("상세보기 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("상세보기 성공");
		
		request.setAttribute("n", notice);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		
		forward.setPath("admin/noticeDetailView.jsp");
		return forward;
	}

}
