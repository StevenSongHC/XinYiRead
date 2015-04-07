package com.xinyiread.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.User;
import com.xinyiread.service.ArticleService;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("manager")
public class ManagerController {

	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	@Autowired
	private ArticleService aService;
	
	@RequestMapping
	public String mainPage(ModelMap model,
						   HttpSession session,
						   String menu,
						   String submenu) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		// go to admin page
		if (uService.getUserAdministrativeCategoryById(currentUser.getId()).contains(0)) {
			// go to default page while receiving illegal data
			if (menu == null || (!menu.equals("user") && !menu.equals("article") && 
					!menu.equals("message") && !menu.equals("comment") && !menu.equals("authority") && !menu.equals("more")))
				return "redirect:/manager?menu=user&submenu=list";
			
			if (menu.equals("user")) {
				if (submenu== null || (!submenu.equals("list") && !submenu.equals("writer") && 
						!submenu.equals("history") && !submenu.equals("bookmark") && !submenu.equals("collection")))
					return "redirect:/manager?menu=user&submenu=list";
			}
			else if (menu.equals("article")) {
				if (submenu== null || (!submenu.equals("list") && !submenu.equals("category") && !submenu.equals("tag")))
					return "redirect:/manager?menu=article&submenu=list";
			}
			else if (menu.equals("message")) {
				if (submenu== null || !submenu.equals("list"))
					return "redirect:/manager?menu=message&submenu=list";
			}
			else if (menu.equals("comment")) {
				if (submenu== null || (!submenu.equals("list") && !submenu.equals("unhandled_list") && !submenu.equals("handled_list")))
					return "redirect:/manager?menu=comment&submenu=list";
			}
			else if (menu.equals("authority")) {
				if (submenu== null || !submenu.equals("list"))
					return "redirect:/manager?menu=authority&submenu=list";
			}
			else if (menu.equals("more")) {
				if (submenu== null || !submenu.equals("modify_password"))
					return "redirect:/manager?menu=more&submenu=modify_password";
			}
			else {
				return "redirect:/manager?menu=user&submenu=list";
			}
			
			model.put("menu", menu);
			model.put("submenu", submenu);
			
			return "MANAGER/admin";
		}
		return "MANAGER/censor";
	}
	
	@RequestMapping("load/user_list")
	public String loadUserList(ModelMap model) {
		model.put("userList", uService.getUserList());
		return "MANAGER/DATA/user-list";
	}

	@RequestMapping("load/article_list")
	public String loadArticleList(ModelMap model) {
		
		return "MANAGER/DATA/article-list";
	}
	
	@RequestMapping("load/article_category")
	public String loadArticleCategory(ModelMap model) {
		model.put("categoryList", aService.getAllCategory());
		return "MANAGER/DATA/article-category";
	}
	
	@RequestMapping(value = "insert/category")
	@ResponseBody
	public Map<String, Object> insertCategory(String name) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Object> cid = aService.getCatidByCategoryName(name);
		
		if (!cid.isEmpty()) {
			result.put("code", 0);		// 已存在该分类记录
		}
		else {
			aService.addCategory(name);
			result.put("code", 1);		// 新建成功
		}
		return result;
	}
	
	@RequestMapping(value = "update/category")
	@ResponseBody
	public Map<String, Object> updateCategory(int catid,
											  String name) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Object> cid = aService.getCatidByCategoryName(name);
		
		if (!cid.isEmpty()) {
			result.put("code", 0);		// 已存在该分类记录
		}
		else {
			aService.updateCategory(catid, name);
			result.put("code", 1);		// 更新成功
		}
		return result;
	}
	
}
