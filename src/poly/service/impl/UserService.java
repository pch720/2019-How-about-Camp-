package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.UserMapper;
import poly.service.IUserService;
@Service("UserService")
public class UserService implements IUserService {
	
	@Resource(name="UserMapper")
	private UserMapper userMapper;

	@Override
	public int userRegProc(UserDTO uDTO) throws Exception{
		return userMapper.userRegProc(uDTO);
	}

	@Override
	public String eCheck(String email) throws Exception {
		return userMapper.eCheck(email);
	}

	@Override
	public String pCheck(String phone) throws Exception {
		System.out.println("service phone : " + phone);
		return userMapper.pCheck(phone);
	}

	@Override
	public UserDTO getUserInfo(UserDTO uDTO) throws Exception {
		return userMapper.getUserInfo(uDTO);
	}

	@Override
	public int userDelete(UserDTO uDTO) throws Exception {
		return userMapper.userDelete(uDTO);
	}

	@Override
	public String email1(UserDTO uDTO) throws Exception {
		return userMapper.email1(uDTO);
	}

	@Override
	public String email2(UserDTO uDTO) throws Exception {
		return userMapper.email2(uDTO);
	}

	@Override
	public int changeP(UserDTO uDTO) throws Exception {
		return userMapper.changeP(uDTO);
	}

	@Override
	public String pw(String userEmail) throws Exception {
		return userMapper.pw(userEmail);
	}

	@Override
	public int userMod(UserDTO uDTO) throws Exception {
		return userMapper.userMod(uDTO);
	}


	
}
