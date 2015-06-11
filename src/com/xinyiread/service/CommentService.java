package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.Comment;

public interface CommentService {

	public long addComment(Comment comment);
	
	public List<Map<String, Object>> getCommentListByAid(long aid);
	
}
