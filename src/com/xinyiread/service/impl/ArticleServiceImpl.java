package com.xinyiread.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
	
	public List<Map<String, Object>> getUserRatingArticleHistory(@Param("aid") long aid, @Param("uid") long uid) {
		return aDao.getUserRatingArticleHistory(aid, uid);
	}

	public int ratingArticle(long aid, long uid, String rating) {
		if (rating.equals("up")) {					// like
			aDao.addLikeCount(aid);
			aDao.insertRatingHistory(aid, uid, 1);	// record like
		}
		else if (rating.equals("down")) {			// dislike
			aDao.addDislikeCount(aid);
			aDao.insertRatingHistory(aid, uid, 0);	// record dislike
		}
		else
			return 0;
		
		return 1;
	}
	
	
}
