package com.xinyiread.service;

import java.util.List;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

public interface WriterService {
	
	public long addWriter(Writer writer);
	
	public List<Writer> getWriterList();
	
	public Writer getWriterByUser(User user);
	
	public Writer getWriterByPenName(String penName);

}
