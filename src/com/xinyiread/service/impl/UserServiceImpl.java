package com.xinyiread.service.impl;

import java.util.List;
import java.util.Map;

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
	
	public long updateUser(User user) {
		return uDao.update(user);
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
	
	public List<Map<String, Object>> getAllUserRoleList() {
		return uDao.getAllUserRoleList();
	}

	public List<Object> getUserRoleListById(long id) {
		return uDao.getUserRoleListById(id);
	}
	
	public List<Object> getUserPrivilegeListById(long id) {
		return uDao.getUserPrivilegeListById(id);
	}
	
	public List<Map<String, Object>> getAllRolePrivilegeList() {
		return uDao.getAllRolePrivilegeList();
	}

	public List<Map<String, Object>> getRoleList() {
		return uDao.getRoleList();
	}

	public List<Map<String, Object>> getPrivilegeList() {
		return uDao.getPrivilegeList();
	}

}
