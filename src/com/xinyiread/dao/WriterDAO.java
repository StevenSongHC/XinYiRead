package com.xinyiread.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

@Repository
@Transactional
public interface WriterDAO {
	
	public long insert(Writer writer);
	
	public long update(Writer writer);
	
	public List<Writer> getWriterList();
	
	public Writer getWriterById(long id);
	
	public Writer getWriterByUser(User user);

	public Writer getWriterByPenName(String penName);
	
	public int addLikeCount(long id);
	
	public List<Map<String, Object>> getUserCommendWriterHistory(@Param("uid") long uid, @Param("wid") long wid);
	
	public int insertCommendHistory(@Param("uid") long uid, @Param("wid") long wid);
	
	public List<Map<String, Object>> getWriterArticleBriefList(Map<String, Object> map);
	
}
