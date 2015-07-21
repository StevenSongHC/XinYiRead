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

	public Comment getCommentById(long id) {
		return cmtDao.getCommentById(id);
	}

	public List<Map<String, Object>> getCommentListByAid(long aid) {
		return cmtDao.getBasicCommentListByAid(aid);
	}
	
	public int reportComment(long cmtid, long uid, java.sql.Date submitDate, int isHandle) {
		return cmtDao.reportComment(cmtid, uid, submitDate, isHandle);
	}
	
	public List<Map<String, Object>> getCommentReportRecord(long cmtid) {
		return cmtDao.getCommentReportRecord(cmtid);
	}
	
	public List<Map<String, Object>> getReportedCommentDetailList() {
		return cmtDao.getUnhandleReportedCommentDetailList();
	}

	public int blockComment(long cmtid) {
		// hide the comment
		cmtDao.updateCommentVisibleById(cmtid, 0);
		// set report's handle status
		cmtDao.handleCommentAllReportById(cmtid);
		return 0;
	}

	public int ignoreCommentReport(long cmtid) {
		cmtDao.updateCommentVisibleById(cmtid, 1);
		cmtDao.handleCommentAllReportById(cmtid);
		return 0;
	}
	
}
