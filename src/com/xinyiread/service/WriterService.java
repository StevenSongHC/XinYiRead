package com.xinyiread.service;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

public interface WriterService {
	
	public long addWriter(Writer writer);
	
	public Writer getWriterByUser(User user);
	
	public Writer getWriterByPenName(String penName);

}
