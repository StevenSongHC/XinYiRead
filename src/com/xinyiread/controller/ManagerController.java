package com.xinyiread.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.Article;
import com.xinyiread.model.Comment;
import com.xinyiread.model.User;
import com.xinyiread.service.ArticleService;
import com.xinyiread.service.CommentService;
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
	@Autowired
	private CommentService cmtService;
	
	@RequestMapping
	public String mainPage(ModelMap model,
						   HttpSession session,
						   String menu,
						   String submenu,
						   @RequestParam(value="query_data", required=false) String queryData) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		// go to admin page
		if (uService.getUserRoleListById(currentUser.getId()).contains(1)) {
			// go to default page while receiving illegal data
			if (menu == null || (!menu.equals("user") && !menu.equals("article") && 
					!menu.equals("message") && !menu.equals("comment") && !menu.equals("permission") && !menu.equals("more")))
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
			else if (menu.equals("permission")) {
				if (submenu== null || (!submenu.equals("user_role") && !submenu.equals("role_privilege") && !submenu.equals("role_list") && !submenu.equals("privilege_list")))
					return "redirect:/manager?menu=permission&submenu=user_role";
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
		// go to manager page
		else {
			List<Object> userRoles = uService.getUserRoleListById(currentUser.getId());
			model.put("userRoles", userRoles);

			int firstRole = Integer.parseInt(userRoles.get(0).toString());
			String redirectPage = "";

			/*
			 * 根据用户第一个角色（列表按照角色id顺序排）载入默认的数据项
			 * load default data, which means redirect to a default page, base on the user's first role, since the list item ordered by the sequence of role's id
			 */ 
			switch (firstRole) {
				case 3:
					redirectPage = "redirect:/manager?query_data=uncensored_article";
					break;
				case 4:
					redirectPage = "redirect:/manager?query_data=reported_comment";
					break;
				case 5:
					redirectPage = "redirect:/manager?query_data=message";
					break;
				default:
					redirectPage = "redirect:/no_permission";		// consider it as a second check
			}
			
			// load default data
			if (queryData == null)
				return redirectPage;
			
			if (queryData != null) {
				// some statistics
				model.put("variesAmount", aService.countVariesDataAmount());
				
				if (queryData.equals("uncensored_article")) {
					// make sure that user requires the proper data
					if (userRoles.contains(3)) {
						System.out.println("LOAD UNCENSORED_ARTICLE");
						model.put("dataPage", "uncensored_article");
					}
					else
						return redirectPage;	// or load default data
				}
				else if (queryData.equals("censored_article")) {
					if (userRoles.contains(3)) {
						System.out.println("LOAD CENSORED_ARTICLE");
						model.put("dataPage", "censored_article");
					}
					else
						return redirectPage;
				}
				else if (queryData.equals("reported_comment")) {
					if (userRoles.contains(4)) {
						System.out.println("LOAD REPORTED_COMMENT");
						model.put("dataPage", "reported_comment");
					}
					else
						return redirectPage;
				}
				else if (queryData.equals("message")) {
					if (userRoles.contains(5)) {
						System.out.println("LOAD MESSAGE");
						model.put("dataPage", "message");
					}
					else
						return redirectPage;
				}
				else
					return redirectPage;		// illegal queryData, load default data
			}
			return "MANAGER/censor";
		}
	}
	
	@RequestMapping("load/user_list")
	public String loadUserList(ModelMap model) {
		model.put("userList", uService.getUserList());
		return "MANAGER/DATA/user-list";
	}
	
	@RequestMapping("load/user_writer")
	public String loadUserWriter(ModelMap model) {
		model.put("writerList", wService.getWriterList());
		return "MANAGER/DATA/user-writer";
	}

	@RequestMapping("load/article_list")
	public String loadArticleList(ModelMap model) {
		model.put("articleList", aService.getArticleDetailList());
		return "MANAGER/DATA/article-list";
	}
	
	@RequestMapping("load/article_category")
	public String loadArticleCategory(ModelMap model) {
		model.put("categoryList", aService.getAllCategory());
		return "MANAGER/DATA/article-category";
	}
	
	@RequestMapping("load/article_tag")
	public String loadArticleTag(ModelMap model) {
		model.put("tagList", aService.getAllTag());
		return "MANAGER/DATA/article-tag";
	}
	
	@RequestMapping("load/permission_user_role")
	public String loadUserRole(ModelMap model) {
		model.put("userRoleList", uService.getAllUserRoleList());
		return "MANAGER/DATA/permission-user-role";
	}
	
	@RequestMapping("load/permission_role_privilege")
	public String loadRolePrivilege(ModelMap model) {
		model.put("rolePrivilegeList", uService.getAllRolePrivilegeList());
		return "MANAGER/DATA/permission-role-privilege";
	}
	
	@RequestMapping("load/permission_role_list")
	public String loadRoleList(ModelMap model) {
		model.put("roleList", uService.getRoleList());
		return "MANAGER/DATA/permission-role-list";
	}
	
	@RequestMapping("load/permission_privilege_list")
	public String loadPrivilegeList(ModelMap model) {
		model.put("privilegeList", uService.getPrivilegeList());
		return "MANAGER/DATA/permission-privilege-list";
	}
	
	@RequestMapping("load/uncensored_article")
	public String loadUncensoredArticle(ModelMap model) {
		model.put("articleList", aService.getUncensoredArticleDetailList());
		return "MANAGER/DATA/uncensored-article";
	}
	
	@RequestMapping("load/censored_article")
	public String loadCensoredArticle(ModelMap model) {
		model.put("articleList", aService.getCensoredArticleDetailList());
		return "MANAGER/DATA/censored-article";
	}
	
	@RequestMapping("load/reported_comment")
	public String loadReportedComment(ModelMap model) {
		model.put("reportList", cmtService.getReportedCommentDetailList());
		return "MANAGER/DATA/reported-comment";
	}
	
	@RequestMapping("censorship/article/{aid}")
	public String censorArticlePage(ModelMap model,
						   HttpSession session,
						   @PathVariable long aid) {
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		// requires admin or censor role
		if (!uService.getUserRoleListById(currentUser.getId()).contains(1) &&
				!uService.getUserRoleListById(currentUser.getId()).contains(2) &&
				!uService.getUserRoleListById(currentUser.getId()).contains(3)) {
			return "redirect:/no_permission";
		}
		
		Map<String, Object> article = aService.getArticleDetailById(aid);
		
		if (article == null)
			return "STATIC/404";
		
		model.put("article", article);
		model.put("censorRecord", aService.getCensorRecordByAid(aid));
		
		return "MANAGER/article-censorship";
	}
	
	@RequestMapping("precensor/article")
	@ResponseBody
	public Map<String, Object> prepareCensor(ModelMap model,
										     HttpSession session,
										     long aid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		if (currentUser == null) {
			result.put("code", -1);		// null user
		}
		
		List<Object> roles = uService.getUserRoleListById(currentUser.getId());
		if (!roles.contains(1) && !roles.contains(2) && !roles.contains(3)) {
			result.put("code", -3);		// no permission
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		
		if (article == null) {
			result.put("code", 0);		// article not existed
			return result;
		}
		
		if (article.getIsCensored() == -2) {
			result.put("code", -2);		// article locked
			return result;
		}
		
		// censored already
		if (article.getIsCensored() == -1) {
			result.put("code", 2);
			result.put("result", "未通过");
			return result;
		}
		if (article.getIsCensored() == 1) {
			result.put("code", 2);
			result.put("result", "已通过");
			return result;
		}
		
		article.setIsCensored(-2);		// lock article
		aService.updateArticle(article);
		result.put("code", 1);			// good
		return result;
	}
	
	@RequestMapping("docensor/article")
	@ResponseBody
	public Map<String, Object> doCensor(ModelMap model,
									    HttpSession session,
									    long aid,
									    int isPass) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		if (!uService.getUserRoleListById(currentUser.getId()).contains(1) &&
				!uService.getUserRoleListById(currentUser.getId()).contains(2) &&
				!uService.getUserRoleListById(currentUser.getId()).contains(3)) {
			result.put("status", -1);	// no permission
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		
		if (article == null) {
			result.put("status", 0);	// article not existed
			return result;
		}
		
		article.setIsCensored(isPass);
		if (isPass == 1) {				// passage granted date as publish date
			java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
			article.setPublishDate(currentDate);
		}
		aService.updateArticle(article);
		
		// record this censor result
		java.sql.Timestamp currentTime = new java.sql.Timestamp(new java.util.Date().getTime());
		aService.recordCensor(aid, currentUser.getId(), isPass, currentTime);
		
		result.put("status", 1);		// succeed
		return result;
	}
	
	@RequestMapping("setArticleLocker")
	@ResponseBody
	public Map<String, Object> setArticleLocker(long aid,
												int censorStatus) {
		Map<String, Object> result = new HashMap<String, Object>();
		Article article = aService.getArticleById(aid);
		if (article != null) {
			article.setIsCensored(censorStatus);
			aService.updateArticle(article);
		}
		return result;
	}
	
	@RequestMapping("handleCommentReport")
	@ResponseBody
	public Map<String, Object> handleCommentReport(long cmtid,
												   int isBlock) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (isBlock != 0 && isBlock != 1) {
			result.put("status", -1);
			return result;
		}
		Comment comment = cmtService.getCommentById(cmtid);
		if (comment == null) {
			result.put("status", 0);
			return result;
		}
		
		// block the comment
		if (isBlock == 1) {
			cmtService.blockComment(comment.getId());
		}
		// ignore the report
		else {
			cmtService.ignoreCommentReport(comment.getId());
		}
		result.put("status", 1);
		return result;
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
			// log
			Logger log = Logger.getLogger("managerLogger");
			log.info("Add category: " + name);
		}
		return result;
	}
	
	@RequestMapping(value = "update/category")
	@ResponseBody
	public Map<String, Object> updateCategory(int catid,
											  String name,
											  String oldName) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Object> cid = aService.getCatidByCategoryName(name);
		
		if (!cid.isEmpty()) {
			result.put("code", 0);		// 已存在该分类记录
		}
		else {
			aService.updateCategory(catid, name);
			result.put("code", 1);		// 更新成功
			
			Logger log = Logger.getLogger("managerLogger");
			log.info("Modify category[№" + catid + "]: " + oldName + " -> " + name);
		}
		return result;
	}
	
}
