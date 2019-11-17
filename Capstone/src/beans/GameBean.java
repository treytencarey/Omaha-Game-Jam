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
	private String id, event, submitter, title, desc, link, isPublic;
	
	/**
	 * Instantiate a new GameBean with blank fields.
	 * This does not interact with the DB in any way.
	 */
	public GameBean()
	{
		id = event = submitter = title = desc = link = isPublic = "";
	}
	
	/**
	 * Fetch the specified game from the DB and instantiate a GameBean with its data.
	 * @param PKey the id of the game to fetch from Games table.
	 */
	public GameBean(String PKey)
	{
		//this.setId(PKey);
//		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + PKey);
//		if (query.size() == 0)
//			throw new NullPointerException();
		this(Database.executeQuery("SELECT * FROM Games WHERE PKey=" + PKey).get(0));
	}
	
	public GameBean(Map<String, Object> queryRow)
	{	
		this.setId(queryRow.get("PKey").toString());
		this.setEvent(queryRow.get("EventPKey").toString());
		this.setSubmitter(queryRow.get("SubmitterPKey").toString());
		this.setTitle(queryRow.get("Title").toString());
		this.setDesc(queryRow.get("Description").toString());
		this.setLink(queryRow.get("PlayLink").toString());
		this.setIsPublic(queryRow.get("IsPublic").toString());
	}
	
	public String getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getSubmitter() {
		return submitter;
	}
	public void setSubmitter(String submitter) {
		this.submitter = submitter;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	
	

}