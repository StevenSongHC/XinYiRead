package com.xinyiread.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xinyiread.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService uService;
	
	@RequestMapping("hello")
	public String hello(ModelMap model) {
		model.addAttribute("msg", "HelloWorld");
		return "USER/hello";
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		model.addAttribute("userList", uService.getUserList());
		return "USER/list";
	}

}
