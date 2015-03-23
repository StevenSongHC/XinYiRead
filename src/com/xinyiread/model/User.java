package com.xinyiread.model;

import java.sql.Date;

public class User {
	
	private long id;
	private String name;
	private String password;
	private String email;
	private int isEmailShow;
	private Date joinDate;
	private Date lastLoginDate;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIsEmailShow() {
		return isEmailShow;
	}
	public void setIsEmailShow(int isEmailShow) {
		this.isEmailShow = isEmailShow;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	
}
