package database;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class GameBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private String id, event, submitter, title, desc, link, isPublic;
	//private boolean isPublic;
	
	public GameBean()
	{
		id = event = submitter = title = desc = link = isPublic = "";
	}
	
	public GameBean(String PKey)
	{
		System.out.println(PKey);
		this.setId(PKey + "");
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + this.getId());
		//System.out.println("this game's id: " + this.getId());
		System.out.println(query);
		System.out.println("size: " + query.size());
		if (query.size() == 0)
			throw new NullPointerException();
		System.out.println(2);
		Map<String, Object> game = query.get(0);
		System.out.println(3);
		
		this.setEvent(game.get("EventPKey").toString());
		this.setSubmitter(game.get("SubmitterPKey").toString());
		this.setTitle(game.get("Title").toString());
		this.setDesc(game.get("Description").toString());
		this.setLink(game.get("PlayLink").toString());
		this.setIsPublic(game.get("IsPublic").toString());
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