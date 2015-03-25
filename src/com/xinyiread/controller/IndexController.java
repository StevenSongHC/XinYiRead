package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;
import com.xinyiread.util.CookieUtil;
import com.xinyiread.util.MD5Util;

@Controller
@SessionAttributes("USER_SESSION")
@RequestMapping
public class IndexController {
	
	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	
	@RequestMapping("index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("getTerms")
	public String getTerms() {
		return "STATIC/terms";
	}
	
	@RequestMapping("join")
	public String join() {
		return "join";
	}
	
	@RequestMapping(value = "join/do")
	@ResponseBody
	public Map<String, Object> registerUser(ModelMap model,
											String name,
											String password,
											String email,
											String penName,
											SessionStatus sessionStatus,
											HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// remove old cookie first
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null)
			CookieUtil.removeCookie(request, response, "USER_COOKIE");
		
		User newbie = new User();
		
		newbie.setName(name);
		newbie.setPassword(MD5Util.encryptCode(password));
		if (!email.equals(""))
			newbie.setEmail(email);
		java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
		newbie.setJoinDate(currentDate);
		newbie.setLastLoginDate(currentDate);
		
		uService.addUser(newbie);
		
		if (newbie.getId() != 0) {
			if (!penName.equals("")) {
				Writer newWriter = new Writer();
				newWriter.setUid(newbie.getId());
				newWriter.setPenName(penName);
				
				wService.addWriter(newWriter);
				
				// 新建用户和作者并成功
				if (newWriter.getId() != 0) {
					result.put("code", 1);
				}
				// 仅成功地新建了用户
				else
					result.put("code", -1);
			}
			// 仅仅新建用户并成功
			else
				result.put("code", 1);
			// add session
			model.addAttribute("USER_SESSION", newbie);
			result.put("username", newbie.getName());
		}
		// 新建用户失败
		else
			result.put("code", 0);
		
		return result;
	}
	
	@RequestMapping("login")
	public String login() {
		return "login";
	}
	
	@RequestMapping(value = "login/do")
	@ResponseBody
	public Map<String, Object> loginUser(ModelMap model,
										 String account,
										 String password,
										 boolean rememberme,
										 SessionStatus sessionStatus,
										 HttpSession session,
										 HttpServletRequest request,
										 HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// remove old cookie first
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null)
			CookieUtil.removeCookie(request, response, "USER_COOKIE");
		
		// 尝试用用户名登陆
		User loginUser = new User();
		loginUser = uService.getUserByName(account);
		if (loginUser == null) {
			// 尝试用邮箱登陆
			loginUser = uService.getUserByEmail(account);
			if (loginUser == null) {
				result.put("code", 0);				// invalid account
			}
			else {		// 用邮箱登陆
				if (MD5Util.authenticateInputPassword(loginUser.getPassword(), password)) {
					model.addAttribute("USER_SESSION", loginUser);						// add session
					if (rememberme) {
						response.addCookie(CookieUtil.generateUserCookie(loginUser));	// add cookie
					}
					result.put("code", 1);
				}
				else {
					result.put("code", -1);			// wrong password
				}
			}
		}
		else {			// 用用户名登陆
			if (MD5Util.authenticateInputPassword(loginUser.getPassword(), password)) {
				model.addAttribute("USER_SESSION", loginUser);
				if (rememberme) {
					response.addCookie(CookieUtil.generateUserCookie(loginUser));
				}
				result.put("code", 1);
			}
			else {
				result.put("code", -1);
			}
		}
		
		return result;
	}
	
}
