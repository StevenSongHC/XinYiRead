package com.xinyiread.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xinyiread.model.User;


public class CookieUtil {
	
	public final static int COOKIE_MAX_AGE = 60 * 60 * 24;			// cookie 最大生命值, cookie's max life = 1 day
	
	// 生成包含用户信息的 cookie
	public static Cookie generateUserCookie(User user) {
		// cookie contains id, name, encrypted password
		Cookie cookie = null;
		try {
			cookie = new Cookie("USER_COOKIE", URLEncoder.encode(user.getId()+","+user.getName()+","+user.getPassword(), "utf-8"));
		cookie.setMaxAge(COOKIE_MAX_AGE);
		cookie.setPath("/");
		System.out.println("cookie: "+cookie.getValue());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cookie;
	}
	
	// 删除cookie
	public static void removeCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					cookie.setValue("");
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}
	}

}
