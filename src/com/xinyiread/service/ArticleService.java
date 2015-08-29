package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.Article;

public interface ArticleService {
	
	public long addArticle(Article article);
	
	public long updateArticle(Article article);
	
	public Article getArticleById(long id);
	
	public List<Map<String, Object>> getArticleDetailList();
	
	public Map<String, Object> getArticleDetailById(long id);
	
	public List<Map<String, Object>> getUncensoredArticleDetailList();
	
	public List<Map<String, Object>> getCensoredArticleDetailList();
	
	public Article getArticleByTitle(String title);

	public int addCategory(String name);
	
	public int updateCategory(int catid, String name);
	
	public int createTag(String tagName);
	
	public int addArticleTag(long id, int tagid);
	
	public int removeArticleTag(long id);

	public List<Map<String, Object>> getAllCategory();

	public List<Object> getCatidByCategoryName(String name);
	
	public List<Map<String, Object>> getAllTag();
	
	public List<Map<String, Object>> getArticleTagsById(long id);
	
	public List<Object> getTagidByTagName(String tagName);
	
	public int recordCensor(long aid, long uid, int isPass, java.sql.Timestamp time);
	
	public List<Map<String, Object>> getCensorRecordByAid(long aid);
	
	public Map<String, Object> countVariesDataAmount();
	
	public int addReadCount(long id);
	
	public List<Map<String, Object>> getUserRatingArticleHistory(long uid, long aid);
	
	public int ratingArticle(long uid, long aid, String rating);
	
	public long addToCollection(long uid, long aid, java.sql.Date createDate);
	
	public int removeFromCollection(long uid, long aid);
	
	public List<Map<String, Object>> isInUserCollection(long uid, long aid);
	
}
