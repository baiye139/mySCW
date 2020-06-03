package com.baiye.atcrowdfunding.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baiye.atcrowdfunding.bean.TMenu;
import com.baiye.atcrowdfunding.service.TMenuService;
import com.baiye.atcrowdfunding.util.Datas;

@Controller
public class TMenuCintroller {
	Logger log = LoggerFactory.getLogger(TMenuCintroller.class);
	@Autowired
	TMenuService menuService;
	@RequestMapping("/menu/index")
	public String index() {
		return "menu/index";
	}
	@ResponseBody
	@RequestMapping("/menu/listPermissionIdByMenuId")
	public List<Integer> listPermissionIdByMenuId(Integer menuId) {
		
		
		
		return menuService.listPermissionIdByMenuId(menuId);
	}
	@ResponseBody
	@RequestMapping("/menu/savePermissionandMenuRelationship")
	public String savePermissionandMenuRelationship(Integer menuId, Datas ids) {
		log.debug("menuId:{}",menuId);
		log.debug("menuId:{}",ids.getIds());
		menuService.savePermissionandMenuRelationship(menuId,ids.getIds());
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/menu/loadTree")
	public List<TMenu> loadTree() {
		return menuService.listTMenuAllTree();
	}
	@ResponseBody
	@RequestMapping("/menu/doAdd")
	public String doAdd(TMenu tMenu) {
		menuService.saveTmenu(tMenu);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/menu/updateTMenu")
	public String updateTMenu(TMenu tMenu) {
		menuService.updateTMenu(tMenu);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/menu/deleteTMenuById")
	public String deleteTMenuById(Integer id) {
		menuService.deleteTMenuById(id);
		return "ok";
	}
	@ResponseBody
	@RequestMapping("/menu/getTMenuById")
	public TMenu getTMenuById(Integer id) {
		return menuService.getTMenuById(id);
	}
}
