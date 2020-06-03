package com.baiye.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.baiye.atcrowdfunding.bean.TAdmin;
import com.baiye.atcrowdfunding.bean.TMenu;
import com.baiye.atcrowdfunding.service.TAdminService;
import com.baiye.atcrowdfunding.service.TMenuService;
import com.baiye.atcrowdfunding.util.Const;

@Controller
public class DispatcherController {
	
	Logger log = LoggerFactory.getLogger(DispatcherController.class);
	@Autowired
	TAdminService adminService;
	@Autowired
	TMenuService menuService;
	@RequestMapping("/index")
	public String index() {
		log.debug("跳转到系统主页面...");
		
		return "index";
	}
	@RequestMapping("/toLogin")
	public String login() {
		log.debug("跳转到登录页面...");
		
		return "login";
	}
	
	@RequestMapping("/main")
	public String main(HttpSession session) {
		if(session==null) {
			return "redirect:/toLogin";
		}
		log.debug("跳转到系统main页面...");
		if(session.getAttribute("menuList")==null) {
			List<TMenu> menuList = menuService.listMenuAll();
			session.setAttribute("menuList", menuList);
			
		}
		
		return "main";
	}
	
//	@RequestMapping("/doLogin")
//	public String doLogin(String loginacct, String userpswd, HttpSession session, Model model) {
//		log.debug("正在登录账号:{} ",loginacct);
//		Map<String, Object> paramMap = new HashMap<>();
//		paramMap.put("loginacct", loginacct);
//		paramMap.put("userpswd", userpswd);
//		
//		try {
//			TAdmin loginAdmin = adminService.getTAdminByLogin(paramMap);
//			session.setAttribute(Const.LOGIN_ADMIN, loginAdmin);
//			return "redirect:main";
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			log.debug("登录失败:{}",e.getMessage());
//			model.addAttribute("message", e.getMessage());
//			return "login";
//		}
//		
//	}
//	@RequestMapping("/indexl")
//	public String indexl(HttpSession session) {
//		log.debug("系统注销...");
//		if(session != null) {
//			session.removeAttribute(Const.LOGIN_ADMIN);
//			//销毁
//			session.invalidate();
//		}
//		
//		return "redirect:index";
//	}
	
	
}
