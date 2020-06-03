package com.baiye.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baiye.atcrowdfunding.bean.TPermission;
import com.baiye.atcrowdfunding.service.TPermissionService;

@Controller
public class TPermissionController {
	@Autowired
	TPermissionService permissionService;
	
	@RequestMapping("/permission/index")
	public String index() {
		
		return "permission/index";
	}
	@ResponseBody
	@RequestMapping("/permission/loadTree")
	public List<TPermission> loadTree() {
		
		return permissionService.listTPermission();
	}
	@ResponseBody
	@RequestMapping("/permission/doAdd")
	public String doAdd(TPermission tPermission) {
		permissionService.savePermission(tPermission);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/permission/updateTPermission")
	public String updateTPermission(TPermission tPermission) {
		permissionService.updateTPermission(tPermission);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/permission/deleteTPermissionById")
	public String deleteTPermissionById(Integer id) {
		permissionService.deleteTPermissionById(id);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/permission/getTPermissionById")
	public TPermission getTPermissionById(Integer id) {
		
		return permissionService.getTPermissionById(id);
	}
}
