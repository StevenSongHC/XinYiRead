package com.xinyiread.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.xinyiread.model.User;

@Repository
@Transactional
public interface UserDAO {
	
	public long insert(User user);
	
	public long update(User user);
	
	public List<User> getUserList();
	
	public User getUserByName(String username);
	
	public User getUserByEmail(String email);
	
	public List<Object> getUserAdministrativeCategoryById(long id);

}
