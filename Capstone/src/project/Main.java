/*! \mainpage Capstone Documentation
 *
 * \section Index_h_Sec1 Welcome
 *
 * Welcome to the Capstone documentation page.<br>
 * 
 *
*/

package project;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 
 * The main method that handles getting the servlet's context.
 * Needed in order to grab context-specific values, such as local files.
 *
 */
public class Main implements ServletContextListener
{
	/**
	 * The context of the servlet.
	 */
	public static ServletContext context;
	
	/**
	 * The initialization of the context.
	 * @param event the servlet event of the context that called the initialization.
	 */
	public void contextInitialized(ServletContextEvent event) {
		context = event.getServletContext();
	}

	/**
	 * The destruction of the context.
	 * @param event the servlet event of the context that called the destruction.
	 */
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		context = null;
	}
}
