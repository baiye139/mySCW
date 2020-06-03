package com.baiye.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baiye.atcrowdfunding.bean.TMenu;
import com.baiye.atcrowdfunding.bean.TPermissionMenu;
import com.baiye.atcrowdfunding.bean.TPermissionMenuExample;
import com.baiye.atcrowdfunding.mapper.TMenuMapper;
import com.baiye.atcrowdfunding.mapper.TPermissionMenuMapper;
import com.baiye.atcrowdfunding.service.TMenuService;
@Service
public class TMenuServiceImpl implements TMenuService{
	Logger log = LoggerFactory.getLogger(TMenuServiceImpl.class);
	@Autowired
	TMenuMapper menuMapper;
	@Autowired
	TPermissionMenuMapper permissionMenuMapper;
	@Override
	public List<TMenu> listMenuAll() {
		List<TMenu> menuList = new ArrayList<TMenu>();
		Map<Integer,TMenu> cahe = new HashMap<Integer,TMenu>();
		List<TMenu> allList = menuMapper.selectByExample(null);
		
		for (TMenu tMenu : allList) {
			if(tMenu.getPid()==0) {
				menuList.add(tMenu);
				cahe.put(tMenu.getId(), tMenu);
			}
		}
		for (TMenu tMenu : allList) {
			if(tMenu.getPid()!=0) {
				Integer pid = tMenu.getPid();
				TMenu parent = cahe.get(pid);
				parent.getChildren().add(tMenu);
			}
		}
		log.debug("菜单={}",menuList);
		return menuList;
	}
	@Override
	public List<TMenu> listTMenuAllTree() {
		
		return  menuMapper.selectByExample(null);
	}
	@Override
	public void saveTmenu(TMenu tMenu) {
		menuMapper.insertSelective(tMenu);
		
	}
	@Override
	public TMenu getTMenuById(Integer id) {
		// TODO Auto-generated method stub
		return menuMapper.selectByPrimaryKey(id);
	}
	@Override
	public void updateTMenu(TMenu tMenu) {
		menuMapper.updateByPrimaryKeySelective(tMenu);
		
	}
	@Override
	public void deleteTMenuById(Integer id) {
		// TODO Auto-generated method stub
		menuMapper.deleteByPrimaryKey(id);
	}
	@Override
	public List<Integer> listPermissionIdByMenuId(Integer menuId) {
		
		// TODO Auto-generated method stub
		return permissionMenuMapper.listPermissionIdByMenuId(menuId);
	}
	@Override
	public void savePermissionandMenuRelationship(Integer menuId, List<Integer> ids) {
		//删除原有数据
		TPermissionMenuExample example = new TPermissionMenuExample();
		example.createCriteria().andMenuidEqualTo(menuId);
		permissionMenuMapper.deleteByExample(example);
		//保存数据
		if(!ids.isEmpty()) {
			permissionMenuMapper.savePermissionandMenuRelationship(menuId,ids);
		}
		
	}

}
