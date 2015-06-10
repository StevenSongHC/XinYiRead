package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

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
	
	public List<Map<String, Object>> getUserRatingArticleHistory(@Param("aid") long aid, @Param("uid") long uid);
	
	public int ratingArticle(long aid, long uid, String rating);
	
}
