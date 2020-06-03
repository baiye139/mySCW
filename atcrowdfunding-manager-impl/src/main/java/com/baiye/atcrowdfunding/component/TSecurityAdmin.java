package com.baiye.atcrowdfunding.component;

import java.util.Collection;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

import com.baiye.atcrowdfunding.bean.TAdmin;
public class TSecurityAdmin extends User {
	
	TAdmin admin;
	public TSecurityAdmin(TAdmin admin,Set<GrantedAuthority> authorities) {
		super(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, authorities);
		this.admin=admin;
	}

}
