package utils;

import java.time.Year;

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
}
