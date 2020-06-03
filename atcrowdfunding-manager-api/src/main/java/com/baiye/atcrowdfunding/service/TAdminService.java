package com.baiye.atcrowdfunding.service;

import java.util.Map;

import com.baiye.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

public interface TAdminService {
	
	TAdmin getTAdminByLogin(Map<String, Object> paramMap);
	PageInfo<TAdmin> listAdminPage(Map<String,Object> pageMap);
	void saveAdmin(TAdmin admin);
	TAdmin getAdminById(Integer id);
	void updateAdmin(TAdmin admin);
	void removeAdmin(Integer id);
	void deleteBatch(String ids);
}
