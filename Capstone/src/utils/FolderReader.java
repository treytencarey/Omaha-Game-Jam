package utils;

import java.io.File;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;

public class FolderReader extends HttpServlet {
	
	ServletContext servletContext = getServletContext();
	String path;
	File folder;
	
	public FolderReader(String name) {
		folder = new File(name);
		path = servletContext.getRealPath(name);
	}
	
	public void output() {
		System.out.println(path);
	}
	
	public void listAllFiles() {
		for(final File current : folder.listFiles()) {
			if(current != null) {
				System.out.println(current.getName());
			}
		}
	}
}
