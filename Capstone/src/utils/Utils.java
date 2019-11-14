package utils;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;

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
}
