package com.xinyiread.service;

import java.util.List;

import com.xinyiread.model.User;

public interface UserService {

	public long addUser(User user);
	
	public List<User> getUserList();
	
}
