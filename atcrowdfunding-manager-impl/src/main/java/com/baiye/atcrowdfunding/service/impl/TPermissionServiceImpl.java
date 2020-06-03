package com.baiye.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baiye.atcrowdfunding.bean.TPermission;
import com.baiye.atcrowdfunding.mapper.TPermissionMapper;
import com.baiye.atcrowdfunding.service.TPermissionService;
@Service
public class TPermissionServiceImpl implements TPermissionService{
	@Autowired
	TPermissionMapper permissionMapper;
	@Override
	public List<TPermission> listTPermission() {
		// TODO Auto-generated method stub
		return permissionMapper.selectByExample(null);
	}
	@Override
	public void savePermission(TPermission tPermission) {
		permissionMapper.insertSelective(tPermission);
		
	}
	@Override
	public TPermission getTPermissionById(Integer id) {
		// TODO Auto-generated method stub
		return permissionMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateTPermission(TPermission tPermission) {
		// TODO Auto-generated method stub
		permissionMapper.updateByPrimaryKeySelective(tPermission);
	}
	@Override
	public void deleteTPermissionById(Integer id) {
		// TODO Auto-generated method stub
		permissionMapper.deleteByPrimaryKey(id);
	}

}
