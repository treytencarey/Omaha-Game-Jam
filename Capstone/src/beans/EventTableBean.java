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
	 * 
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
	
	public ArrayList<Event> sort(ArrayList<Event> usev) throws ParseException{
		ArrayList<Event> unsorted = (ArrayList<Event>) usev.clone();
		ArrayList<Event> sorted = new ArrayList<Event>();
		
		Event lowEvent = null;
		
		while(unsorted.size() > 0) {
			Date lowEDate = new SimpleDateFormat("MM/dd/yyyy").parse("12/31/3000");
			
			for(Event event : unsorted) {
				Date esd = new SimpleDateFormat("MM/dd/yyyy").parse(event.getStartDate());
				
				if(esd.before(lowEDate)) {
					lowEvent = event;
					lowEDate = esd;
				}
			}
			sorted.add(lowEvent);
			unsorted.remove(lowEvent);
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
	/**
	 * 
	 * @return the second soonest event
	 * @throws ParseException
	 */
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
		
		return sort(pastEvents);
	}
	
	public ArrayList<Event> getFutureEvents() throws ParseException {
		ArrayList<Event> futureEvents = new ArrayList<Event>();
		for(Event event : events) {
			Date eventEndDate = new SimpleDateFormat("MM/dd/yyyy").parse(event.getEndDate());
			
			if(eventEndDate.after(new Date())) {
				futureEvents.add(event);
			}
		}
		
		return sort(futureEvents);
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