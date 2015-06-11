package com.xinyiread.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xinyiread.dao.CommentDAO;
import com.xinyiread.model.Comment;
import com.xinyiread.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentDAO cmtDao;

	public long addComment(Comment comment) {
		return cmtDao.insert(comment);
	}

	public List<Map<String, Object>> getCommentListByAid(long aid) {
		return cmtDao.getBasicCommentListByAid(aid);
	}
	
}
