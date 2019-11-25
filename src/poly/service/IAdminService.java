package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.UserDTO;

public interface IAdminService {

	int UserCount()throws Exception;

	List<UserDTO> getUserList(HashMap<String, Integer> hMap)throws Exception;

	int Modass(UserDTO uDTO)throws Exception;
}
