package com.xinyiread.service;

import com.xinyiread.model.Writer;

public interface WriterService {
	
	public long addWriter(Writer writer);
	
	public Writer getWriterByPenName(String penName);

}
