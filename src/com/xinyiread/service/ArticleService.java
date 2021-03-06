package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.Article;

public interface ArticleService {
	
	public long addArticle(Article article);
	
	public long updateArticle(Article article);
	
	public Article getArticleById(long id);
	
	public List<Map<String, Object>> getLatestPublishedArticleList(int quantity);
	
	public List<Map<String, Object>> getLatestCommentedArticleList(int quantity);
	
	public List<Map<String, Object>> getLatestLikedArticleList(int quantity);
	
	public List<Map<String, Object>> getLatestArticleListByCategoryName(String categoryName, int quantity);
	
	public List<Map<String, Object>> queryArticleList(String keyword, String category, String orderBy, int quantity);
	
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
	
	public int ratingArticle(long uid, long aid, String rating, java.sql.Timestamp submitTime);
	
	public long addToArticleCollection(long uid, long aid, java.sql.Date createDate);
	
	public int removeFromArticleCollection(long uid, long aid);
	
	public boolean isInUserArticleCollection(long uid, long aid);
	
	public List<Map<String, Object>> getUserArticleCollection(long uid);
	
	public long addToArticleBookmark(long uid, long aid, String aParaId, java.sql.Timestamp createTime);
	
	public List<Map<String, Object>> retrieveUserArticleBookmark(long uid, long aid);
	
	public boolean isInUserArticleBookmark(long uid, long aid, String aParaId);
	
}
