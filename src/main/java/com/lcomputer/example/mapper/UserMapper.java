package com.lcomputer.example.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;
import com.lcomputer.example.domain.User;

@Mapper
public interface UserMapper {
	public User readUser(String username);
	
	public void createUser(User user);
	
	public List<GrantedAuthority> readAuthorities(String username);
	
	public void createAuthority(User user);
	
	public List<User> userList(User user);
	
	public User userDetail(User user);
	
	public User userEdit(User user);
	
	public void userEditProcess(User user);
	
	public void userDelete(User user);
	
	public int userCount();
	
	public void userLevel(User user);
	
	public void authorLevel(User user);
	
	public User userInfo(User user);
}
