package com.xinyiread.interceptor;

import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;
import com.xinyiread.util.CookieUtil;

public class BaseInterceptor implements HandlerInterceptor {
	
	@Autowired
	UserService uService;
	@Autowired
	WriterService wService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		/////////////////////////////
		//////   AUTO LOGIN   ///////
		/////////////////////////////
		// if didn't detective a login user, then check the user cookie to auto login for user
		if (request.getSession().getAttribute("USER_SESSION") == null) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("USER_COOKIE")) {
						String cookieValue = URLDecoder.decode(cookie.getValue(), "utf-8");					// decode cookie value
						
						User user = uService.getUserByName(cookieValue.split(",")[1]);
						if (user != null) {
							String password = cookieValue.split(",")[2];
							
							cookie.setValue("");													// remove the old cookie first
							cookie.setMaxAge(0);
							cookie.setPath("/");
							response.addCookie(cookie);
							
							if (password.equals(user.getPassword())) {
								request.getSession().setAttribute("USER_SESSION", user);			// add user session
								Writer writer = wService.getWriterByUser(user);
								if (writer != null)
									request.getSession().setAttribute("WRITER_SESSION", writer);	// add writer session
								
								response.addCookie(CookieUtil.generateUserCookie(user));			// add the new cookie
							}
							if (request.getSession().getAttribute("USER_SESSION") != null)  		// don't know why the heck does it run 4 times
								break;
						}
						else {
							// clear the wrong cookie
							cookie.setValue("");
							cookie.setMaxAge(0);
							cookie.setPath("/");
							response.addCookie(cookie);
						}
					}	
				}
			}
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
