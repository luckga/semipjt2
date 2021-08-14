package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.ProductDAO;

public class ProductSelectionDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] ajaxArr = request.getParameterValues("valueArr");
		ProductDAO pdao = new ProductDAO();
		
		int result = pdao.ProductSelectionDelete(ajaxArr);
		
		System.out.println("result = " + result);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}

}
