package com.xinyiread.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xinyiread.model.Article;
import com.xinyiread.model.Comment;
import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.ArticleService;
import com.xinyiread.service.CommentService;
import com.xinyiread.service.WriterService;

@Controller
@RequestMapping("article")
public class ArticleController {

	@Autowired
	private ArticleService aService;
	@Autowired
	private WriterService wService;
	@Autowired
	private CommentService cmtService;
	
	@RequestMapping
	public String browse(ModelMap model) {
		
		return "STATIC/404";
	}
	
	@RequestMapping("{aid}")
	public String readArticle(HttpSession session,
							  ModelMap model,
							  @PathVariable long aid) {
		Map<String, Object> article = aService.getArticleDetailById(aid);
		
		if (article == null)													// article does not existed
			return "STATIC/404";
		
		if (Integer.parseInt(article.get("is_complete").toString()) == 0) {		// article not finished yet
			Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
			if (currentWriter != null && currentWriter.getId() == Integer.parseInt(article.get("wid").toString()))
				return "redirect:/article/draft/" + aid;						// redirect the writer who writes the article to draft page
			return "STATIC/404";												// or redirect to the 404
		}
		
		if (Integer.parseInt(article.get("is_censored").toString()) != 1) {		// article did not pass the audition
			Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
			if (currentWriter != null && currentWriter.getId() == Integer.parseInt(article.get("wid").toString()))
				return "redirect:/article/draft/" + aid;						// redirect the writer who writes the article to draft page
			return "STATIC/404";												// or redirect to the 404
		}
		
		// article content
		model.put("article", article);
		
		// read count + 1
		aService.addReadCount(aid);
		
		// category list
		model.put("categoryList", aService.getAllCategory());
		
		// comment list
		model.put("commentList", cmtService.getCommentListByAid(aid));
		
		// check is in collection
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser != null) {
			model.put("isInCollection", !aService.isInUserArticleCollection(currentUser.getId(), Long.parseLong(article.get("id").toString())).isEmpty());
		}
		
		return "article";
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
		model.put("article", article);
		
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
	@RequestMapping(value = "draft/submit", method = RequestMethod.POST)
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
			
			// set current project
			currentWriter.setCurrentProject(aid);
			
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
			// completed article
			if (article.getIsComplete() == 1) {
				result.put("status", -5);
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
			if (isComplete == 0) {					// just save
				result.put("status", 1);			// save succeed
				// set as current project
				currentWriter.setCurrentProject(article.getId());
			}
			else {
				result.put("status", 2);			// publish, redirect to default writer page
				// remove form current project if it is
				if (currentWriter.getCurrentProject() == article.getId()) {
					currentWriter.setCurrentProject(0);
				}
			}
		}
		// update writer's current project status
		wService.update(currentWriter);

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
	
	@RequestMapping(value = "cancel_publish", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cancelPublish(HttpSession session,
											 long aid) {
		Map<String, Object> result = new HashMap<String, Object>();
		Writer currentWriter = (Writer) session.getAttribute("WRITER_SESSION");
		
		if (currentWriter == null) {
			result.put("status", -1);		// empty writer session
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		
		if (article == null) {
			result.put("status", 0);		// article does not existed
			return result;
		}
		
		if (currentWriter.getId() != article.getWid()) {
			result.put("status", -3);		// not the writer
			return result;
		}
		
		if (article.getIsCensored() == -2) {
			result.put("status", -2);		// locked article
			return result;
		}
		
		// reset isComplete & isCensored
		article.setIsComplete(0);	
		article.setIsCensored(0);
		aService.updateArticle(article);

		// check is article updated
		Article art = aService.getArticleById(aid);
		if (art.getIsComplete() == 0 && art.getIsCensored() == 0)
			result.put("status", 1);		// update failed
		else
			result.put("status", -4);		// update succeed
		
		return result;
	}
	
	@RequestMapping(value = "add_collection", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addCollection(HttpSession session,
			 								 long aid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null) {
			result.put("status", -1);
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		
		if (article == null) {
			result.put("status", 0);
			return result;
		}
		
		// already added to collection b4
		if (!aService.isInUserArticleCollection(currentUser.getId(), article.getId()).isEmpty()) {
			result.put("status", 2);
			return result;
		}
		
		// otherwise add to collection
		aService.addToArticleCollection(currentUser.getId(), article.getId(), new java.sql.Date(new java.util.Date().getTime()));
		
		result.put("status", 1);
		return result;
	}
	
	@RequestMapping(value = "remove_collection", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> removeCollection(HttpSession session,
			 								 	long aid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null) {
			result.put("status", -1);
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		
		if (article == null) {
			result.put("status", 0);
			return result;
		}
		
		// remove
		aService.removeFromArticleCollection(currentUser.getId(), article.getId());
		
		// remove failed
		if (!aService.isInUserArticleCollection(currentUser.getId(), article.getId()).isEmpty()) {
			result.put("status", -2);
			return result;
		}
		
		// done
		result.put("status", 1);
		return result;
	}
	
	@RequestMapping(value = "rating_article", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ratingArticle(HttpSession session,
			 								 long aid,
			 								 String rating) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		
		if (currentUser == null) {
			result.put("status", -1);		// login user required
			return result;
		}
		
		if (aService.getArticleById(aid) == null) {
			result.put("status", 0);		// article does not existed
			return result;
		}
		
		if (!aService.getUserRatingArticleHistory(currentUser.getId(), aid).isEmpty()) {
			result.put("status", 2);		// user already rated
			return result;
		}
		
		if (aService.ratingArticle(currentUser.getId(), aid, rating) == 0) {
			result.put("status", -2);		// illegal rating
			return result;
		}

		result.put("status", 1);			// rating succeed
		return result;
	}
	
	@RequestMapping(value = "comment_article", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentArticle(HttpSession session,
			 								  long aid,
			 								  String word,
			 								  int isAnonymous) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null) {
			result.put("status", -1);		// login user required
			return result;
		}
		
		Article article = aService.getArticleById(aid);
		if (article == null) {
			result.put("status", 0);		// article does not existed
			return result;
		}
		
		// a new comment instance
		Comment comment = new Comment();
		comment.setArticle(article);
		comment.setNid(0);
		comment.setUser(currentUser);
		comment.setWord(word);
		comment.setIsAnonymous(isAnonymous);
		comment.setIsDisplay(1);
		java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
		comment.setSubmitDate(currentDate);
		// save the new comment
		cmtService.addComment(comment);

		result.put("status", 1);			// comment succeed
		return result;
	}
	
	@RequestMapping(value = "report_comment", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reportComment(HttpSession session,
			 								 long cmtid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		User currentUser = (User) session.getAttribute("USER_SESSION");
		if (currentUser == null) {
			result.put("status", -1);		// login user required
			return result;
		}
		
		Comment comment = cmtService.getCommentById(cmtid);
		if (comment == null) {
			result.put("status", 0);		// comment does not existed
			return result;
		}
		
		// comment already been reported
		if (!cmtService.getCommentReportRecord(comment.getId()).isEmpty()) {
			result.put("status", -2);
			return result;
		}
		
		// commit report
		java.sql.Date currentDate = new java.sql.Date(new java.util.Date().getTime());
		cmtService.reportComment(comment.getId(), currentUser.getId(), currentDate, 0);

		result.put("status", 1);			// report succeed
		return result;
	}
	
}
