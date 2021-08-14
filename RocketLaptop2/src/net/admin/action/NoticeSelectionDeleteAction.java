package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.NoticeDAO;

public class NoticeSelectionDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] ajaxArr = request.getParameterValues("valueArr");
		NoticeDAO ndao = new NoticeDAO();
		
		int result = ndao.NoticeSelectionDelete(ajaxArr);
		
		System.out.println(result);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}

}
