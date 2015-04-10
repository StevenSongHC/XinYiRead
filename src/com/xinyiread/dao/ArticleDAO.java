package com.xinyiread.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.Article;

@Repository
@Transactional
public interface ArticleDAO {
	
	public long insert(Article article);
	
	public long update(Article article);
	
	public Article getArticleById(long id);
	
	public Article getArticleByTitle(String title);
	
	public int insertCategory(@Param("name") String name);

	public int updateCategoryName(@Param("catid") int catid, @Param("name") String name);
	
	public List<Map<String, Object>> getAllCategory();

	public List<Object> getCatidByCategoryName(String name);
	
	public List<Map<String, Object>> getAllTag();
	
}
