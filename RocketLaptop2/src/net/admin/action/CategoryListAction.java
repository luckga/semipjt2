package net.admin.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import net.admin.db.Category;
import net.admin.db.CategoryDAO;

public class CategoryListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CategoryDAO cdao = new CategoryDAO();
		List<Category> categorylist = new ArrayList<Category>();
		
		categorylist = cdao.getCategoryList();
		
		JsonObject object = new JsonObject();
		
		JsonElement je = new Gson().toJsonTree(categorylist);
		System.out.println("categorylist = " + je.toString());
		object.add("categorylist", je);
		
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().println(object.toString());
		System.out.println(object.toString());
		return null;
	}

}
