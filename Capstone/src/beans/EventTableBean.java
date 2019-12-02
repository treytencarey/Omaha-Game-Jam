package beans;

import java.io.Serializable;
import java.text.DateFormat;
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

	private ArrayList<Event> sortEvents(ArrayList<Event> toSort, int order) throws ParseException{
		ArrayList<Event> sorted = new ArrayList<Event>();
		Event next = null;
		Date nextDate = null;
		
		if(order > 0)
			nextDate = new SimpleDateFormat("MM/dd/yyyy").parse("12/31/3000");
		else if(order < 0)
			nextDate = new SimpleDateFormat("MM/dd/yyyy").parse("12/31/1900");
		
		while(toSort.size() > 0) {
			for(Event event : toSort) {
				Date eventDate = new SimpleDateFormat("MM/dd/yyyy").parse(event.getStartDate());
				if(order > 0) {
					if(eventDate.before(nextDate)) {
						next = event;
						nextDate = eventDate;
					}
				}
				else if(order < 0) {
					if(eventDate.after(nextDate)) {
						next = event;
						nextDate = eventDate;
					}
				}
			}
			sorted.add(next);
			toSort.remove(next);
		}
		
		
		return sorted;
	}
	/**
	 * Returns the most current event in the Events table
	 */
	public Event getCurrentEvent() throws ParseException {
		Event soonestEvent = new Event();
		Date lowEDate = new SimpleDateFormat("MM/dd/yyyy").parse("12/31/3000");
		
		for(Event event : events) {
			Date date = new SimpleDateFormat("MM/dd/yyyy").parse(event.getStartDate());
			Date enddate = new SimpleDateFormat("MM/dd/yyyy").parse(event.getEndDate());
			
			if(date.compareTo(lowEDate) < 0 && enddate.compareTo(new Date()) > 0) {
				lowEDate = date;
				soonestEvent = event;
			}
		}
		return soonestEvent;
	}
	
	public Event getFutureEvent() throws ParseException {
		Event futureEvent = new Event();
		Date curEDate = new SimpleDateFormat("MM/dd/yyyy").parse(getCurrentEvent().getStartDate());
		Date secondLowestDate = new SimpleDateFormat("MM/dd/yyyy").parse("12/31/3000");
		
		for(Event event : events) {
			Date date = new SimpleDateFormat("MM/dd/yyyy").parse(event.getStartDate());
			
			if(date.compareTo(curEDate) > 0 && date.compareTo(secondLowestDate) < 0) {
				secondLowestDate = date;
				futureEvent = event;
			}
		}
		
		return futureEvent;
	}
	
	public ArrayList<Event> getPastEvents() throws ParseException {
		ArrayList<Event> pastEvents = new ArrayList<Event>();
		for(Event event : events) {
			Date eventEndDate = new SimpleDateFormat("MM/dd/yyyy").parse(event.getEndDate());
			if(eventEndDate.before(new Date())) {
				pastEvents.add(event);
			}
		}
		return sortEvents(pastEvents, -1);
	}
	
	public ArrayList<Event> getFutureEvents() throws ParseException {
		ArrayList<Event> futureEvents = new ArrayList<Event>();
		for(Event event : events) {
			Date eventEndDate = new SimpleDateFormat("MM/dd/yyyy").parse(event.getEndDate());
			
			if(eventEndDate.after(new Date())) {
				futureEvents.add(event);
			}
		}
		return sortEvents(futureEvents, 1);
	}
	
	public void deleteEvent(Event event) {
		List<Map<String, Object>> query = 
				Database.executeQuery("SELECT * FROM Events WHERE PKey=\'"+event.getKey()+"\'");
		
		if (!query.isEmpty()) {
			Database.executeUpdate("DELETE FROM Events WHERE PKey=\'"+event.getKey()+"\'");
			Database.executeUpdate("DELETE FROM Mutators WHERE EventPKey=\'"+event.getKey()+"\'");
		}
	}
}