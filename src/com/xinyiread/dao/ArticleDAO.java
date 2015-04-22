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
	
	// 插入新的文章
	public long insert(Article article);
	
	// 更新文章
	public long update(Article article);
	
	// 通过主键找到文章
	public Article getArticleById(long id);
	
	// 通过标题找到文章
	public Article getArticleByTitle(String title);
	
	// 插入新的分类
	public int insertCategory(String name);

	// 更新分类信息
	public int updateCategoryName(@Param("catid") int catid, @Param("name") String name);

	// 通过标签id得到标签名字
	public List<Object> getCatidByCategoryName(String name);
	
	// 插入新的标签数据
	public int insertTag(String tagName);
	
	// 插入新的文章标签
	public int insertArticleTag(@Param("id") long id, @Param("tagid") int tagid);
	
	// 通过文章主键删除文章的所有标签
	public int deleteArticleTag(long id);
	
	// 获得所有分类列表
	public List<Map<String, Object>> getAllCategory();
	
	// 获取所有标签列表
	public List<Map<String, Object>> getAllTag();
	
	// 通过主键获得文章的标签列表
	public List<Map<String, Object>> getArticleTagById(long id);
	
	// 通过标签id获得标签名字
	public List<Object> getTagidByTagName(String tagName);
	
}
