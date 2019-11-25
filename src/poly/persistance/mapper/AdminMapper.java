package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.UserDTO;

@Mapper("AdminMapper")
public interface AdminMapper {

	int UserCount()throws Exception;
	
	List<UserDTO> getUserList(HashMap<String, Integer> hMap)throws Exception;

	int Modass(UserDTO uDTO)throws Exception;


	

}
