package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.Comment;

public interface CommentService {

	public long addComment(Comment comment);
	
	public Comment getCommentById(long id);
	
	public List<Map<String, Object>> getCommentListByAid(long aid);
	
	public int reportComment(long cmtid, long uid, java.sql.Date submitDate, int isHandle);
	
	public List<Map<String, Object>> getUserReportCommentRecord(long uid, long cmtid);
	
}
