package utils;

import java.time.Year;

public class Utils {
	public static final String PROJNAME = "Capstone Project";
	
	public static int getCurrentYear()
	{
		return Year.now().getValue();
	}
}
