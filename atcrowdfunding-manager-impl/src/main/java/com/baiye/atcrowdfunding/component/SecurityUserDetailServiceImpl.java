package com.baiye.atcrowdfunding.component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.alibaba.druid.util.StringUtils;
import com.baiye.atcrowdfunding.bean.TAdmin;
import com.baiye.atcrowdfunding.bean.TAdminExample;
import com.baiye.atcrowdfunding.bean.TPermission;
import com.baiye.atcrowdfunding.bean.TRole;
import com.baiye.atcrowdfunding.mapper.TAdminMapper;
import com.baiye.atcrowdfunding.mapper.TPermissionMapper;
import com.baiye.atcrowdfunding.mapper.TRoleMapper;
@Component
public class SecurityUserDetailServiceImpl implements UserDetailsService {
	@Autowired
	TAdminMapper adminMapper;
	@Autowired
	TPermissionMapper permissionMapper;
	@Autowired
	TRoleMapper roleMapper;
	
	Logger log = LoggerFactory.getLogger(SecurityUserDetailServiceImpl.class);

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		//1.查询用户对象
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> list = adminMapper.selectByExample(example);
		if(!list.isEmpty() && list.size()==1) {
			TAdmin admin = list.get(0);
			log.debug("查到的用户信息:{}",admin.getUsername());
			//2.查询角色集合
			List<TRole> roleList = roleMapper.listRoleByAdminId(admin.getId());
			
			//3.查询用户所对应的所有权限的集合
			List<TPermission> permissionList = permissionMapper.listPermissionByAdminId(admin.getId());
			Set<GrantedAuthority> authorities = new HashSet<>();
			//4.将所有的角色添加到权限列表
			for (TRole role : roleList) {
				if(!StringUtils.isEmpty(role.getName())) {
					log.debug("把角色:{}添加到权限列表",role.getName());
					authorities.add(new SimpleGrantedAuthority("ROLE_"+role.getName()));
				}
			}
			//5.将所有的权限集合添加到权限列表
			for (TPermission permission : permissionList) {
				if(!StringUtils.isEmpty(permission.getName())) {
					log.debug("把权限:{}添加到权限列表",permission.getName());
					authorities.add(new SimpleGrantedAuthority(permission.getName()));
				}
			}
			log.debug("SpringSecurity  {} 用户信息收集完成",admin.getLoginacct());
//			return new User(tAdmin.getLoginacct(), tAdmin.getUserpswd(), authorities);
			return new TSecurityAdmin(admin, authorities);
			
		}else {
			return null;
		}
		
		
		
	}

}
