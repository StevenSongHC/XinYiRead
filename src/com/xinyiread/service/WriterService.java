package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

public interface WriterService {
	
	public long addWriter(Writer writer);
	
	public long update(Writer writer);
	
	public List<Writer> getWriterList();
	
	public Writer getWriterById(long id);
	
	public Writer getWriterByUser(User user);
	
	public Writer getWriterByPenName(String penName);
	
	public List<Map<String, Object>> getUserCommendWriterHistory(long uid, long wid);
	
	public int commendWriter(long uid, long wid);
	
	public List<Map<String, Object>> getWriterArticleBriefList(Map<String, Object> map);

}
