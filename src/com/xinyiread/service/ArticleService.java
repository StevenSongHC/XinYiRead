package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.Article;

public interface ArticleService {
	
	public long addArticle(Article article);
	
	public long updateArticle(Article article);
	
	public Article getArticleById(long id);
	
	public List<Map<String, Object>> getArticleDetailList();
	
	public List<Map<String, Object>> getArticleDetailById(long id);
	
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
	
}
