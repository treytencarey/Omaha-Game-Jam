package database;

import java.util.List;
import java.util.Map;

/**
 * Represents a single row from the Mutators table. This does not interact with the DB in any way.
 */
public class Mutator{

	private Integer PKey;
	private String title, desc;
	public Mutator(String title, String desc) {
		this.setTitle(title);
		this.setDesc(desc);
	}
	public Mutator(Integer PKey) {
		List<Map<String, Object>> res = Database.executeQuery("SELECT * FROM Mutators WHERE PKey=" + PKey);
		if (res.size() == 0)
			throw new NullPointerException();
		this.setTitle(res.get(0).get("Title").toString());
		this.setDesc(res.get(0).get("Description").toString());
		this.setPKey(PKey);
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
	public Integer getPKey() {
		return PKey;
	}
	public void setPKey(Integer PKey) {
		this.PKey = PKey;
	}
}
