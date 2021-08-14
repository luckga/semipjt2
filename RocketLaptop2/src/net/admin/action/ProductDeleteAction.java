package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.ProductDAO;

public class ProductDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		ProductDAO pdao = new ProductDAO();
		boolean result = false;
		
		String product_code = request.getParameter("product_code");
		
		result = pdao.productDelete(product_code);
		
		if(result == false) {
			System.out.println("상품 삭제 실패");
			forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		System.out.println("상품 삭제 성공");
		forward = new ActionForward();
		forward.setRedirect(false);
		request.setAttribute("title", "상품 삭제");
		request.setAttribute("body", "상품이 삭제되었습니다.");
		request.setAttribute("path", "ProductList.ad");
		forward.setPath("Modal/DeleteModal.jsp");
		return forward;
	}

}
