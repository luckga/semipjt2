package net.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.db.Product;
import net.admin.db.ProductDAO;

public class ProductModifyView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProductDAO pdao = new ProductDAO();
		Product product = new Product();
		
		String product_code = request.getParameter("product_code");
		product = pdao.getProductDetail(product_code);
		
		if(product == null) {
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		request.setAttribute("p", product);
		
		ActionForward forward = new ActionForward();		
		forward.setRedirect(false);
		forward.setPath("admin/productModifyView.jsp");
		return forward;
	}

}
