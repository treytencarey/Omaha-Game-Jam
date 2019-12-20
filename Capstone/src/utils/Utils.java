package utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;

import project.Main;

/**
 * 
 * Handles utilities for consistently getting values.
 *
 */
public class Utils {
	/**
	 * The name of the project.
	 */
	public static final String PROJNAME = "Capstone Project";
	
	/**
	 * Gets the current year.
	 * @return The current year.
	 */
	public static int getCurrentYear()
	{
		return Year.now().getValue();
	}
	
	public static List<String> getFilesInDir(String path)
	{
		List<String> files = new ArrayList<String>();
		
		for (String file : new FolderReader(path).getFileList())
			files.add(file);
		
		return files;
	}
	
	public static String SiteDescription() {
		String sd = "";
		String path = getServerPath("/Uploads/Site/");
		try {
			sd = new String(Files.readAllBytes(Paths.get(path+"\\Site\\sitedescription_body.txt")));
		} catch(IOException e) {
			e.printStackTrace();
		}
		return sd;
	}
	
	private static String getServerPath(String orig) {
		String[] splits = orig.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length -1];
		String pth = Main.context.getRealPath(orig.substring(0, orig.length() - 1 -fileName.length()));
		return pth;
	}
}
