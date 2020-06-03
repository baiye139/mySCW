package com.baiye.atcrowdfunding.service;

import java.util.List;

import com.baiye.atcrowdfunding.bean.TPermission;

public interface TPermissionService {

	List<TPermission> listTPermission();

	void savePermission(TPermission tPermission);

	TPermission getTPermissionById(Integer id);

	void updateTPermission(TPermission tPermission);

	void deleteTPermissionById(Integer id);

}
