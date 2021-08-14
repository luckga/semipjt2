package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.Notice;
import net.admin.db.NoticeDAO;

public class NoticeModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		Notice notice = new Notice();
		NoticeDAO ndao = new NoticeDAO();
		
		boolean result = false;
		int num = Integer.parseInt(request.getParameter("notice_num"));
		String title = request.getParameter("modifyNotice_title");
		String content = request.getParameter("modifyNotice_content");
		
		
		notice.setNotice_num(num);
		notice.setNotice_title(title);
		notice.setNotice_content(content);
		
		result = ndao.noticeModify(notice);
		
		if(result == false) {
			System.out.println("공지사항 글 수정 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "공지사항 글이 수정 되지 않았습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		System.out.println("공지사항 글 수정 성공");
		forward.setRedirect(true);
		forward.setPath("NoticeDetail.ad?num=" + notice.getNotice_num());
		return forward;
	}

}
