package com.baiye.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.baiye.atcrowdfunding.bean.TRole;
import com.baiye.atcrowdfunding.bean.TRoleExample;
import com.baiye.atcrowdfunding.bean.TRoleExample.Criteria;
import com.baiye.atcrowdfunding.bean.TRolePermissionExample;
import com.baiye.atcrowdfunding.mapper.TAdminRoleMapper;
import com.baiye.atcrowdfunding.mapper.TRoleMapper;
import com.baiye.atcrowdfunding.mapper.TRolePermissionMapper;
import com.baiye.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageInfo;
@Service
public class TRoleServiceImpl implements TRoleService {
	@Autowired
	TRoleMapper roleMapper;
	@Autowired
	TAdminRoleMapper adminRoleMapper;
	@Autowired
	TRolePermissionMapper tRolePermissionMapper;
	@Override
	public PageInfo<TRole> listRole(Map<String, Object> paramMap) {
		String condition =(String)paramMap.get("condition");
		TRoleExample example = new TRoleExample(); 
		List<TRole> list = null;
		if(!StringUtils.isEmpty(condition)) {
			example.createCriteria().andNameLike("%"+condition+"%");
		}
		example.setOrderByClause("id DESC");
		list = roleMapper.selectByExample(example);
		
		PageInfo<TRole> page = new PageInfo<>(list,5);
		return page;
	}
//	@PreAuthorize("hasRole('PM - 项目经理')")
	@Override
	public void saveTRole(TRole tRole) {
		
		roleMapper.insertSelective(tRole);
	}
	@Override
	public void updateTRole(TRole tRole) {
		roleMapper.updateByPrimaryKey(tRole);
	}
	@Override
	public void deleteTRole(Integer id) {
		roleMapper.deleteByPrimaryKey(id);
		
	}
	@Override
	public void deleteBatch(String ids) {
		roleMapper.deleteBatch(ids);
		
	}
	@Override
	public List<TRole> listAllRole() {
		// TODO Auto-generated method stub
		return roleMapper.selectByExample(null);
	}
	@Override
	public List<Integer> getRoleIdByAdminId(Integer id) {
		// TODO Auto-generated method stub
		return adminRoleMapper.getRoleIdByAdminId(id);
	}
	@Override
	public void saveTAdimnAndRoleRelationship(Integer[] roleId, Integer adminId) {
		adminRoleMapper.saveTAdimnAndRoleRelationship(roleId, adminId);
		
	}
	@Override
	public void deleteTAdimnAndRoleRelationship(Integer[] roleId, Integer adminId) {
		adminRoleMapper.deleteTAdimnAndRoleRelationship(roleId, adminId);
		
	}
	@Override
	public void saveRoleAndPermissionRelationship(Integer roleId, List<Integer> ids) {
		//1.先删除原有数据
		TRolePermissionExample example = new TRolePermissionExample();
		example.createCriteria().andRoleidEqualTo(roleId);
		tRolePermissionMapper.deleteByExample(example);
		//2.再保存数据
		if(!ids.isEmpty()) {
			
			tRolePermissionMapper.saveRoleAndPermissionRelationship(roleId,ids);
		}
		
	}
	@Override
	public List<Integer> listPermissionIdByRoleId(Integer roleId) {
		// TODO Auto-generated method stub
		return tRolePermissionMapper.listPermissionIdByRoleId(roleId);
	}

}
