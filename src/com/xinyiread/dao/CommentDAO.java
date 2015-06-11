package com.xinyiread.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.Comment;

@Repository
@Transactional
public interface CommentDAO {

	public long insert(Comment comment);
	
	public List<Map<String, Object>> getBasicCommentListByAid(long aid);
	
}
