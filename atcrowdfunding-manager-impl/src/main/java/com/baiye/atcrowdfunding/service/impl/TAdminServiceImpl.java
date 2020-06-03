package com.baiye.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baiye.atcrowdfunding.bean.TAdmin;
import com.baiye.atcrowdfunding.bean.TAdminExample;
import com.baiye.atcrowdfunding.bean.TAdminExample.Criteria;
import com.baiye.atcrowdfunding.exception.LoginException;
import com.baiye.atcrowdfunding.mapper.TAdminMapper;
import com.baiye.atcrowdfunding.service.TAdminService;
import com.baiye.atcrowdfunding.util.AppDateUtils;
import com.baiye.atcrowdfunding.util.Const;
import com.baiye.atcrowdfunding.util.Datas;
import com.baiye.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;
import com.mysql.fabric.xmlrpc.base.Data;
@Service
public class TAdminServiceImpl implements TAdminService{
	@Autowired
	TAdminMapper tAdminMapper;

	@Override
	public TAdmin getTAdminByLogin(Map<String, Object> paramMap) {
		//1密码加密
		//2用户查询
		String loginacct =paramMap.get("loginacct").toString();
		String userpswd =paramMap.get("userpswd").toString();
		
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(loginacct);
		List<TAdmin> list = tAdminMapper.selectByExample(example);
		//3判断用户是否为空
		if(list==null || list.size()==0) {
		throw new LoginException(Const.LOGIN_USERPSWD_ERROR);	
		}
		TAdmin admin = list.get(0);
		//4判断密码
		if(!admin.getUserpswd().equals(MD5Util.digest(userpswd))) {
			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);	
		}
		//5验证成功
		return admin;
	}

	@Override
	public PageInfo<TAdmin> listAdminPage(Map<String, Object> pageMap) {
		Object condition = pageMap.get("condition");
		TAdminExample example = new TAdminExample();
		if(!"".equals(condition)) {
			//账号
			example.createCriteria().andLoginacctLike("%"+condition+"%");
			Criteria criteria1 = example.createCriteria();
			//姓名
			criteria1.andUsernameLike("%"+condition+"%");
			example.or(criteria1);
			Criteria criteria2 = example.createCriteria();
			//邮箱
			criteria2.andEmailLike("%"+condition+"%");
			example.or(criteria2);
			
		}
		List<TAdmin> list = tAdminMapper.selectByExample(example);
		PageInfo<TAdmin> page = new PageInfo<TAdmin>(list,5);
		return page;
	}

	@Override
	public void saveAdmin(TAdmin admin) {
		//设置密码
		admin.setUserpswd(MD5Util.digest(Const.DEFAULT_USERPSWD));
		//时间
		admin.setCreatetime(AppDateUtils.getFormatTime());
		
		tAdminMapper.insertSelective(admin);
	}

	@Override
	public TAdmin getAdminById(Integer id) {
		TAdmin admin = tAdminMapper.selectByPrimaryKey(id);
		return admin;
	}

	@Override
	public void updateAdmin(TAdmin admin) {
		tAdminMapper.updateByPrimaryKeySelective(admin);
	}

	@Override
	public void removeAdmin(Integer id) {
		tAdminMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void deleteBatch(String ids) {
		tAdminMapper.deleteBatch(ids);
		
	}
	
}
