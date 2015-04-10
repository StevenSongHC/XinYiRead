package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("ajax")
public class AjaxController {

	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	
	@ResponseBody
	@RequestMapping("greeting")
	public Map<String, Object> greeting(String data) {
		Map<String, Object> result = new HashMap<String, Object>();
		Logger androidLog = Logger.getLogger("managerLogger");
		androidLog.info("HelloAndroind - " + data);
		result.put("msg", "Ajax Greeting!");
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkUsername")
	public Map<String, Object> isUsernameExisted(String username) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uService.getUserByName(username) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkEmail")
	public Map<String, Object> isEmailExisted(String email) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uService.getUserByEmail(email) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("checkPenName")
	public Map<String, Object> isPenNameExisted(String penName) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (wService.getWriterByPenName(penName) != null)
			result.put("isExisted", true);
		else
			result.put("isExisted", false);
		return result;
	}
	
}
