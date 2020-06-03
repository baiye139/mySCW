package com.baiye.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baiye.atcrowdfunding.bean.TRole;
import com.baiye.atcrowdfunding.service.TRoleService;
import com.baiye.atcrowdfunding.util.Datas;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TRoleController {
	Logger log = LoggerFactory.getLogger(TRoleController.class);
	@Autowired
	TRoleService roleService;
	@RequestMapping("/role/index")
	public String index() {
		
		
		return "role/index";
	}
	@ResponseBody
	@RequestMapping("/role/listPermissionIdByRoleId")
	public List<Integer> listPermissionIdByRoleId(Integer roleId) {//这个Datas对象名字不能为ids
		
		log.debug("roleId={}",roleId);
		
		return roleService.listPermissionIdByRoleId(roleId);
	}
	@ResponseBody
	@RequestMapping("/role/toAssignPermissionToRole")
	public String toAssignPermissionToRole(Integer roleId,Datas ds) {//这个Datas对象名字不能为ids
		
		log.debug("roleId:{}",roleId);
		log.debug("permissionIds:{}",ds.getIds());
		roleService.saveRoleAndPermissionRelationship(roleId,ds.getIds());
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/role/deleteBatch")
	public String deleteBatch(String ids) {
		
		roleService.deleteBatch(ids);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/role/deleteRole")
	public String deleteRole(Integer id) {
		
		roleService.deleteTRole(id);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/role/updateRole")
	public String updateRole(TRole tRole) {
		
		roleService.updateTRole(tRole);
		return "ok";
	}
	@PreAuthorize("hasRole('PM - 项目经理')")//管理不到一个在spring一个在springmvc
	@ResponseBody
	@RequestMapping("/role/addRole")
	public String addRole(TRole tRole) {
		
		roleService.saveTRole(tRole);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/role/loadData")
	public PageInfo<TRole> loadData(
			@RequestParam(value="pageNum",required=false,defaultValue="1")Integer pageNum,
			@RequestParam(value="pageSize",required=false,defaultValue="2")Integer pageSize,
			@RequestParam(value="condition",required=false,defaultValue="") String condition) {
		PageHelper.startPage(pageNum, pageSize);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("condition", condition);
		PageInfo<TRole> page = roleService.listRole(paramMap);
		
		return page;
	}
}
