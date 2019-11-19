package beans;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

	/**
	 * Returns the most current event in the Events table
	 */
	public Event getCurrentEvent() throws ParseException {
		Event soonestEvent = null;
		Date lowEDate = new SimpleDateFormat("dd/MM/yyyy").parse("31/12/3000");
		
		for(Event event : events) {
			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(event.getStartDate());
			if(date.compareTo(lowEDate) < 0) {
				lowEDate = date;
				soonestEvent = event;
			}
		}
		return soonestEvent;
	}
	
	public Event getUpcomingEvent() {
		int upcEPkey;
		return null;
	}
	
	public Event[] getPastEvents() {
		
		return null;
	}
}