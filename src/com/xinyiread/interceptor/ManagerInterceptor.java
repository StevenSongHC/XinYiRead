package com.xinyiread.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.xinyiread.model.User;
import com.xinyiread.service.UserService;

public class ManagerInterceptor implements HandlerInterceptor {

	@Autowired
	UserService uService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		User currentUser = (User) request.getSession().getAttribute("USER_SESSION");
		// redirect to the login page
		if (currentUser == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		// redirect to the warning page
		if (uService.getUserAdministrativeCategoryById(currentUser.getId()).isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/no_permission");
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView modelAndView) throws Exception {
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

}
