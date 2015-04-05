package com.xinyiread.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.xinyiread.model.User;
import com.xinyiread.service.UserService;

@Controller
@RequestMapping("manager")
public class ManagerController {

	@Autowired
	private UserService uService;
	
	@RequestMapping
	public String mainPage(ModelMap model,
						   HttpSession session,
						   String menu,
						   String submenu) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		// go to admin page
		if (uService.getUserAdministrativeCategoryById(currentUser.getId()).contains(0)) {
			if (menu == null) {
				return "redirect:/manager?menu=user&submenu=list";
			}
			if (menu.equals("user")) {
				model.put("menu", "user");
				if (submenu.equals("list")) {
					model.put("userList", uService.getUserList());
					model.put("submenu", "list");
				}
				else if (submenu.equals("writer")) {

					model.put("submenu", "writer");
				}
				else if (submenu.equals("history")) {

					model.put("submenu", "history");
				}
				else if (submenu.equals("bookmark")) {

					model.put("submenu", "bookmark");
				}
				else if (submenu.equals("collection")) {

					model.put("submenu", "collection");
				}
			}
			else if (menu.equals("article")) {
				model.put("menu", "article");
			}
			else if (menu.equals("message")) {
				model.put("menu", "message");
			}
			else if (menu.equals("comment")) {
				model.put("menu", "comment");
			}
			else if (menu.equals("authority")) {
				model.put("menu", "authority");
			}
			else if (menu.equals("more")) {
				model.put("menu", "more");
			}
			else {
				return "redirect:/manager?menu=user&submenu=list";
			}
			return "MANAGER/admin";
		}
		return "MANAGER/censor";
	}
	
	@RequestMapping("load/{displayDataPage}")
	public String loadUserList(@PathVariable String displayDataPage) {
		return "MANAGER/DATA/" + displayDataPage;
	}
	
}
