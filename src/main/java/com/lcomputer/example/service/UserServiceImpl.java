package com.lcomputer.example.service;

import java.util.Collection;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.lcomputer.example.domain.User;
import com.lcomputer.example.mapper.UserMapper;

@Service
public class UserServiceImpl  implements UserService {
	@Autowired
	UserMapper usermapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user= usermapper.readUser(username);
		user.setAuthorities(getAuthorities(username));
		
		return user;
	}
	
	@Override
	public Collection<GrantedAuthority> getAuthorities(String username) {
		List<GrantedAuthority> authorities= usermapper.readAuthorities(username);
		return authorities;
	}
	
	@Override
	public void createUser(User user) {
		usermapper.createUser(user);
	}
	
	@Override
	public void createAuthorities(User user) {
		usermapper.createAuthority(user);
	}
	
	@Override
	public User readUser(String username) {
		return usermapper.readUser(username);
	}
	
	@Override
	public List<User> userList(User user) {
		return usermapper.userList(user);
	}
	
	@Override
	public User userDetail(User user) {
		return usermapper.userDetail(user);
	}
	
	@Override
	public User userEdit(User user) {
		return usermapper.userEdit(user);
	}
	
	@Override
	public void userEditProcess(User user) {
		usermapper.userEditProcess(user);
	}
	
	@Override
	public void userDelete(User user) {
		usermapper.userDelete(user);
	}
	
	@Override
	public int userCount() {
		return usermapper.userCount();
	}
	
	@Override
	public void userLevel(User user) {
		usermapper.authorLevel(user);
		usermapper.userLevel(user);
	}
	
	@Override
	public User userInfo(User user) {
		return usermapper.userInfo(user);
	}
}
