package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserMapper;
import com.memo.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserMapper userMapper;
	
	
	// input : id
	// output : model그자체로
	public User getUserLoginId(String loginId) {
		return userMapper.selectUserLoginId(loginId);
	}
	
	// input : loginId, password, name, email
	// output :  int ★
	public int addUser(String loginId, String password, String name, String email, String profileImagePath) {
		return userMapper.insertUser(loginId, password, name, email, profileImagePath);
	}
	
	// input : loginId, password
	// output : User
	public User getUserByLoginIdPassword(String loginId, String password) {
		return userMapper.selectUserByLoginIdPassword(loginId, password);
	}
}
