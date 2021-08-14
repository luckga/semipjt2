package net.main.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("여기는 logout");
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		session.invalidate();
		forward.setPath("main.ma");
		forward.setRedirect(true);
		return forward;
	}

}
