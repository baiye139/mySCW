package com.baiye.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baiye.atcrowdfunding.bean.TAdmin;
import com.baiye.atcrowdfunding.bean.TRole;
import com.baiye.atcrowdfunding.service.TAdminService;
import com.baiye.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TAdminController {
	
	Logger log = LoggerFactory.getLogger(TAdminController.class);
	
	@Autowired
	TAdminService adminService;
	
	@Autowired
	TRoleService roleService;
	//解除角色和管理者关系
	@ResponseBody
	@RequestMapping("/admin/doUnassign")
	public String doUnassign(Integer[] roleId, Integer adminId) {
		log.debug("doUnassign::adminId:{}", adminId);
		for (Integer rId : roleId) {
			log.debug("doUnassign::rId:{}", rId);
		}
		roleService.deleteTAdimnAndRoleRelationship(roleId, adminId);
		return "ok";
	}
	//建立角色和管理者关系
	@ResponseBody
	@RequestMapping("/admin/doAssign")
	public String doAssign(Integer[] roleId, Integer adminId) {
		log.debug("doAssign::adminId:{}", adminId);
		for (Integer rId : roleId) {
			log.debug("doAssign::rId:{}", rId);
		}
		roleService.saveTAdimnAndRoleRelationship(roleId, adminId);
		return "ok";
	}
	
	@RequestMapping("/admin/toAssign")
	public String toAssign(Integer id, Model model) {
		//1.先查询所有角色名称
		List<TRole> allList = roleService.listAllRole();
		//2.根据用户id查询所绑定的角色id
		List<Integer> roleIdList = roleService.getRoleIdByAdminId(id);
		//3.所有角色进行划分
		List<TRole> assignList = new ArrayList<TRole>();
		List<TRole> unassignList = new ArrayList<TRole>();
		model.addAttribute("assignList", assignList);
		model.addAttribute("unassignList", unassignList);
		//找出已经分配的
		for (TRole tRole : allList) {
			if(roleIdList.contains(tRole.getId())) {
				log.debug("assignList:{}",tRole.getName());
				assignList.add(tRole);
			}else {
				log.debug("unassignList:{}",tRole.getName());
				unassignList.add(tRole);
			}
		}
		//未分配的
		
		return "admin/assignRole";
	}
	//实现分页
	@RequestMapping("/admin/index")
	public String index(@RequestParam(value="pageNum",required=false,defaultValue="1") Integer pageNum,
			@RequestParam(value="PageSize",required=false,defaultValue="2") Integer pageSize,
			Model model,
			@RequestParam(value="condition",required=false,defaultValue="") String condition) {
		
		log.debug("转发到用户维护界面");
		PageHelper.startPage(pageNum, pageSize);//线程绑定
		Map<String,Object> pageMap = new HashMap<String,Object>();
		pageMap.put("condition", condition);
		PageInfo<TAdmin> page = adminService.listAdminPage(pageMap);
		model.addAttribute("page", page);
		return "admin/index";
	}
	@PreAuthorize("hasRole('PM - 项目经理')")
	@RequestMapping("/admin/doAdd")
	public String toAdd(TAdmin admin) {
		
		adminService.saveAdmin(admin);
		
		return "redirect:/admin/index?pageNum=" + Integer.MAX_VALUE;
	}
	@RequestMapping("/admin/add")
	public String add(){
		
		return "admin/add";
	}
	@RequestMapping("/admin/doUpdate")
	public String doUpdate(TAdmin admin,Integer pageNum) {
		
		adminService.updateAdmin(admin);
		
		return "redirect:/admin/index?pageNum=" + pageNum;
	}
	@RequestMapping("/admin/update")
	public String update(Integer id,Integer pageNum,Model model){
		TAdmin admin = adminService.getAdminById(id);
		model.addAttribute("admin", admin);
		return "admin/update";
	}
	@RequestMapping("/admin/doDelete")
	public String doDelete(Integer id,Integer pageNum) {
		
		adminService.removeAdmin(id);
		
		return "redirect:/admin/index?pageNum=" + pageNum;
	}
	@RequestMapping("/admin/doDeleteAll")
	public String doDeleteAll(String ids,Integer pageNum) {
		
		adminService.deleteBatch(ids);
		
		return "redirect:/admin/index?pageNum=" + pageNum;
	}
	
	
}
