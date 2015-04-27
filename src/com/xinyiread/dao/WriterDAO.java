package com.xinyiread.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

@Repository
@Transactional
public interface WriterDAO {
	
	public long insert(Writer writer);
	
	public Writer getWriterByUser(User user);

	public Writer getWriterByPenName(String penName);
	
}
