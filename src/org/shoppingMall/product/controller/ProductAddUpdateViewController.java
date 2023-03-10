package org.shoppingMall.product.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.shoppingMall.controller.Controller;
import org.shoppingMall.dao.FileDAO;
import org.shoppingMall.dao.ProductDAO;
import org.shoppingMall.vo.ProductVO;


public class ProductAddUpdateViewController implements Controller {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		int productNum = Integer.parseInt(request.getParameter("productNum"));	
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO vo = pDao.productSelectOne(productNum);
		
		System.out.println(request.getParameter("fileName"));
		
		request.setAttribute("vo", vo);
		request.setAttribute("fileName", request.getParameter("fileName"));
		request.setAttribute("fileNameOriginal", request.getParameter("fileNameOriginal"));
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("productAddUpdate.jsp");
		dispatcher.forward(request, response);
				
	}

}
