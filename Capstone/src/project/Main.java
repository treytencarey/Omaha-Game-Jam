package project;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class Main implements ServletContextListener
{
	public static ServletContext context;
	
	// MAIN
	public void contextInitialized(ServletContextEvent event) {
		context = event.getServletContext();
	}

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		context = null;
	}
}
