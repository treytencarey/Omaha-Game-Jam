package utils;

import java.io.File;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;

import project.Main;

public class FolderReader extends HttpServlet {
	
	File folder;
	
	public FolderReader(String name) {
		folder = new File(Main.context.getRealPath(name));
	}
	
	public String[] getFileList() {
			return folder.list();
	}
}
