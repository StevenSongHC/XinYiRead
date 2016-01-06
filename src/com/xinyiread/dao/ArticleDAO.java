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
	public long insertArticle(Article article);
	
	// 更新文章
	public long updateArticle(Article article);
	
	// 通过主键找到文章
	public Article getArticleById(long id);
	
	// 获取对应数量的最新发布文章列表
	public List<Map<String, Object>> getLatestPublishedArticleList(int quantity);
	
	// 获取对应数量的最新被评论文章列表
	public List<Map<String, Object>> getLatestCommentedArticleList(int quantity);
	
	// 获取对应数量的最新被点赞文章列表
	public List<Map<String, Object>> getLatestLikedArticleList(int quantity);
	
	// 获取所给类别名字对应数量的最新文章列表
	public List<Map<String, Object>> getLatestArticleListByCategoryName(@Param("categoryName") String categoryName, @Param("quantity") int quantity);
	
	// 得到文章所有信息详细列表
	public List<Map<String, Object>> getArticleDetailList();
	
	// 通过主键查找文章详细信息
	public List<Map<String, Object>> getArticleDetailById(long id);
	
	// 查询未审核的文章详细列表
	public List<Map<String, Object>> getUncensoredArticleDetailList();
	
	// 查询审核过的文章详细列表
	public List<Map<String, Object>> getCensoredArticleDetailList();
	
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
	public List<Map<String, Object>> getArticleTagsById(long id);
	
	// 通过标签id获得标签名字
	public List<Object> getTagidByTagName(String tagName);
	
	// 记录文章审核结果
	public int recordCensor(@Param("aid") long aid, @Param("uid") long uid, @Param("cr_is_pass") int isPass, @Param("time") java.sql.Timestamp time);
	
	// 查询文章审核记录
	public List<Map<String, Object>> getCensorRecordByAid(long aid);
	
	// 统计一些记录数
	public List<Map<String, Object>> countVariesDataAmount();
	
	// 阅读量+1
	public int addReadCount(long id);
	
	// 喜欢量+1
	public int addLikeCount(long id);
	
	// 不喜欢量+1
	public int addDislikeCount(long id);
	
	// 检查用户是否已评价文章
	public List<Map<String, Object>> getUserRatingArticleHistory(@Param("uid") long uid, @Param("aid") long aid);
	
	// 插入文章评价文章记录
	public int insertRatingHistory(@Param("uid") long uid, @Param("aid") long aid, @Param("rating") int rating, @Param("submitTime") java.sql.Timestamp submitTime);
	
	// 添加收藏
	public long addToArticleCollection(@Param("uid") long uid, @Param("aid") long aid, @Param("createDate") java.sql.Date createDate);
	
	// 删除收藏
	public int removeFromArticleCollection(@Param("uid") long uid, @Param("aid") long aid);
	
	// 检查收藏是否已存在
	public List<Map<String, Object>> isInUserArticleCollection(@Param("uid") long uid, @Param("aid") long aid);
	
	// 获取用户文章收藏列表
	public List<Map<String, Object>> getUserArticleCollection(long uid);
	
}
