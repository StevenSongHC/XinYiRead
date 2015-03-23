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
import org.springframework.web.bind.support.SessionStatus;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;
import com.xinyiread.util.MD5Util;

@Controller
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
		
		// logout first
		/*User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null) {
			sessionStatus.setComplete();
			CookieUtil.removeCookie(request, response, "USER_COOKIE");
		}*/
		
		System.out.println("name " + name);
		System.out.println("password " + password);
		System.out.println("email " + email);
		System.out.println("penName" + penName);
		
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
					model.addAttribute("WRITER_SESSION", newWriter);
					result.put("code", 1);
				}
				// 仅成功地新建了用户
				else
					result.put("code", -1);
			}
			// 仅仅新建用户并成功
			else
				result.put("code", 1);
			
			result.put("username", newbie.getName());
		}
		// 新建用户失败
		else
			result.put("code", 0);
		
		// login
		model.addAttribute("USER_SESSION", newbie);
		/*response.addCookie(CookieUtil.generateUserCookie(newbie));*/
		
		result.put("userName", newbie.getName());
		
		return result;
	}
	
}
