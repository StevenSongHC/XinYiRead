package com.xinyiread.service.impl;

import java.util.List;

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
	
	public List<Writer> getWriterList() {
		return wDao.getWriterList();
	}

	public Writer getWriterByUser(User user) {
		return wDao.getWriterByUser(user);
	}
	
	public Writer getWriterByPenName(String penName) {
		return wDao.getWriterByPenName(penName);
	}

}
