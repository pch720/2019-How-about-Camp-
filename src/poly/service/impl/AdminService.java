package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.UserDTO;
import poly.persistance.mapper.AdminMapper;
import poly.service.IAdminService;

@Service("AdminService")
public class AdminService implements IAdminService {
	
	
	@Resource(name="AdminMapper")
	private AdminMapper adminMapper;

	@Override
	public int UserCount() throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.UserCount();
	}

	@Override
	public List<UserDTO> getUserList(HashMap<String, Integer> hMap) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.getUserList(hMap);
	}

	@Override
	public int Modass(UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return adminMapper.Modass(uDTO);
	}

}
