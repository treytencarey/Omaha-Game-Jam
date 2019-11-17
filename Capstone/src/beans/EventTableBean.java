package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Database;
import beans.Event;

/**
 * Model for the DB's Events table, used to retrieve 0..n rows of events.
 */
public class EventTableBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private ArrayList<Event> events = new ArrayList<Event>();
	
	/**
	 * Fetch the events DB's Events table and instantiate an EventTableBean with them.
	 * @param EventPKey the id of the event to get games for.
	 */
	public EventTableBean()
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Events");
        java.util.ListIterator<Map<String, Object>> litr = query.listIterator();
        while(litr.hasNext())
        	events.add(new Event(litr.next()));
	}
	
	// Bean getter / setter
	public ArrayList<Event> getEvents(){
		return events;
	}
	public void setEvents(ArrayList<Event> events) {
		this.events = events;
	}

}