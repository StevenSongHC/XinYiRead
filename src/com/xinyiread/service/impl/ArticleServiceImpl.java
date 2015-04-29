package com.xinyiread.service.impl;

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
	
	public List<Map<String, Object>> getArticleDetailList() {
		List<Map<String, Object>> articleList = aDao.getArticleDetailList();
		// add tag list
		for (Map<String, Object> article : articleList) {
			article.put("tags", aDao.getArticleTagsById(Integer.parseInt(article.get("id").toString())));
		}
		return articleList;
	}
	
	public List<Map<String, Object>> getArticleDetailById(long id) {
		List<Map<String, Object>> article = aDao.getArticleDetailById(id);
		if (!article.isEmpty())
			article.get(0).put("tags", aDao.getArticleTagsById(Integer.parseInt(article.get(0).get("id").toString())));
		return article;
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
	
}
