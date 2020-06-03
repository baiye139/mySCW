package com.baiye.atcrowdfunding.service;

import java.util.List;

import com.baiye.atcrowdfunding.bean.TMenu;

public interface TMenuService {
	
	List<TMenu> listMenuAll();//查询菜单并父把子类包装在父类中

	List<TMenu> listTMenuAllTree();//直接查询所有菜单

	void saveTmenu(TMenu tMenu);

	TMenu getTMenuById(Integer id);

	void updateTMenu(TMenu tMenu);

	void deleteTMenuById(Integer id);

	List<Integer> listPermissionIdByMenuId(Integer menuId);

	void savePermissionandMenuRelationship(Integer menuId, List<Integer> ids);

	
}
