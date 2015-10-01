package com.xinyiread.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xinyiread.dao.WriterDAO;
import com.xinyiread.model.User;
import com.xinyiread.model.Writer;
import com.xinyiread.service.WriterService;

@Service
public class WriterServiceImpl implements WriterService {
	
	@Autowired
	WriterDAO wDao;
	
	public long addWriter(Writer writer) {
		return wDao.insert(writer);
	}
	
	public long update(Writer writer) {
		return wDao.update(writer);
	}
	
	public List<Writer> getWriterList() {
		return wDao.getWriterList();
	}
	
	public Writer getWriterById(long id) {
		return wDao.getWriterById(id);
	}

	public Writer getWriterByUser(User user) {
		return wDao.getWriterByUser(user);
	}
	
	public Writer getWriterByPenName(String penName) {
		return wDao.getWriterByPenName(penName);
	}
	
	public List<Map<String, Object>> getUserCommendWriterHistory(long uid, long wid) {
		return wDao.getUserCommendWriterHistory(uid, wid);
	}

	public int commendWriter(long uid, long wid) {
		wDao.addLikeCount(wid);					// like + 1
		wDao.insertCommendHistory(uid, wid);	// record
		return 1;
	}
	
	public List<Map<String, Object>> getWriterArticleBriefList(Map<String, Object> map) {
		return wDao.getWriterArticleBriefList(map);
	}
	
}
