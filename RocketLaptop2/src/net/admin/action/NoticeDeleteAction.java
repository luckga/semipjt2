package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.NoticeDAO;

public class NoticeDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO ndao = new NoticeDAO();
		boolean result = false;
		
		int num = Integer.parseInt(request.getParameter("notice_num"));
		
		result = ndao.noticeDelete(num);
		
		if(result == false) {
			System.out.println("공지사항 글 삭제 실패");
			forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		System.out.println("공지사항 글 삭제 성공");
		forward = new ActionForward();
		forward.setRedirect(false);
		request.setAttribute("title", "공지사항 삭제");
		request.setAttribute("body", "공지사항 글이 삭제되었습니다.");
		request.setAttribute("path", "NoticeList.ad");
		forward.setPath("Modal/DeleteModal.jsp");
		return forward;
	}

}
