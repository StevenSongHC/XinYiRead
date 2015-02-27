package com.xinyiread.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.User;

@Repository
@Transactional
public interface UserDAO {
	
	public long insert(User user);
	
	public List<User> getUserList();

}
