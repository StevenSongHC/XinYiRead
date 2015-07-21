package com.xinyiread.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.Comment;

@Repository
@Transactional
public interface CommentDAO {

	public long insert(Comment comment);
	
	public Comment getCommentById(long id);
	
	public List<Map<String, Object>> getBasicCommentListByAid(long aid);
	
	public int reportComment(@Param("cmtid") long cmtid, @Param("uid") long uid, @Param("cmtr_submit_date") java.sql.Date submitDate, @Param("cmtr_is_handle") int isHandle);
	
	public List<Map<String, Object>> getCommentReportRecord(long cmtid);

	public List<Map<String, Object>> getUnhandleReportedCommentDetailList();
	
	public int updateCommentVisibleById(@Param("cmtid") long cmtid, @Param("is_display") int isDisplay);
	
	public int handleCommentAllReportById(long cmtid);
	
}
