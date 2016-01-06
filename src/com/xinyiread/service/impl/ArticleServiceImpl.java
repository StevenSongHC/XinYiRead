package com.xinyiread.service.impl;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xinyiread.dao.ArticleDAO;
import com.xinyiread.model.Article;
import com.xinyiread.service.ArticleService;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	ArticleDAO aDao;

	public long addArticle(Article article) {
		return aDao.insertArticle(article);
	}

	public long updateArticle(Article article) {
		return aDao.updateArticle(article);
	}
	
	public Article getArticleById(long id) {
		return aDao.getArticleById(id);
	}
	
	public List<Map<String, Object>> getLatestPublishedArticleList(int quantity) {
		return aDao.getLatestPublishedArticleList(quantity);
	}
	
	public List<Map<String, Object>> getLatestCommentedArticleList(int quantity) {
		return aDao.getLatestCommentedArticleList(quantity);
	}
	
	public List<Map<String, Object>> getLatestLikedArticleList(int quantity) {
		return aDao.getLatestLikedArticleList(quantity);
	}
	
	public List<Map<String, Object>> getLatestArticleListByCategoryName(String categoryName, int quantity) {
		return aDao.getLatestArticleListByCategoryName(categoryName, quantity);
	}
	
	public List<Map<String, Object>> queryArticleList(String keyword, String category, String orderBy, int quantity) {
		return aDao.queryArticleList(keyword, category, orderBy, quantity);
	}
	
	public List<Map<String, Object>> getArticleDetailList() {
		List<Map<String, Object>> articleList = aDao.getArticleDetailList();
		// add tag list
		for (Map<String, Object> article : articleList) {
			article.put("tags", aDao.getArticleTagsById(Integer.parseInt(article.get("id").toString())));
		}
		return articleList;
	}
	
	public Map<String, Object> getArticleDetailById(long id) {
		List<Map<String, Object>> article = aDao.getArticleDetailById(id);
		if (!article.isEmpty()) {
			article.get(0).put("tags", aDao.getArticleTagsById(Integer.parseInt(article.get(0).get("id").toString())));
			return article.get(0);
		}
		else
			return null;
	}
	
	public List<Map<String, Object>> getUncensoredArticleDetailList() {
		return aDao.getUncensoredArticleDetailList();
	}
	
	public List<Map<String, Object>> getCensoredArticleDetailList() {
		return aDao.getCensoredArticleDetailList();
	}
	
	public Article getArticleByTitle(String title) {
		return aDao.getArticleByTitle(title);
	}

	public int updateCategory(int catid, String name) {
		return aDao.updateCategoryName(catid, name);
	}

	public int addCategory(String name) {
		return aDao.insertCategory(name);
	}
	
	public List<Map<String, Object>> getAllCategory() {
		return aDao.getAllCategory();
	}

	public List<Object> getCatidByCategoryName(String name) {
		return aDao.getCatidByCategoryName(name);
	}
	
	public int createTag(String tagName) {
		return aDao.insertTag(tagName);
	}
	
	public int addArticleTag(long id, int tagid) {
		return aDao.insertArticleTag(id, tagid);
	}
	
	public int removeArticleTag(long id) {
		return aDao.deleteArticleTag(id);
	}
	
	public List<Map<String, Object>> getAllTag() {
		return aDao.getAllTag();
	}
	
	public List<Map<String, Object>> getArticleTagsById(long id) {
		return aDao.getArticleTagsById(id);
	}
	
	public List<Object> getTagidByTagName(String tagName) {
		return aDao.getTagidByTagName(tagName);
	}
	
	public int recordCensor(long aid, long uid, int isPass, java.sql.Timestamp time) {
		return aDao.recordCensor(aid, uid, isPass, time);
	}
	
	public List<Map<String, Object>> getCensorRecordByAid(long aid) {
		return aDao.getCensorRecordByAid(aid);
	}
	
	public Map<String, Object> countVariesDataAmount() {
		return aDao.countVariesDataAmount().get(0);
	}
	
	public int addReadCount(long id) {
		return aDao.addReadCount(id);
	}
	
	public List<Map<String, Object>> getUserRatingArticleHistory(long uid, long aid) {
		return aDao.getUserRatingArticleHistory(uid, aid);
	}

	public int ratingArticle(long uid, long aid, String rating, java.sql.Timestamp submitTime) {
		if (rating.equals("up")) {					// like
			aDao.addLikeCount(aid);
			aDao.insertRatingHistory(uid, aid, 1, submitTime);	// record like
		}
		else if (rating.equals("down")) {			// dislike
			aDao.addDislikeCount(aid);
			aDao.insertRatingHistory(uid, aid, 0, submitTime);	// record dislike
		}
		else
			return 0;
		
		return 1;
	}

	public long addToArticleCollection(long uid, long aid, Date createDate) {
		return aDao.addToArticleCollection(uid, aid, createDate);
	}
	
	public int removeFromArticleCollection(long uid, long aid) {
		return aDao.removeFromArticleCollection(uid, aid);
	}

	public List<Map<String, Object>> isInUserArticleCollection(long uid, long aid) {
		return aDao.isInUserArticleCollection(uid, aid);
	}
	
	public List<Map<String, Object>> getUserArticleCollection(long uid) {
		return aDao.getUserArticleCollection(uid);
	}
	
}
