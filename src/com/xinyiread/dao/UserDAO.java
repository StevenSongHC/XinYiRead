package com.xinyiread.dao;

import java.util.List;
import java.util.Map;

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
	
	public List<Map<String, Object>> getAllUserRoleList();
	
	public List<Object> getUserRoleListById(long id);
	
	public List<Object> getUserPrivilegeListById(long id);
	
	public List<Map<String, Object>> getAllRolePrivilegeList();
	
	public List<Map<String, Object>> getRoleList();
	
	public List<Map<String, Object>> getPrivilegeList();

}
