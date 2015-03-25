package com.xinyiread.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xinyiread.model.User;
import com.xinyiread.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserService uService;
	
	@RequestMapping
	public String index(HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		// if no login, redirect to login page
		if (currentUser == null)
			return "redirect:/login";
		// else redirect to current user's homepage
		return "redirect:/user/i/" + currentUser.getName();
	}
	
	@RequestMapping("i/{username}")
	public String homepage(ModelMap model,
						   @PathVariable String username) {
		User user = uService.getUserByName(username);
		
		if (user == null)
			return "STATIC/404";
		
		model.addAttribute("user", user);
		return "USER/homepage";
	}
	
	@RequestMapping("hello")
	public String hello(ModelMap model) {
		List<String> list1 = new ArrayList<String>();
		List<Object> list2 = new ArrayList<Object>();
		list1.add("H");
		list1.add("3");
		list1.add("L");
		list1.add("L");
		list1.add("0");
		list2.add(9);
		list2.add(true);
		list2.add("Дадада");
		model.put("list1", list1);
		model.put("list2", list2);
		return "USER/hello";
	}
	
	@RequestMapping("list")
	public String listUser(ModelMap model) {
		model.addAttribute("userList", uService.getUserList());
		return "USER/list";
	}

}
