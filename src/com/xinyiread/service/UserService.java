package com.xinyiread.service;

import java.util.List;

import com.xinyiread.model.User;

public interface UserService {

	public long addUser(User user);
	
	public int updateUser(User user);
	
	public List<User> getUserList();
	
	public User getUserByName(String username);
	
	public User getUserByEmail(String email);
	
	public List<Object> getUserAdministrativeCategoryById(long id);
	
}
