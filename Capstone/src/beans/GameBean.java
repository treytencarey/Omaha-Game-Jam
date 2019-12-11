package beans;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import database.Database;

/**
 * Model for the DB's Games table, used to retrieve a single row when given a Game's ID.
 */
public class GameBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private String id, event, submitter, title, desc, link, status;
	
	/**
	 * Instantiate a new GameBean with blank fields.
	 * This does not interact with the DB in any way.
	 */
	public GameBean()
	{
		id = event = submitter = title = desc = link = status = "";
	}
	
	/**
	 * Fetch the specified game from the DB and instantiate a GameBean with its data.
	 * @param PKey the id of the game to fetch from Games table.
	 */
	public GameBean(String PKey)
	{
		this(Database.executeQuery("SELECT * FROM Games WHERE PKey=" + PKey).get(0));
	}
	
	/**
	 * Constructs a GameBean from a row queried from the Games table. Use this if you've already queried the Games table.
	 * @param queryRow A row from the Games table, something contained inside the Object you get after a Database.executeQuery() call.
	 */
	public GameBean(Map<String, Object> queryRow)
	{	
		this.setId(queryRow.get("PKey").toString());
		this.setEvent(queryRow.get("EventPKey").toString());
		this.setSubmitter(queryRow.get("SubmitterPKey").toString());
		this.setTitle(queryRow.get("Title").toString());
		this.setDesc(queryRow.get("Description").toString());
		this.setLink(queryRow.get("PlayLink").toString());
		this.setStatus(queryRow.get("Status").toString());
	}
	
	/**
	 * @return whether this page is public or not
	 */
	public boolean isPublic()
	{
		return (this.status.equals("2") || this.status.equals("1"));
	}

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the event
	 */
	public String getEvent() {
		return event;
	}
	/**
	 * @param event the event to set
	 */
	public void setEvent(String event) {
		this.event = event;
	}
	/**
	 * @return the submitter
	 */
	public String getSubmitter() {
		return submitter;
	}
	/**
	 * @param submitter the submitter to set
	 */
	public void setSubmitter(String submitter) {
		this.submitter = submitter;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the desc
	 */
	public String getDesc() {
		return desc;
	}
	/**
	 * @param desc the desc to set
	 */
	public void setDesc(String desc) {
		this.desc = desc;
	}
	/**
	 * @return the link
	 */
	public String getLink() {
		return link;
	}
	/**
	 * @param link the link to set
	 */
	public void setLink(String link) {
		this.link = link;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}