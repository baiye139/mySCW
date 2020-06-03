package com.baiye.atcrowdfunding.service;

import java.util.List;
import java.util.Map;

import com.baiye.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface TRoleService {

	PageInfo<TRole> listRole(Map<String, Object> paramMap);

	void saveTRole(TRole tRole);

	void updateTRole(TRole tRole);

	void deleteTRole(Integer id);

	void deleteBatch(String ids);

	List<TRole> listAllRole();

	List<Integer> getRoleIdByAdminId(Integer id);

	void saveTAdimnAndRoleRelationship(Integer[] roleId, Integer adminId);

	void deleteTAdimnAndRoleRelationship(Integer[] roleId, Integer adminId);

	void saveRoleAndPermissionRelationship(Integer roleId, List<Integer> ids);


	List<Integer> listPermissionIdByRoleId(Integer roleId);

}
