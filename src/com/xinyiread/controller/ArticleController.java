package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.Article;
import com.xinyiread.model.Writer;
import com.xinyiread.service.ArticleService;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("article")
public class ArticleController {

	@Autowired
	private ArticleService aService;
	@Autowired
	private WriterService wService;
	
	@RequestMapping
	public String browse(ModelMap model) {
		
		return "STATIC/404";
	}
	
	@RequestMapping("draft/new")
	public String newArticle(HttpSession session,
							 ModelMap model) {
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		
		if (currentWriter == null)
			return "redirect:/login";
		
		model.put("categoryList", aService.getAllCategory());	// load all categories
		
		return "WRITER/draft";
	}
	
	@RequestMapping("draft/{aid}")
	public String editArticle(HttpSession session,
							  ModelMap model,
							  @PathVariable long aid) {
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		
		if (currentWriter == null)
			return "redirect:/login";
		
		Map<String, Object> article = aService.getArticleDetailById(aid);
		if (article == null)
			return "STATIC/404";
		
		if (currentWriter.getId() != Long.valueOf(article.get("wid").toString()))
			return "STATIC/no-permission";
		
		model.put("categoryList", aService.getAllCategory());
		model.put("article", article.get(0));
		
		return "WRITER/draft";
	}
	
	/** 
	 * submit the update, publish action included
	 * 提交文章更新
	 * 
	 * @param session
	 * @param aid
	 * @param title
	 * @param content
	 * @param isWriterShow
	 * @param isComplete
	 * @param catid
	 * @param tags
	 * @return
	 */
	@RequestMapping(value = "draft/submit")
	@ResponseBody
	public Map<String, Object> saveArticle(HttpSession session,
										   long aid,
										   String title,
										   String content,
										   int isWriterShow,
										   int isComplete,
										   int catid,
										   @RequestParam(value="tags[]", required=false) String[] tags) {
		Map<String, Object> result = new HashMap<String, Object>();
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		
		if (currentWriter == null) {
			result.put("status", -2);
			return result;
		}
		
		// new article
		if (aid == 0) {
			// existed title
			if (aService.getArticleByTitle(title) != null) {
				result.put("status", -3);
				return result;
			}
			
			Article newArticle = new Article();
			newArticle.setWid(currentWriter.getId());
			newArticle.setTitle(title);
			newArticle.setContent(content);
			newArticle.setIsWriterShow(isWriterShow);
			newArticle.setCatid(catid);
			java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
			newArticle.setPublishDate(currentDate);
			newArticle.setIsComplete(isComplete);
			aService.addArticle(newArticle);
			
			// update aid
			aid = newArticle.getId();
			
			long addr = aService.getArticleByTitle(title).getId(); 
			if (addr != 0) {
				result.put("addr", addr);
				if (isComplete == 0)				// just add
					result.put("status", 0);		// redirect to editing page
				else
					result.put("status", 2);		// directly publish
			}
			else
				result.put("status", -1);			// failed to save
		}
		// save old article
		else {
			// read data
			Article article = aService.getArticleById(aid);
			// non-existed article
			if (article == null) {
				result.put("status", -4);		
				return result;
			}
			// existed title
			Article articleByTitle = aService.getArticleByTitle(title);
			if (articleByTitle != null && articleByTitle.getId() != article.getId()) {
				result.put("status", -3);
				return result;
			}
			article.setTitle(title);
			article.setContent(content);
			article.setIsWriterShow(isWriterShow);
			article.setCatid(catid);
			java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
			article.setPublishDate(currentDate);
			article.setIsComplete(isComplete);
			// update article
			aService.updateArticle(article);
			if (isComplete == 0)					// just save
				result.put("status", 1);			// save succeed
			else
				result.put("status", 2);			// publish, redirect to default writer page
		}

		// remove all tags of the article
		aService.removeArticleTag(aid);
		
		if (tags != null) {
			for (String tag: tags) {
				// create new tag if match no tag record
				if (aService.getTagidByTagName(tag).isEmpty()) {
					aService.createTag(tag);
				}
				// add article tag
				aService.addArticleTag(aid, (int) aService.getTagidByTagName(tag).get(0));
			}
		}
		
		return result;
	}
	
}
