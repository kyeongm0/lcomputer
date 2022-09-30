package com.lcomputer.example.service;

import java.util.Collection;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import com.lcomputer.example.domain.User;

public interface UserService extends UserDetailsService {
	public User readUser(String username);
	
	public void createUser(User user);
	
	public void createAuthorities(User user);
	
	Collection<GrantedAuthority> getAuthorities(String username);
	
	public List<User> userList(User user);
	
	public User userDetail(User user);
	
	public User userEdit(User user);
	
	public void userEditProcess(User user);
	
	public void userDelete(User user);
	
	public int userCount();
	
	public void userLevel(User user);
	
	public User userInfo(User user);
}
