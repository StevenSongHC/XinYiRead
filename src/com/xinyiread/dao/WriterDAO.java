package com.xinyiread.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.User;
import com.xinyiread.model.Writer;

@Repository
@Transactional
public interface WriterDAO {
	
	public long insert(Writer writer);
	
	public List<Writer> getWriterList();
	
	public Writer getWriterByUser(User user);

	public Writer getWriterByPenName(String penName);
	
}
