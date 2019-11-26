package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Attendee;
import database.Database;
import database.Role;

/**
 * Model for the DB's Attendees table, used to retrieve 0..n rows as AttendeeBean Objects.
 */
public class AttendeeTableBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private ArrayList<Attendee> attendees = new ArrayList<Attendee>();
	
	/**
	 * Instantiate a blank RoleTableBean.
	 */
	public AttendeeTableBean() { }

	
	/**
	 * Fetch all attendees specified by AccountID from the DB's Attendees table. Access these with getAttendees()
	 * @param ids String[] of AccountPKeys to get attendees for.
	 * @return The number of hits.
	 */
	public int fillByAccountIds(String ...ids)
	{
		String query = "SELECT * FROM Attendees WHERE AccountPKey=" + String.join(" OR PKey=", ids);
		return this.fillByQuery(query);
	}
	
	/**
	 * Fetch all attendees specified by EventID from the DB's Attendees table. Access these with getAttendees()
	 * @param ids String[] of EventPKeys to get attendees for.
	 * @return The number of hits.
	 */
	public int fillByEventIds(String ...ids)
	{
		String query = "SELECT * FROM Attendees WHERE EventPKey=" + String.join(" OR PKey=", ids);
		return this.fillByQuery(query);
	}
	
	/**
	 * Execute the query and use the results to fill the attendees ArrayList.
	 * @param query The query to execute with Database.executeQuery()
	 * @return The number of hits.
	 */
	public int fillByQuery(String query)
	{
		List<Map<String, Object>> results = Database.executeQuery(query);
        java.util.ListIterator<Map<String, Object>> litr = results.listIterator();
        while(litr.hasNext())
        {
        	Map<String, Object> temp = litr.next();
        	String apk = temp.get("AccountPKey").toString();
        	String epk = temp.get("EventPKey").toString();
        	attendees.add(new Attendee(apk, epk));
        }
        return results.size();
	}
}