package utils;

import java.io.File;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;

import project.Main;

public class FolderReader extends HttpServlet {
	
	File folder;
	
	public FolderReader(String name) {
		folder = new File(Main.context.getRealPath(name));
		System.out.println(folder);
		if(folder.exists()) {
			System.out.println("Folder Exists");
			if(folder.list().length > 0) {
				System.out.println("Not Empty");
			}
		}
		else
			System.out.println("Folder Does not exist");
	}
	
	public String[] getFileList() {
			return folder.list();
	}
}
