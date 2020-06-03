package com.baiye.atcrowdfunding.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.baiye.atcrowdfunding.component.SecurityUserDetailServiceImpl;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled=true)
public class AtcrowdFundingSecurityConfig extends WebSecurityConfigurerAdapter{
	@Autowired
	SecurityUserDetailServiceImpl securityUserDetailServiceImpl;
	@Override
	protected void configure(HttpSecurity http) throws Exception {
//		// TODO Auto-generated method stub
//		super.configure(http);
		http.authorizeRequests().antMatchers("/static/**","/welcome.jsp","/toLogin").permitAll()
		.anyRequest().authenticated();//剩下都需要认证
		// /login.jsp==POST  用户登陆请求发给Security
		http.formLogin().loginPage("/toLogin")//去登录页面请求对应的url
		.usernameParameter("loginacct")
		.passwordParameter("userpswd")
		.loginProcessingUrl("/login")//去登录页面
		.defaultSuccessUrl("/main")//登录成功页面
		.permitAll();
		http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {//异常时输出什么
		
			
		/**
		 * 权限不足时的处理页面
		 */
			@Override
		public void handle(HttpServletRequest request, HttpServletResponse response,
				AccessDeniedException accessDeniedException) throws IOException, ServletException {
			// TODO Auto-generated method stub
			// X-Requested-With: XMLHttpRequest 异步请求的header带的
			//处理异步请求
			String type = request.getHeader("X-Requested-With");
			if("XMLHttpRequest".equals(type)) {
				
			response.getWriter().print(403);//403 权限不够,访问被拒
			}else {
			
			//处理同步请求
			response.sendRedirect(request.getContextPath()+"/WEB-INF/error/error403.jsp");
			}
		}
			
			
		});
		http.csrf().disable();//不使用防跨站
		http.rememberMe();//记住我
		http.logout()//注销
		.logoutSuccessUrl("/welcome.jsp");
	}
	//控制用户的密码和权限
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		// TODO Auto-generated method stub
//		super.configure(auth);
		auth.userDetailsService(securityUserDetailServiceImpl).passwordEncoder(new BCryptPasswordEncoder());
	}

}
