package poly.service;

import poly.dto.UserDTO;

public interface IUserService {

	int userRegProc(UserDTO uDTO)throws Exception;

	String eCheck(String email)throws Exception;

	String pCheck(String phone)throws Exception;

	UserDTO getUserInfo(UserDTO uDTO)throws Exception;

	int userDelete(UserDTO uDTO)throws Exception;

	String email1(UserDTO uDTO)throws Exception;

	String email2(UserDTO uDTO)throws Exception;

	int changeP(UserDTO uDTO)throws Exception;

	String pw(String userEmail)throws Exception;

	int userMod(UserDTO uDTO)throws Exception;

	

}
