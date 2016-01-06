package com.xinyiread.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.ArticleService;
import com.xinyiread.service.UserService;
import com.xinyiread.service.WriterService;
import com.xinyiread.util.CookieUtil;
import com.xinyiread.util.MD5Util;

@Controller
@SessionAttributes(value={"USER_SESSION","WRITER_SESSION"})
@RequestMapping
public class IndexController {
	
	@Autowired
	private UserService uService;
	@Autowired
	private WriterService wService;
	@Autowired
	private ArticleService aService;
	
	@RequestMapping("index")
	public String index(ModelMap model) {
		// all categories
		List<Map<String, Object>> categoryList = aService.getAllCategory();
		model.put("categories", categoryList);
		// latest published article list
		model.put("latestPublishedArticleList", aService.getLatestPublishedArticleList(10));
		// latest commented article list
		model.put("latestCommentedArticleList", aService.getLatestCommentedArticleList(5));
		// latest liked article list
		model.put("latestLikedArticleList", aService.getLatestLikedArticleList(5));
		// latest articles sorted by category
		List<Map<String, Object>> categoryArticleList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> category : categoryList) {
			Map<String, Object> articleList = new HashMap<String, Object>();
			articleList.put("categoryName", category.get("name").toString());
			articleList.put("articles", aService.getLatestArticleListByCategoryName(category.get("name").toString(), 6));
			categoryArticleList.add(articleList);
		}
		model.put("categoryArticleList", categoryArticleList);
		// special recommendations
		model.put("special", null);
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
	
	@RequestMapping(value = "join/do", method = RequestMethod.POST)
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
		newbie.setPortrait("images/portrait/default.png");
		if (!email.equals(""))
			newbie.setEmail(email);
		java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
		newbie.setJoinDate(currentDate);
		newbie.setLastLoginDate(currentDate);
		
		uService.addUser(newbie);
		
		if (newbie.getId() != 0) {
			if (!penName.equals("")) {
				Writer newWriter = new Writer();
				newWriter.setUser(newbie);
				newWriter.setPenName(penName);
				
				wService.addWriter(newWriter);
				
				// 新建用户和作者并成功
				if (newWriter.getId() != 0) {
					// add writer session
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
			// add user session
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
	
	@RequestMapping(value = "login/do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loginUser(ModelMap model,
										 String account,
										 String password,
										 boolean rememberme,
										 HttpSession session,
										 HttpServletRequest request,
										 HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		// remove old cookie first
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null)
			CookieUtil.removeCookie(request, response, "USER_COOKIE");
		
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
					model.addAttribute("USER_SESSION", loginUser);									// add user session
					Writer loginWriter = wService.getWriterByUser(loginUser);
					if (loginWriter != null)
						model.addAttribute("WRITER_SESSION", loginWriter);							// add writer session
					if (rememberme) {
						response.addCookie(CookieUtil.generateUserCookie(loginUser));				// add cookie
					}
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
				model.addAttribute("USER_SESSION", loginUser);
				Writer loginWriter = wService.getWriterByUser(loginUser);
				if (loginWriter != null)
					model.addAttribute("WRITER_SESSION", loginWriter);
				if (rememberme) {
					response.addCookie(CookieUtil.generateUserCookie(loginUser));
				}
				java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());	// update last login date
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
	
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> logoutUser(SessionStatus sessionStatus,
										  HttpServletRequest request,
										  HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		sessionStatus.setComplete();									// remove session
		CookieUtil.removeCookie(request, response, "USER_COOKIE");		// remove cookie
		
		return result;
	}
	
	@RequestMapping("my_collection")
	public String getCollection(ModelMap model,
								HttpSession session) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null) {
			return "redirect:/login";
		}
		model.put("user", currentUser);
		model.put("articleCollection", aService.getUserArticleCollection(currentUser.getId()));
		return "user-collection";
	}
	
	@RequestMapping("search")
	public String searchArticle(ModelMap model,
								@RequestParam(value="keyword", required=false) String keyword,
								@RequestParam(value="category", required=false) String category,
								@RequestParam(value="order_by", required=false) String orderBy) {
		// flags
		boolean isNotEmptyKeyword = (keyword != null && !keyword.equals(""));
		boolean isNotEmptyCategory = (category != null && !category.equals(""));
		boolean isNotEmptyOrderBy = (orderBy != null && !orderBy.equals(""));
		
		// existed category required
		if (isNotEmptyCategory && aService.getCatidByCategoryName(category).size() == 0) {
			return "redirect:/404";
		}
		// correct orderBy required -> latest_published, most_read, most_like
		if (isNotEmptyOrderBy && !(orderBy.equals("latest_published") || orderBy.equals("most_read") || orderBy.equals("most_like"))) {
			return "redirect:/404";
		}
		
		// all empty, return latest published articles by default
		if (!isNotEmptyKeyword && !isNotEmptyCategory && !isNotEmptyOrderBy) {
			orderBy = "latest_published";
		}
		// only category not empty, return category's latest published articles
		if (!isNotEmptyKeyword && isNotEmptyCategory && !isNotEmptyOrderBy) {
			orderBy = "latest_published";
		}
		System.out.println("ORDERBY " + orderBy);
		// display info
		model.put("keyword", keyword);
		model.put("categoryName", category);
		model.put("orderBy", orderBy);
		model.put("categories", aService.getAllCategory());
		
		// load data
		model.put("articleList", aService.queryArticleList(keyword, category, orderBy, 10));
		
		return "query-articles";
	}
	
	// STATIC INFO PAGES
	@RequestMapping("404")
	public String pageNotFound() {
		return "STATIC/404";
	}
	
	@RequestMapping("no_permission")
	public String noPermission() {
		return "STATIC/no-permission";
	}
	
}
