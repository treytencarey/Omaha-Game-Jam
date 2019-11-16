package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Database;

/**
 * 
 * Handles interactions between the events page on the site and the events table in database.
 *
 */
public class Event {

	/**
	 * The key of the event.
	 */
	private int key;
	
	/**
	 * The title of the event.
	 */
	private String title = "";
	
	/**
	 * The theme of the event.
	 */
	private String theme = "";
	
	/**
	 * The description of the event.
	 */
	private String description = "";
	
	/**
	 * The start date of the event.
	 */
	private String startDate = "";
	
	/**
	 * The end date of the event.
	 */
	private String endDate = "";
	
	/**
	 * Gets an event from the database.
	 * @param PKey an integer value of the event's primary key.
	 */
	public Event(int PKey) {
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Events WHERE PKey=" + String.valueOf(PKey));
	
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> event = query.get(0);
		
		key = PKey;
		title = event.get("Title").toString();
		theme = event.get("Theme").toString();
		description = event.get("Description").toString();
		startDate = event.get("StartDate").toString();
		endDate = event.get("EndDate").toString();
	}
	
	/**
	 * Event constructor with no parameters.
	 */
	public Event() {
		key = -1;
		title = "Unavailable";
		theme = "Unavailable";
		description = "Unavailable";
		startDate = "No Date";
		endDate = "No Date";
	}
	
	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	/**
	 * returns event title
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * returns event theme
	 */
	public String getTheme() {
		return theme;
	}
	
	/**
	 * returns event description
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * returns event start date
	 */
	public String getStartDate() {
		return startDate;
	}
	
	/**
	 * returns event end date
	 */
	public String getEndDate() {
		return endDate;
	}
}
