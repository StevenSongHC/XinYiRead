package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;
import com.xinyiread.util.MD5Util;

@Controller
@RequestMapping("android")
public class AndroidController {
	
	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	
	@ResponseBody
	@RequestMapping("login")
	public Map<String, Object> login(String account,
			 						 String password) {
		Map<String, Object> result = new HashMap<String, Object>();

		// 先尝试用用户名登陆
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
					result.put("user", loginUser);									// put user info JSON format
					Writer loginWriter = wService.getWriterByUser(loginUser);
					if (loginWriter != null)
						result.put("writer", loginWriter);							// put writer info JSON format
					java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());	// update last login date
					loginUser.setLastLoginDate(currentDate);
					uService.updateUser(loginUser);
					result.put("code", 1);
				}
				else {
					result.put("code", -1);			// wrong password
				}
			}
		}
		else {			// 用用户名登陆
			if (MD5Util.authenticateInputPassword(loginUser.getPassword(), password)) {
				result.put("user", loginUser);
				Writer loginWriter = wService.getWriterByUser(loginUser);
				if (loginWriter != null)
					result.put("writer", loginWriter);
				java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
				loginUser.setLastLoginDate(currentDate);
				uService.updateUser(loginUser);
				result.put("code", 1);
			}
			else {
				result.put("code", -1);
			}
		}
		return result;
	}
	
}
