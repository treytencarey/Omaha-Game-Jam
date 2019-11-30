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
	 * visiblity of the event, 1 is public, 0 is not
	 */
	private int isPublic;
	
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
	 * The list of mutators for the event
	 */
	private ArrayList<Mutator> mutators = new ArrayList<Mutator>();
	
	/**
	 * Gets an event from the database.
	 * @param PKey an integer value of the event's primary key.
	 */
	public Event(int PKey) {
		
		//Get Event from database
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Events WHERE PKey=" + String.valueOf(PKey));
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> event = query.get(0);
		
		//Get Mutators from database
		List<Map<String, Object>> query2 = Database.executeQuery("SELECT * FROM Mutators WHERE EventPKey=" + String.valueOf(PKey));
		if (query2.size() == 0)
			throw new NullPointerException();
		
		//Initialize mutators list
		for(Map<String, Object> mutator : query2) {
		    mutators.add(new Mutator(
		    				mutator.get("PKey").toString(),
		    				mutator.get("Title").toString(),
		    				mutator.get("Description").toString()
		    			));
		}
		isPublic = (int)event.get("IsPublic");
		key = PKey;
		title = event.get("Title").toString();
		theme = event.get("Theme").toString();
		description = event.get("Description").toString();
		startDate = event.get("StartDate").toString();
		endDate = event.get("EndDate").toString();
	}
	
	/**
	 * Gets an event from the database.
	 * @param PKey a string value of the event's primary key.
	 */
	public Event(String PKey) {
		this(Integer.parseInt(PKey));
	}
	
	/**
	 * Constructs an Event from a row queried from the Events table. Use this if you've already queried the Events table.
	 * @param queryRow A row from the Events table, something contained inside the Object you get after a Database.executeQuery() call.
	 */
	public Event(Map<String, Object> queryRow)
	{	
		this.setVisibility(0);
		this.setKey(Integer.parseInt(queryRow.get("PKey").toString()));
		this.setTitle(queryRow.get("Title").toString());
		this.setTheme(queryRow.get("Theme").toString());
		this.setDescription(queryRow.get("Description").toString());
		this.setStartDate(queryRow.get("StartDate").toString());
		this.setEndDate(queryRow.get("EndDate").toString());
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
		isPublic = 0;
	}

	public void setVisibility(int i) {
		isPublic = i;
	}
	/**
	 * Set title for event
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * Set theme for event
	 */
	public void setTheme(String theme) {
		this.theme = theme;
	}

	/**
	 * Set description for event
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * Set start date for event
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * Set end date for event
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * set pkey for event
	 */
	public void setKey(int key) {
		this.key = key;
	}

	public boolean IsPublic() {
		return (isPublic == 1);
	}
	/**
	 * returns pkey for event
	 */
	public int getKey() {
		return key;
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
	
	/**
	 * returns arraylist of event mutators
	 */
	public ArrayList<Mutator> getMutators(){
		return mutators;
	}
	
	/**
	 * sets event mutators
	 */
	public void setMutators(ArrayList<Mutator> m) {
		mutators = m;
	}
}
