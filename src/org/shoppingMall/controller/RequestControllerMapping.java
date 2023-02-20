package org.shoppingMall.controller;

import java.util.HashMap;
import java.util.Map;


import org.shoppingMall.product.controller.ProductActionController;
import org.shoppingMall.product.controller.ProductAddController;
import org.shoppingMall.product.controller.ProductAddDeleteController;
import org.shoppingMall.product.controller.ProductAddViewController;
import org.shoppingMall.cart.controller.CartViewController;
import org.shoppingMall.community.controller.CommunityListController;
import org.shoppingMall.index.controller.DeleteRecommendProductController;
import org.shoppingMall.index.controller.IndexRecommendProductController;
import org.shoppingMall.index.controller.NewRecommendProductController;
import org.shoppingMall.login.controller.LoginActionController;
import org.shoppingMall.login.controller.LoginViewController;
import org.shoppingMall.login.controller.LogoutController;
import org.shoppingMall.mypage.controller.CustomerController;
import org.shoppingMall.mypage.controller.DeleteViewController;
import org.shoppingMall.mypage.controller.UpdateActionController;
import org.shoppingMall.mypage.controller.UpdateViewController;
import org.shoppingMall.mypage.controller.UpdateViewController;
import org.shoppingMall.product.controller.ProductAddPaymentController;
import org.shoppingMall.product.controller.ProductAddPaymentViewController;
import org.shoppingMall.product.controller.ProductAddController;
import org.shoppingMall.product.controller.ProductAddDeleteController;
import org.shoppingMall.product.controller.ProductAddViewController;
import org.shoppingMall.product.controller.ProductListViewContoller;
import org.shoppingMall.product.controller.UpdateController;
import org.shoppingMall.product.controller.ProductViewContoller;
import org.shoppingMall.register.controller.RegisterActionController;
import org.shoppingMall.register.controller.RegisterController;
import org.shoppingMall.search.controller.SearchController;

public class RequestControllerMapping 
{
	private static final Map<RequestKeyValue,Controller> mapping = new HashMap<>();
	
	public static void init()
	{	
		 // index
		 mapping.put(new RequestKeyValue("/RecommendUpdate","GET"), new IndexRecommendProductController());
		 mapping.put(new RequestKeyValue("/RecommendUpdate","POST"), new NewRecommendProductController());
		 mapping.put(new RequestKeyValue("/RecommendDelete","GET"), new DeleteRecommendProductController());
		 
		 // search
		 mapping.put(new RequestKeyValue("/search","GET"), new SearchController());

		// Register
		mapping.put(new RequestKeyValue("/member/register.hrd","GET"), new RegisterController());
		mapping.put(new RequestKeyValue("/member/register.hrd","POST"), new RegisterActionController());
		
		// Login
		mapping.put(new RequestKeyValue("/login","GET"), new LoginViewController());
		mapping.put(new RequestKeyValue("/login","POST"), new LoginActionController());
		mapping.put(new RequestKeyValue("/logout","GET"), new LogoutController());
		
		//mypage
		mapping.put(new RequestKeyValue("/update","GET"), new UpdateViewController());
	  mapping.put(new RequestKeyValue("/update","POST"), new UpdateActionController());
	  mapping.put(new RequestKeyValue("/deleteForm","GET"), new DeleteViewController());
	  mapping.put(new RequestKeyValue("/deleteForm","POST"), new CustomerController());
    
    // Product
		mapping.put(new RequestKeyValue("/Product/product","GET"), new ProductViewContoller());
		mapping.put(new RequestKeyValue("/Product/product", "POST"), new ProductActionController());
		mapping.put(new RequestKeyValue("/Product/productList","GET"), new ProductListViewContoller());
		mapping.put(new RequestKeyValue("/Product/productAdd", "GET"), new ProductAddViewController());
		mapping.put(new RequestKeyValue("/Product/productAdd", "POST"), new ProductAddController());
		mapping.put(new RequestKeyValue("/Product/productAddUpdate", "GET"), new UpdateViewController());
		mapping.put(new RequestKeyValue("/Product/productAddUpdate", "POST"), new UpdateController());
		mapping.put(new RequestKeyValue("/Product/productAddDelete", "GET"), new ProductAddDeleteController());
		mapping.put(new RequestKeyValue("/Product/productAddPayment", "GET"), new ProductAddPaymentViewController());
		mapping.put(new RequestKeyValue("/Product/productAddPayment", "POST"), new ProductAddPaymentController());
		mapping.put(new RequestKeyValue("/Product/productAddPayment", "POST"), new ProductAddPaymentController());

		//cart
		mapping.put(new RequestKeyValue("/cart", "GET"), new CartViewController());
		
		//community
		mapping.put(new RequestKeyValue("/community/communitylist", "GET"), new CommunityListController());
	}
	
	public static Controller getController(RequestKeyValue key)
	{return mapping.get(key);}
}	// Class end
