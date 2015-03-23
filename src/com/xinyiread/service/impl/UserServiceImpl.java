package com.xinyiread.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xinyiread.dao.UserDAO;
import com.xinyiread.model.User;
import com.xinyiread.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO uDao;
	
	public long addUser(User user) {
		return uDao.insert(user);
	}

	public List<User> getUserList() {
		return uDao.getUserList();
	}
	
	public User getUserByName(String username) {
		return uDao.getUserByName(username);
	}
	
	public User getUserByEmail(String email) {
		return uDao.getUserByEmail(email);
	}

}
