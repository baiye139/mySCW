package com.baiye.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.baiye.atcrowdfunding.util.Const;

/**
 * Application Lifecycle Listener implementation class SystemUpInitListener
 *
 */
public class SystemUpInitListener implements ServletContextListener{
	Logger log = LoggerFactory.getLogger(SystemUpInitListener.class);
    public SystemUpInitListener() {
        // TODO Auto-generated constructor stub
    }
    //当application被初始化时被执行
    //获取上下文路径以便页面使用
    @Override
    public void contextInitialized(ServletContextEvent sce) {
    	ServletContext application = sce.getServletContext();
    	String contextPath = application.getContextPath();
    	
    	log.debug("当前应用上下文路径:{}",contextPath);
    	application.setAttribute(Const.PATH, contextPath);
    	
    	
    }
  //当application被销毁时执行销毁
    public void contextDestroyed(ServletContextEvent sce)  { 
    	log.debug("当前应用application被销毁");
    }

}
