package com.xinyiread.service;

import java.util.List;
import java.util.Map;

import com.xinyiread.model.User;

public interface UserService {

	public long addUser(User user);
	
	public long updateUser(User user);
	
	public List<User> getUserList();
	
	public User getUserByName(String username);
	
	public User getUserByEmail(String email);
	
	public List<Object> getUserAdministrativeCategoryById(long id);
	
	public List<Map<String, Object>> getAllUserRoleList();
	
	public List<Map<String, Object>> getUserRoleListById(long id);
	
	public List<Map<String, Object>> getAllRolePrivilegeList();
	
	public List<Map<String, Object>> getRoleList();
	
	public List<Map<String, Object>> getPrivilegeList();
	
}
